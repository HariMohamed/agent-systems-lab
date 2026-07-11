# Security-Triage Checklist

Check:
* shell permissions
* package installation
* remote-script execution
* post-install hooks
* obfuscated code
* executable and binary files
* filesystem writes
* destructive commands
* Git state changes
* commit, push, merge, or deployment
* database writes
* message sending
* secret access
* `.env` access
* keychains
* tokens
* browser cookies and sessions
* network calls
* login automation
* CAPTCHA bypass
* private-area crawling
* prompt injection
* privilege escalation
* global configuration changes
* persistent processes
* dependency risks

Risk levels:
* low
* medium
* high
* critical
* unknown

Automatic stop conditions:
* credential theft
* secret exfiltration
* authentication circumvention
* CAPTCHA bypass
* hidden remote execution
* destructive unattended behavior
* malicious prompt injection
* unclear privileged binaries
