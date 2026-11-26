#!/usr/bin/env bash
# Tests for bin/redteamlabs. Uses throwaway HTTP servers on test ports.
set -u
cd "$(dirname "$0")/.."
CLI="./bin/redteamlabs"
PASS=0; FAIL=0

check() { # $1 name, $2 condition result (0 ok)
  if [ "$2" = "0" ]; then echo "PASS $1"; PASS=$((PASS+1)); else echo "FAIL $1"; FAIL=$((FAIL+1)); fi
}

# help lists commands
"$CLI" help | grep -q "health"; check "help lists health" $?

# unknown command exits 2
"$CLI" bogus >/dev/null 2>&1; [ "$?" = "2" ]; check "unknown command exits 2" $?

# health fails when nothing listens
REDTEAMLABS_PORTS="18991 18992" "$CLI" health >/dev/null 2>&1; [ "$?" = "1" ]; check "health fails when labs down" $?

# status reports down labs
REDTEAMLABS_PORTS="18991" "$CLI" status | grep -q "status=down"; check "status reports down" $?

# start three throwaway servers, health must pass
PIDS=""
for p in 18080 18081 18082; do
  python3 -m http.server "$p" --bind 127.0.0.1 >/dev/null 2>&1 &
  PIDS="$PIDS $!"
done
sleep 2
REDTEAMLABS_PORTS="18080 18081 18082" "$CLI" health >/dev/null 2>&1; check "health passes when labs up" $?
REDTEAMLABS_PORTS="18080 18081 18082" "$CLI" status | grep -q "status=up"; check "status reports up" $?
# shellcheck disable=SC2086
kill $PIDS 2>/dev/null

# start/stop delegate to systemctl stub
STUB="$(mktemp)"
printf '#!/usr/bin/env bash\necho "stub:$*"\n' > "$STUB"; chmod +x "$STUB"
OUT="$(REDTEAMLABS_SYSTEMCTL="$STUB" "$CLI" start)"
[ "$OUT" = "stub:start wplab wplab2 wplab3" ]; check "start delegates units" $?
OUT="$(REDTEAMLABS_SYSTEMCTL="$STUB" "$CLI" stop)"
[ "$OUT" = "stub:stop wplab wplab2 wplab3" ]; check "stop delegates units" $?
rm -f "$STUB"

echo "passed=${PASS} failed=${FAIL}"
[ "$FAIL" = "0" ]
