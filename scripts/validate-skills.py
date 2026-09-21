import os
import re
import json
import sys
import yaml

def parse_frontmatter(content):
    content = content.lstrip('\ufeff')
    match = re.match(r'^---\r?\n(.*?)\r?\n---\r?\n(.*)', content, re.DOTALL)
    if not match:
        return None, content

    frontmatter_text = match.group(1)
    body = match.group(2)

    try:
        # Load all documents if there are multiple, return the first one
        docs = list(yaml.safe_load_all(frontmatter_text))
        metadata = docs[0] if docs else {}
    except Exception:
        metadata = {}

    if not isinstance(metadata, dict):
        metadata = {}

    return metadata, body

def check_provenance(prov_file, errors, skill_dir_name, lifecycle_state):
    if not os.path.exists(prov_file):
        errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Missing PROVENANCE.yaml")
        return 'unresolved'

    with open(prov_file, 'r', encoding='utf-8') as f:
        try:
            docs = list(yaml.safe_load_all(f))
            prov_data = docs[0] if docs else {}
        except Exception as e:
            errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Invalid YAML in PROVENANCE.yaml: {e}")
            return 'unresolved'

    if not isinstance(prov_data, dict):
        errors.append(f"[{lifecycle_state}] [{skill_dir_name}] PROVENANCE.yaml is not a dictionary")
        return 'unresolved'

    origin = prov_data.get('origin') or prov_data.get('ownership')
    if not origin:
        errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Missing 'origin' in PROVENANCE.yaml")
        return 'unresolved'

    status = 'verified'

    if origin in ('repository_original', 'repository-original-synthesis'):
        evidence = prov_data.get('evidence', {})
        if not isinstance(evidence, dict) or 'status' not in evidence:
            errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Original claim without evidence block in PROVENANCE.yaml")
            return 'unresolved'
        if evidence.get('status') == 'to_be_verified':
            status = 'unresolved'
        elif evidence.get('status') != 'verified':
            errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Invalid evidence status: {evidence.get('status')}")
            return 'unresolved'
        if status == 'verified':
            if 'reference' not in evidence:
                errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Original claim verified but missing evidence reference")
                return 'unresolved'
            allowed_types = ('author_attestation', 'signed_commit', 'signed_pull_request', 'dated_first_party_creation_record', 'equivalent_first_party_authorship_record')
            if evidence.get('type') not in allowed_types:
                errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Invalid or insufficient evidence type for original claim: {evidence.get('type')}")
                return 'unresolved'

    elif origin in ('third_party', 'third-party', 'adapted'):
        upstream = prov_data.get('upstream', {})
        if not upstream.get('repository') or not upstream.get('commit_or_version') or not upstream.get('license'):
            errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Third-party/adapted missing required upstream fields (repository, commit_or_version, license)")
            return 'unresolved'

        review = prov_data.get('review', {})
        evidence = review.get('evidence', {})
        if not isinstance(evidence, dict) or 'status' not in evidence:
            errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Third-party/adapted claim without review.evidence block")
            return 'unresolved'

        if evidence.get('status') == 'to_be_verified':
            status = 'unresolved'
        elif evidence.get('status') != 'verified':
            errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Invalid evidence status: {evidence.get('status')}")
            return 'unresolved'

        if status == 'verified' and not evidence.get('references'):
            errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Third-party/adapted claim verified but missing evidence references")
            return 'unresolved'

    elif origin == 'unknown':
        status = 'unresolved'

    else:
        errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Unsupported provenance origin: {origin}")
        return 'unresolved'

    return status

def main():
    repo_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    approved_dir = os.path.join(repo_root, 'skills', 'approved')
    incubating_dir = os.path.join(repo_root, 'skills', 'incubating')
    workflows_dir = os.path.join(repo_root, 'workflows')
    agents_skills_dir = os.path.join(repo_root, '.agents', 'skills')
    catalog_path = os.path.join(repo_root, 'catalog', 'active-skills.json')

    errors = []
    canonical_skills = {}
    seen_names = set()

    def process_directory(base_dir, lifecycle_state):
        if not os.path.exists(base_dir):
            return
        for skill_dir_name in os.listdir(base_dir):
            if skill_dir_name.startswith('.'):
                continue
            skill_dir = os.path.join(base_dir, skill_dir_name)
            if not os.path.isdir(skill_dir):
                continue

            is_workflow = (lifecycle_state == 'workflow')
            skill_file = os.path.join(skill_dir, 'WORKFLOW.md' if is_workflow else 'SKILL.md')
            if not os.path.exists(skill_file):
                if not is_workflow:
                    errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Missing SKILL.md")
                continue

            with open(skill_file, 'r', encoding='utf-8') as f:
                content = f.read()

            metadata, body = parse_frontmatter(content)
            if not metadata:
                errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Invalid or missing YAML frontmatter")
                continue

            name = metadata.get('name') or (skill_dir_name if is_workflow else None)
            if not name:
                errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Missing 'name' in frontmatter")
            elif name != skill_dir_name:
                errors.append(f"[{lifecycle_state}] [{skill_dir_name}] 'name' ({name}) does not match directory name")

            if not re.match(r'^[a-z0-9-]+$', name or ''):
                errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Invalid skill name format: {name}")

            if name in seen_names:
                errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Duplicate skill name: {name}")
            seen_names.add(name)

            description = metadata.get('description')
            if not description and not is_workflow:
                errors.append(f"[{lifecycle_state}] [{skill_dir_name}] Missing 'description' in frontmatter")

            prov_status = check_provenance(os.path.join(skill_dir, 'PROVENANCE.yaml'), errors, skill_dir_name, lifecycle_state)

            # Approval Gate Check
            if lifecycle_state in ('approved', 'workflow') and prov_status == 'unresolved':
                errors.append(f"[Approval Gate] [{skill_dir_name}] Skill is in {lifecycle_state} but provenance is unresolved/missing.")

            if lifecycle_state in ('approved', 'workflow'):
                canonical_skills[name] = {
                    'name': name,
                    'category': metadata.get('category', 'workflow' if is_workflow else 'engineering'),
                    'status': 'active',
                    'source': f'{base_dir}/{skill_dir_name}',
                    'purpose': description or 'Unknown',
                    'trigger': metadata.get('trigger', 'Unknown'),
                    'antigravity_compatible': True,
                    'verification_status': 'verified',
                    'provenance_status': prov_status
                }

    process_directory(approved_dir, 'approved')
    process_directory(workflows_dir, 'workflow')

    # We also validate incubating just to ensure structural integrity of PROVENANCE,
    # but unresolved provenance won't cause an approval gate error.
    process_directory(incubating_dir, 'incubating')

    # Check the shared Antigravity/Codex projection for unexpected exposure.
    generated_skills = set()
    if os.path.exists(agents_skills_dir):
        for entry in os.listdir(agents_skills_dir):
            if entry.startswith('.'):
                continue
            if os.path.isdir(os.path.join(agents_skills_dir, entry)):
                generated_skills.add(entry)

    unexpected = generated_skills - set(canonical_skills.keys())
    for u in unexpected:
        errors.append(f"[Projection] Unexpected active skill exposed in .agents/skills/: {u}")

    missing = set(canonical_skills.keys()) - generated_skills
    for m in missing:
        errors.append(f"[Projection] Approved skill missing from .agents/skills/: {m} (Run sync script?)")

    blocked_dirs = set()
    for lifecycle_dir in ('incubating', 'rejected'):
        base = os.path.join(repo_root, 'skills', lifecycle_dir)
        if os.path.isdir(base):
            blocked_dirs.update(name for name in os.listdir(base) if os.path.isdir(os.path.join(base, name)))
    exposed_blocked = blocked_dirs.intersection(generated_skills)
    for name in sorted(exposed_blocked):
        errors.append(f"[Projection] Blocked {name} from incubating/rejected is exposed in .agents/skills/")

    if errors:
        print("Validation failed with errors:")
        for e in errors:
            print(" -", e)
        sys.exit(1)

    print(f"Validation passed. Canonical active skills: {len(canonical_skills)}")

    os.makedirs(os.path.dirname(catalog_path), exist_ok=True)
    with open(catalog_path, 'w', encoding='utf-8') as f:
        json.dump({'skills': list(canonical_skills.values())}, f, indent=2)

    print(f"Generated registry at {catalog_path}")

if __name__ == '__main__':
    main()
