# Building a Load Balancer from Scratch in C

A comprehensive, chapter-wise guide to understanding and building network proxies and load balancers in C.

## Project Structure

```
c-lbs-1/
├── chapter-01-fundamentals/     # Socket programming basics
├── chapter-02-simple-proxy/     # Forward & Reverse proxy
├── chapter-03-load-balancer/    # Multi-backend load balancing
├── chapter-04-advanced-features/ # Health checks, algorithms
├── common/                      # Shared utilities
├── backends/                    # Test backend servers
└── tests/                       # Test scripts
```

## Key Concepts: LB vs RP vs FP

### The Proxy Family Tree

```
                         ┌─────────────────────────────────────────┐
                         │              PROXY                       │
                         │   (Intermediary between two parties)     │
                         └─────────────────┬───────────────────────┘
                                           │
              ┌────────────────────────────┼────────────────────────────┐
              │                            │                            │
              ▼                            ▼                            ▼
    ┌─────────────────┐         ┌─────────────────┐         ┌─────────────────┐
    │ FORWARD PROXY   │         │ REVERSE PROXY   │         │ LOAD BALANCER   │
    │      (FP)       │         │      (RP)       │         │      (LB)       │
    └─────────────────┘         └─────────────────┘         └─────────────────┘
```

---

## 1. Forward Proxy (FP)

**Sits in front of CLIENTS** - Acts on behalf of clients.

```
┌──────────┐     ┌──────────────┐     ┌──────────────┐
│  Client  │────▶│ FORWARD      │────▶│  Internet    │
│  (You)   │     │ PROXY        │     │  (Servers)   │
└──────────┘     └──────────────┘     └──────────────┘
                       │
                 Hides client
                 identity
```

**Use Cases:**
- Corporate networks (filter/monitor employee traffic)
- Bypass geo-restrictions (VPN-like)
- Caching for faster access
- Anonymity (hide client IP)

**Example:** Squid, corporate firewalls, VPNs

**Key Characteristic:** Server doesn't know the real client.

---

## 2. Reverse Proxy (RP)

**Sits in front of SERVERS** - Acts on behalf of servers.

```
┌──────────┐     ┌──────────────┐     ┌──────────────┐
│  Client  │────▶│ REVERSE      │────▶│  Backend     │
│          │     │ PROXY        │     │  Server      │
└──────────┘     └──────────────┘     └──────────────┘
                       │
                 Hides server
                 identity
```

**Use Cases:**
- SSL termination
- Caching static content
- Compression
- Security (WAF)
- Single entry point

**Example:** Nginx, Apache (mod_proxy), Traefik

**Key Characteristic:** Client doesn't know the real server.

---

## 3. Load Balancer (LB)

**Reverse Proxy + Distribution** - Routes to multiple backends.

```
┌──────────┐     ┌──────────────┐     ┌──────────────┐
│          │     │              │────▶│  Backend 1   │
│  Client  │────▶│    LOAD      │     └──────────────┘
│          │     │  BALANCER    │────▶┌──────────────┐
└──────────┘     │              │     │  Backend 2   │
                 └──────────────┘     └──────────────┘
                       │              ┌──────────────┐
                 Distributes    ────▶│  Backend N   │
                 traffic              └──────────────┘
```

**Use Cases:**
- High availability
- Horizontal scaling
- Zero-downtime deployments
- Geographic distribution

**Example:** HAProxy, Nginx, AWS ELB, Traefik

**Key Characteristic:** Multiple backends + distribution algorithm.

---

## Comparison Table

| Aspect | Forward Proxy | Reverse Proxy | Load Balancer |
|--------|---------------|---------------|---------------|
| **Position** | Client-side | Server-side | Server-side |
| **Hides** | Client identity | Server identity | Server identity |
| **Backends** | Any (internet) | Single server | Multiple servers |
| **Primary Goal** | Client privacy/control | Server protection | Traffic distribution |
| **Who configures?** | Client/Admin | Server admin | Server admin |
| **Client aware?** | Yes | No | No |

---

## OSI Layer Operations

```
Layer 7 (Application)  ─── HTTP Load Balancer (content-aware)
                            │ Can inspect: URL, headers, cookies
                            │ Example: Route /api to API servers
                            │
Layer 4 (Transport)    ─── TCP/UDP Load Balancer (connection-aware)
                            │ Can see: IP, Port
                            │ Faster, less overhead
                            │ Example: Database connection pooling
                            │
Layer 3 (Network)      ─── IP Load Balancer (packet-aware)
                            │ Direct routing
                            │ Example: DNS-based load balancing
```

---

## Chapters Overview

| Chapter | Topic | What You Build |
|---------|-------|----------------|
| **01** | Fundamentals | TCP echo server, socket basics |
| **02** | Simple Proxy | Forward proxy, then reverse proxy |
| **03** | Load Balancer | Round-robin across 3 backends |
| **04** | Advanced | Health checks, weighted routing, connection pooling |

---

## Prerequisites

- C compiler (gcc/clang)
- Basic understanding of TCP/IP
- Linux/macOS environment
- Make utility

## Quick Start

```bash
# Build everything
make all

# Run tests
make test

# Chapter 1: Echo server
cd chapter-01-fundamentals && make && ./echo_server 8080

# Chapter 2: Reverse proxy
cd chapter-02-simple-proxy && make && ./reverse_proxy 8080 127.0.0.1 9000

# Chapter 3: Load balancer
cd chapter-03-load-balancer && make && ./load_balancer 8080

# Chapter 4: Advanced LB
cd chapter-04-advanced-features && make && ./advanced_lb 8080
```

## References

- [Giles Thomas - Writing a Reverse Proxy from Ground Up](https://www.gilesthomas.com/2013/08/writing-a-reverse-proxyloadbalancer-from-the-ground-up-in-c-part-1)
- [Beej's Guide to Network Programming](https://beej.us/guide/bgnet/)
- [KodeKloud - Reverse Proxies and Load Balancers](https://notes.kodekloud.com/docs/Linux-Foundation-Certified-System-Administrator-LFCS/Networking/Implement-Reverse-Proxies-and-Load-Balancers)
