<img src="assets/banner.svg" alt="RedTeam Labs" width="100%"/>

# RedTeam Labs

Three local WordPress labs (ports **8080 / 8081 / 8082**) packaged as a
reproducible setup for humans and AI agents. Built and maintained by
**Priyanshu Kumar Thakur**.

## Layout

| Lab | Port | Purpose |
|---|---|---|
| Lab 1 | 8080 | Single-site WordPress — primary plugin testing |
| Lab 2 | 8081 | Single-site WordPress — second rig / comparison |
| Lab 3 | 8082 | WordPress multisite — network-admin class bugs |

## Quick start

```bash
# install systemd units (sudo, systemd hosts)
sudo ./install.sh

# manage labs
./bin/redteamlabs start
./bin/redteamlabs status
./bin/redteamlabs health   # exit 0 only if all labs return HTTP 200
./bin/redteamlabs stop

# web dashboard
python3 web/server.py     # http://127.0.0.1:8090
```

## For AI agents

- The CLI prints stable `key=value` lines (`lab1 port=8080 status=up http=200`)
  and never prompts interactively.
- `GET /api/health` on the dashboard returns JSON:
  `{"labs": [{"lab": 1, "port": 8080, "http": 200, "up": true}], "all_up": true}`.
- Ports and units are overridable via `REDTEAMLABS_PORTS`,
  `REDTEAMLABS_HOST`, and `REDTEAMLABS_UNITS`.

## Docs

- [A–Z Lab Tooling Checklist](docs/A-Z-LAB-TOOLING.md)
- [Hardening Guidance](docs/HARDENING.md)

## Security notes

- Labs bind to `127.0.0.1` only. Do not expose them to a network.
- This repo contains **no credentials**. Set lab admin passwords yourself at
  install time; docs use the placeholder `CHANGE_ME`, which is never a real
  password.

## Tests

```bash
bash tests/test_cli.sh
python3 -m pytest tests/test_web.py -q
```

## License

MIT — Priyanshu Kumar Thakur
