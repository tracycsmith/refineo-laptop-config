#!/bin/zsh
# scripts/09-benchmark.sh
# @file 09-benchmark.sh
# @description Scripted performance baseline — run identically on any machine,
#              writes exports/benchmarks/<host>-<date>.md for side-by-side compares.
#              Dependency-light: uses only macOS built-ins + node if present.
set -uo pipefail
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"

REPO="$HOME/Development/refineo/code/refineo-laptop-config"
HOST=$(scutil --get LocalHostName 2>/dev/null || hostname -s)
OUT="$REPO/exports/benchmarks/${HOST}-$(date +%Y%m%d).md"
mkdir -p "$REPO/exports/benchmarks"
TMPD=$(mktemp -d)

t() { python3 -c "import time,subprocess,sys; s=time.time(); subprocess.run(sys.argv[1:],capture_output=True); print(f'{time.time()-s:.2f}')" "$@"; }

{
echo "# Benchmark — $HOST — $(date '+%Y-%m-%d %H:%M')"
echo
echo "## System"
echo '```'
sysctl -n machdep.cpu.brand_string
echo "Cores: $(sysctl -n hw.ncpu) | RAM: $(($(sysctl -n hw.memsize)/1073741824)) GB"
sw_vers | head -2
echo '```'
echo
echo "## CPU"
echo "| Test | Result |"
echo "|---|---|"
echo "| SHA256 throughput (openssl, 8KB blocks) | $(openssl speed -seconds 3 sha256 2>/dev/null | grep -E '^sha256' | awk '{print $NF}') |"
echo "| Python: 5M-iteration loop (s) | $(python3 -c 'import time;s=time.time();x=0
for i in range(5_000_000): x+=i*i
print(f"{time.time()-s:.2f}")') |"
if command -v node >/dev/null; then
echo "| Node: fib(32) x10 (s) | $(node -e 'const s=Date.now();const f=n=>n<2?n:f(n-1)+f(n-2);for(let i=0;i<10;i++)f(32);console.log(((Date.now()-s)/1000).toFixed(2))') |"
fi
echo
echo "## Disk ($TMPD)"
echo "| Test | Seconds |"
echo "|---|---|"
echo "| Write 2GB sequential | $(t dd if=/dev/zero of=$TMPD/big bs=1m count=2048) |"
echo "| Read 2GB back | $(t dd if=$TMPD/big of=/dev/null bs=1m) |"
echo "| 10k small-file create+delete | $(python3 -c "
import time,os,shutil
d='$TMPD/small'; os.makedirs(d)
s=time.time()
for i in range(10000): open(f'{d}/{i}.txt','w').write('x'*100)
shutil.rmtree(d); print(f'{time.time()-s:.2f}')") |"
echo
echo "## Real-world"
echo "| Test | Seconds |"
echo "|---|---|"
echo "| Compress repo dir (tar+gzip) | $(t tar czf $TMPD/repo.tgz -C $REPO --exclude=.git --exclude=exports .) |"
echo "| Git: local clone of laptop-config | $(t git clone --quiet $REPO $TMPD/clone) |"
if command -v node >/dev/null; then
echo "| Node cold start (hello world) | $(t node -e 'console.log(1)') |"
fi
} > "$OUT"
rm -rf "$TMPD"
echo "Results: $OUT"
