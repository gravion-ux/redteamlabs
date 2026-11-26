#!/usr/bin/env bash
# Install redteamlabs systemd units. Run with sudo on a systemd host.
# No credentials are created here. Set lab admin passwords yourself via
# environment variables at provisioning time (placeholder: CHANGE_ME).
set -eu

SRC_DIR="$(cd "$(dirname "$0")/systemd" && pwd)"
DEST_DIR="/etc/systemd/system"

for unit in wplab wplab2 wplab3; do
  install -m 0644 "${SRC_DIR}/${unit}.service" "${DEST_DIR}/${unit}.service"
  echo "installed ${unit}.service"
done

systemctl daemon-reload
systemctl enable wplab wplab2 wplab3
echo "units enabled. Start with: redteamlabs start"
echo "Reminder: create each WordPress install with a strong admin password"
echo "you choose at install time (placeholder CHANGE_ME is never a real password)."
