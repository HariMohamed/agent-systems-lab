import os
import sys
import importlib.util
import yaml

spec = importlib.util.spec_from_file_location("validate_skills", os.path.join(os.path.dirname(__file__), '..', '..', 'scripts', 'validate-skills.py'))
validate_skills = importlib.util.module_from_spec(spec)
sys.modules["validate_skills"] = validate_skills
spec.loader.exec_module(validate_skills)
check_provenance = validate_skills.check_provenance

def run_test(name, yaml_content, expected_status, lifecycle="incubating", expect_error=False):
    prov_file = os.path.join(os.path.dirname(__file__), 'PROVENANCE.yaml')
    with open(prov_file, 'w', encoding='utf-8') as f:
        f.write(yaml_content)

    errors = []
    status = check_provenance(prov_file, errors, "test-skill", lifecycle)

    if lifecycle in ('approved', 'workflow') and status == 'unresolved':
        errors.append(f"[Approval Gate] [test-skill] Skill is in {lifecycle} but provenance is unresolved/missing.")

    if os.path.exists(prov_file):
        os.remove(prov_file)

    if status != expected_status:
        print(f"FAIL: {name} - Expected status {expected_status}, got {status}")
        return False

    if expect_error and not errors:
        print(f"FAIL: {name} - Expected errors but got none")
        return False
    if not expect_error and errors:
        print(f"FAIL: {name} - Expected no errors but got {errors}")
        return False

    print(f"PASS: {name}")
    return True

def main():
    success = True

    # 1. incubating + unresolved
    success &= run_test("1. incubating + unresolved", """
origin: repository_original
evidence:
  status: to_be_verified
""", "unresolved", "incubating", expect_error=False)

    # 2. incubating + verified
    success &= run_test("2. incubating + verified", """
origin: repository_original
evidence:
  status: verified
  type: author_attestation
  reference: ref
""", "verified", "incubating", expect_error=False)

    # 3. approved + verified
    success &= run_test("3. approved + verified", """
origin: repository_original
evidence:
  status: verified
  type: author_attestation
  reference: ref
""", "verified", "approved", expect_error=False)

    # 4. approved + unresolved
    success &= run_test("4. approved + unresolved", """
origin: repository_original
evidence:
  status: to_be_verified
""", "unresolved", "approved", expect_error=True)

    # 5. malformed provenance
    success &= run_test("5. malformed provenance", """
origin: [this is broken yaml
""", "unresolved", "incubating", expect_error=True)

    # 6. unsupported evidence (e.g. git_author type)
    success &= run_test("6. unsupported evidence", """
origin: repository_original
evidence:
  status: verified
  type: git_author
  reference: commit 123
""", "unresolved", "incubating", expect_error=True)

    # 7. repository-original without evidence
    success &= run_test("7. repository-original without evidence", """
origin: repository_original
""", "unresolved", "incubating", expect_error=True)

    # 8. third-party without license evidence
    success &= run_test("8. third-party without license evidence", """
origin: third_party
upstream:
  repository: foo
  commit_or_version: 1.0
review:
  evidence:
    status: verified
    references:
      - link
""", "unresolved", "incubating", expect_error=True)

    # 9. adapted without upstream commit
    success &= run_test("9. adapted without upstream commit", """
origin: adapted
upstream:
  repository: foo
  license: MIT
review:
  evidence:
    status: verified
    references:
      - link
""", "unresolved", "incubating", expect_error=True)

    sys.exit(0 if success else 1)

if __name__ == '__main__':
    main()
