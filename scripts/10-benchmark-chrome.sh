#!/bin/zsh
# scripts/10-benchmark-chrome.sh
# @file 10-benchmark-chrome.sh
# @description Chrome performance baseline: Speedometer 3 (responsiveness) +
#              Lighthouse page loads (simulated throttling = CPU-bound, machine-
#              comparable). Writes exports/benchmarks/chrome-<host>-<date>.md.
#              Run plugged in, lid open, no heavy tasks running. ~5-8 minutes.
set -uo pipefail
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

REPO="$HOME/Development/refineo/code/refineo-laptop-config"
HOST=$(scutil --get LocalHostName 2>/dev/null || hostname -s)
OUT="$REPO/exports/benchmarks/chrome-${HOST}-$(date +%Y%m%d).md"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
[ -x "$CHROME" ] || { echo "ERROR: Chrome not found"; exit 1; }
mkdir -p "$REPO/exports/benchmarks"

echo "==> Chrome version: $("$CHROME" --version)"
echo "==> Speedometer 3 (takes ~3-5 min, headless)..."
SM=$(cd "$REPO/scripts/lib" && npx -y -p puppeteer-core node chrome-bench.mjs 2>/dev/null | grep SPEEDOMETER3 || echo "SPEEDOMETER3_SCORE=FAILED")
echo "    $SM"

echo "==> Lighthouse (distractedlead.com, simulated throttling)..."
LH_JSON=$(mktemp).json
CHROME_PATH="$CHROME" npx -y lighthouse@12 https://distractedlead.com \
  --only-categories=performance --output=json --output-path="$LH_JSON" \
  --chrome-flags="--headless=new" --quiet >/dev/null 2>&1 || true
LH=$(python3 - "$LH_JSON" <<'PY'
import json,sys
try:
    d=json.load(open(sys.argv[1]))
    a=d['audits']
    print(f"score={int(d['categories']['performance']['score']*100)} "
          f"FCP={a['first-contentful-paint']['displayValue']} "
          f"LCP={a['largest-contentful-paint']['displayValue']} "
          f"TBT={a['total-blocking-time']['displayValue']}")
except Exception as e:
    print(f"FAILED ({e})")
PY
)
echo "    $LH"

{
echo "# Chrome benchmark — $HOST — $(date '+%Y-%m-%d %H:%M')"
echo
echo "Chrome: $("$CHROME" --version)"
echo
echo "| Test | Result |"
echo "|---|---|"
echo "| Speedometer 3 | ${SM#SPEEDOMETER3_SCORE=} |"
echo "| Lighthouse perf (distractedlead.com) | $LH |"
} > "$OUT"
echo "Results: $OUT"
