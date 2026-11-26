# A–Z Lab Tooling Checklist

Everything a red-team WordPress lab needs, end to end.

## A. Accounts & roles
- [ ] Admin, editor, author, contributor, subscriber test users per lab
- [ ] Passwords set at install time by the operator (never committed)

## B. Browser & proxy
- [ ] Browser with a clean profile per lab
- [ ] Intercepting proxy configured for lab hosts only

## C. CLI
- [ ] `redteamlabs status` / `health` wired into shell aliases or agent tools
- [ ] WP-CLI available for fixture setup

## D. Data fixtures
- [ ] Seed posts, users, and plugin settings per lab
- [ ] Reset script or snapshot to restore a clean state

## E. Evidence
- [ ] Per-finding folder: request/response captures, screenshots, notes
- [ ] Timestamps and lab/version recorded with every capture

## F. Fixtures for access control
- [ ] Two-user rigs (victim/attacker) for IDOR/BOLA tests
- [ ] Role matrix documented per plugin under test

## G. Git hygiene
- [ ] Lab code and notes in version control
- [ ] No secrets, tokens, or real passwords in the repo

## H. Health checks
- [ ] `redteamlabs health` in cron or agent loop
- [ ] Restart policy `Restart=always` on all units

## I. Isolation
- [ ] Labs bound to 127.0.0.1 only
- [ ] No route from labs to production systems

## J. Journal
- [ ] Lab journal: date, target, class, result, dedupe outcome

## K. Knowledge base
- [ ] CVE/patch-diff notes linked to lab evidence

## L. Logging
- [ ] PHP and WordPress debug logs enabled in labs
- [ ] Log rotation so disks never fill

## M. Multisite
- [ ] Lab 3 multisite network for network-admin class bugs

## N. Network
- [ ] Fixed ports 8080/8081/8082 documented
- [ ] Firewall denies inbound from LAN by default

## O. Offline snapshots
- [ ] Tarball snapshot of a clean lab state

## P. Plugin matrix
- [ ] Plugin versions pinned per test round

## Q. Quality gate
- [ ] Reproduce twice before writing a report

## R. Reporting
- [ ] Report template: summary, steps, impact, remediation

## S. Snapshots & backups
- [ ] Pre-test backup, post-test restore

## T. Terminal workflow
- [ ] One-command start/stop/status/health

## U. Updates
- [ ] WordPress, themes, plugins updated on a schedule

## V. Version control of fixtures
- [ ] Fixture changes reviewed like code

## W. Web dashboard
- [ ] `web/server.py` status page for a quick visual check

## X. eXport
- [ ] Evidence export naming: `lab-target-class-date`

## Y. Yield checks
- [ ] Dedupe before deep testing; drop duplicates early

## Z. Zero secrets
- [ ] Placeholder passwords only in docs (`CHANGE_ME`), real ones never stored
