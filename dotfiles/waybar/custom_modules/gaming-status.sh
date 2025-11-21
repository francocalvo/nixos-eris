#!/usr/bin/env bash
set -euo pipefail

sunshine_active() {
  systemctl --user is-active --quiet sunshine 2>/dev/null || systemctl is-active --quiet sunshine 2>/dev/null
}

HEADLESS_OUT="$(swaymsg -t get_outputs | jq -r '.[] | select(.name|test("^HEADLESS-")) | select(.active) | .name' | head -n1)"

if [[ -n "${HEADLESS_OUT}" ]] && sunshine_active; then
  echo '{"alt": "Enabled"}'
else
  echo '{"alt": "Disabled"}'
fi

