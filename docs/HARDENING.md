# Hardening Guidance

Adapted from Universal Hacker Kit hardening concepts, applied to the labs
themselves and to any WordPress you operate.

## Network exposure
- Bind labs to `127.0.0.1` only. Never expose a test WordPress to the LAN or internet.
- If remote access is ever required, put it behind a VPN and authentication first.

## Least privilege
- Run lab services as an unprivileged user (`www-data`), never root.
- systemd units ship with `NoNewPrivileges=true` and `PrivateTmp=true`.
- WordPress file permissions: directories 755, files 644, `wp-config.php` 600.

## Secrets
- No real passwords in this repo, ever. Docs use the placeholder `CHANGE_ME`.
- Set admin passwords at install time via environment variables; rotate after testing.
- Keep salts/keys unique per lab.

## Updates
- Update WordPress core, themes, and plugins on a schedule; test updates in Lab 1 first.
- Remove unused plugins and themes instead of deactivating them.

## Backups
- Snapshot each lab before a test round; restore after.
- Keep one offline copy of a known-clean lab state.

## Headers & server config (for sites you operate)
- `X-Content-Type-Options: nosniff`
- `X-Frame-Options: SAMEORIGIN` (or CSP `frame-ancestors`)
- `Referrer-Policy: strict-origin-when-cross-origin`
- Content-Security-Policy tuned to the site; start report-only.
- Disable directory listing and PHP execution in upload directories.

## WordPress specifics
- Disable file editing in wp-admin (`DISALLOW_FILE_EDIT`).
- Limit login attempts; enforce strong passwords and 2FA for admins.
- Hide version fingerprints where practical; rely on patching, not obscurity.

## Logging & monitoring
- Enable debug logging in labs; rotate logs.
- Run `redteamlabs health` on a timer; alert on degraded state.

## AI-agent use
- Agents get the same CLI (`status`, `health`) with stable, parseable output.
- Agents never receive real credentials; fixtures use throwaway lab accounts.
