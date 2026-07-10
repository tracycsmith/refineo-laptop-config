# Old vs New — 2026-07-10

| | Refineo (old) | Tracys-New-MacBook-Pro |
|---|---|---|
| Chip | Apple M5, 10 cores | Apple M5 Pro, 18 cores |
| RAM | 32 GB | 64 GB |
| Python 5M loop | 0.23s | 0.22s |
| Node fib(32) x10 | 0.10s | 0.11s |
| Write 2GB | 0.94s | 0.19s (5x) |
| Read 2GB (cached) | 0.09s | 0.08s |
| 10k small files | 0.91s | 1.42s (*) |
| tar+gzip repo | 0.02s | 0.01s |
| Local git clone | 0.14s | 0.06s |
| Node cold start | 0.04s | 0.03s |

Takeaways: identical single-core (same M5 core gen); wins are +8 cores
(parallel builds/docker), 2x RAM, 5x sequential write.
(*) small-file regression likely Spotlight indexing on day-one machine —
re-run 09-benchmark.sh after a few days to confirm.
