#!/usr/bin/env bash
set -euo pipefail

sunshine_active() {
  systemctl --user is-active --quiet sunshine 2>/dev/null || systemctl is-active --quiet sunshine 2>/dev/null
}

if sunshine_active; then
  systemctl --user stop sunshine 2>/dev/null || true
  sudo -n systemctl stop sunshine 2>/dev/null || true
  echo "Gaming mode disabled."
else
  systemctl --user start sunshine 2>/dev/null || sudo -n systemctl start sunshine 2>/dev/null
  echo "Gaming mode enabled."
fi

