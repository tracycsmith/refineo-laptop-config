# Benchmark — Tracys-New-MacBook-Pro — 2026-07-10 15:38

## System
```
Apple M5 Pro
Cores: 18 | RAM: 64 GB
ProductName:		macOS
ProductVersion:		26.5.2
```

## CPU
| Test | Result |
|---|---|
| SHA256 throughput (openssl, 8KB blocks) |  |
| Python: 5M-iteration loop (s) | 0.22 |
| Node: fib(32) x10 (s) | 0.11 |

## Disk (/var/folders/w2/0p0jymds3rg9756w5hjzcky80000gn/T/tmp.WZ3XCnzC1i)
| Test | Seconds |
|---|---|
| Write 2GB sequential | 0.19 |
| Read 2GB back | 0.08 |
| 10k small-file create+delete | 1.42 |

## Real-world
| Test | Seconds |
|---|---|
| Compress repo dir (tar+gzip) | 0.01 |
| Git: local clone of laptop-config | 0.06 |
| Node cold start (hello world) | 0.03 |
