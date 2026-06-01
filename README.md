# Shard Yolk Basket

Modern container images for [Pelican](https://pelican.dev) and Pterodactyl game servers.

Clean, layered, and multi-platform. Runtime images stay small. Build tools stay in build images. Every image ships with proper OCI metadata, SBOMs, and provenance attestations.

---

## Choosing An Image

### Java

| Version | Image | Notes |
| --- | --- | --- |
| Java 8 | `ghcr.io/shardbyte/yolks:java_8` | Legacy — Minecraft 1.7.10 through 1.12 and old Forge installers |
| Java 11 | `ghcr.io/shardbyte/yolks:java_11` | Legacy — Minecraft 1.12.1 through 1.16.5 |
| Java 17 | `ghcr.io/shardbyte/yolks:java_17` | Legacy — Minecraft 1.17 through 1.20.4 (also covers 1.17 which needs Java 16+) |
| Java 21 | `ghcr.io/shardbyte/yolks:java_21` | Recommended — most Minecraft and Java game servers |
| Java 25 | `ghcr.io/shardbyte/yolks:java_25` | For servers that explicitly require the latest Java release |

### Node.js

| Version | Image | Notes |
| --- | --- | --- |
| Node.js 20 LTS | `ghcr.io/shardbyte/yolks:nodejs_20` | Runtime only — no npm |
| Node.js 22 LTS | `ghcr.io/shardbyte/yolks:nodejs_22` | Runtime only — no npm |
| Node.js 24 LTS | `ghcr.io/shardbyte/yolks:nodejs_24` | Runtime only — no npm |
| Node.js 20 + npm | `ghcr.io/shardbyte/yolks:nodejs_20-build` | Includes npm and compiler tooling for native addons |

### Python

| Version | Image | Notes |
| --- | --- | --- |
| Python 3.13 | `ghcr.io/shardbyte/yolks:python_3.13` | Includes pip and venv |

### .NET

| Version | Image | Notes |
| --- | --- | --- |
| .NET 9 SDK | `ghcr.io/shardbyte/yolks:dotnet_9` | `linux/amd64` only — nearing end of life |
| .NET 10 SDK | `ghcr.io/shardbyte/yolks:dotnet_10` | Recommended — multi-platform |

### Go

| Version | Image | Notes |
| --- | --- | --- |
| Go 1.24 | `ghcr.io/shardbyte/yolks:go_1.24` | Build image with the Go toolchain |

### Game Servers

| Use Case | Image | Notes |
| --- | --- | --- |
| Generic game server base | `ghcr.io/shardbyte/games:generic` | Common runtime libraries — base for all game images |
| Source engine servers (CS2, TF2, etc.) | `ghcr.io/shardbyte/games:source` | SteamCMD + Source engine libraries — `linux/amd64` only |
| SteamCMD (non-Source servers) | `ghcr.io/shardbyte/steamcmd:debian` | SteamCMD only, no Source engine libraries — `linux/amd64` only |
| Headless Unity servers | `ghcr.io/shardbyte/games:unity` | Unity dedicated server runtime libraries |
| Windows game server binaries | `ghcr.io/shardbyte/games:wine` | Wine 10 compatibility layer — `linux/amd64` only |

### OS Bases

Use these when you need a clean foundation for a custom egg that manages its own application files.

| Base | Image | Notes |
| --- | --- | --- |
| Debian 13 (Trixie) | `ghcr.io/shardbyte/yolks:debian` | Default — modern, small, multi-platform |
| Ubuntu 24.04 (Noble) | `ghcr.io/shardbyte/yolks:ubuntu` | For eggs that require Ubuntu compatibility |
| Alpine 3.21 | `ghcr.io/shardbyte/yolks:alpine` | Lightweight musl-based alternative |
| Debian 13 + build tools | `ghcr.io/shardbyte/yolks:debian-build` | Adds gcc, clang, cmake, ninja, make, and Python 3 |

### Installers

Installer images are for **egg install scripts only** — they run as root and have no entrypoint. Do not use them as a server runtime.

| Use Case | Image |
| --- | --- |
| General install scripts | `ghcr.io/shardbyte/installers:debian` |
| Install scripts needing a JVM | `ghcr.io/shardbyte/installers:java_21` |
| Install scripts that compile .NET solutions | `ghcr.io/shardbyte/installers:dotnet_10` |

---

## Using An Image In Pelican

Set the Docker image in your egg to the image you need, for example:

```text
ghcr.io/shardbyte/yolks:java_21
```

The entrypoint reads your panel's `STARTUP` variable and runs it inside `/home/container`. Panel variables in `{{VARIABLE}}` format are automatically expanded before launch.

All runtime images run as the non-root `container` user by default.

---

## What The Base Image Includes

Every runtime image built on `yolks:debian` includes:

| Tool | Purpose |
| --- | --- |
| `bash` | Shell |
| `curl` / `wget` | Downloads |
| `git` | Repository access |
| `unzip` / `zip` / `xz-utils` | Archive handling |
| `ca-certificates` | TLS trust |
| `iproute2` | Network info (`ip` command) |
| `netcat-openbsd` | Port checks |
| `procps` | Process tools |
| `tini` | Signal handling and zombie reaping |
| `tzdata` / `locales` | Timezone and UTF-8 locale |

---

## Platform Support

| Image group | Platforms |
| --- | --- |
| Most images | `linux/amd64` and `linux/arm64` |
| Source engine, SteamCMD, Wine | `linux/amd64` only |
| .NET 9 | `linux/amd64` only |

---

## For Contributors

Build a single image locally:

```sh
docker buildx bake -f build/docker-bake.hcl java-21
```

Build everything:

```sh
make build-all
```

Print the full Bake definition:

```sh
make bake-print
```

Run repository policy checks:

```sh
make validate
```

CI runs policy validation, ShellCheck, actionlint, hadolint, Bake definition checks, cached image builds, GHCR publishing, SBOMs, and provenance attestations on every push and pull request.

See [`docs/ci.md`](docs/ci.md) for the workflow design, [`docs/image-standards.md`](docs/image-standards.md) for Dockerfile rules, and [`docs/naming.md`](docs/naming.md) for the public naming standard.

---

## Repository Layout

```text
oses/
  debian/              Debian 13 runtime foundation and entrypoint.
  ubuntu/              Ubuntu 24.04 runtime base.
  alpine/              Alpine 3.21 runtime base.
base/
  runtime/             Runtime alias layer (extends oses/debian).
  build/               Build tools and compiler layer (extends oses/debian).
java/
  8/                   Java 8 runtime (Temurin via Adoptium apt, Debian 13).
  11/                  Java 11 runtime (Temurin via Adoptium apt, Debian 13).
  17/                  Java 17 runtime (Temurin via Adoptium apt, Debian 13).
  21/                  Java 21 runtime (OpenJDK, Debian 13).
  25/                  Java 25 runtime (OpenJDK, Debian 13).
nodejs/
  20/                  Node.js 20 runtime.
  22/                  Node.js 22 runtime.
  24/                  Node.js 24 runtime.
  20-build/            Node.js 20 with npm and compiler tooling.
python/
  3.13/                Python 3.13 runtime.
dotnet/
  9/                   .NET 9 SDK (amd64 only).
  10/                  .NET 10 SDK.
go/
  1.24/                Go 1.24 build image.
wine/
  10/                  Wine 10 compatibility runtime.
games/
  generic/             Common game server runtime libraries.
  source/              SteamCMD and Source dedicated server runtime.
  unity/               Headless Unity runtime libraries.
steamcmd/
  debian/              SteamCMD base for non-Source game servers.
installers/
  debian/              Debian 13 installer base.
  java/21/             Java 21 JDK installer base.
  dotnet/10/           .NET 10 SDK installer base.
build/
  docker-bake.hcl      BuildKit bake targets and image graph.
catalog/
  images.yml           Source of truth for all published images.
docs/
  architecture.md      Image hierarchy and design decisions.
  ci.md                CI and publishing workflow notes.
  image-standards.md   Dockerfile standards.
  naming.md            Public image naming rules.
scripts/
  validate.sh          Repository policy checks.
  changed-targets.sh   Changed image detection for CI.
  validate-catalog.py  Catalog consistency validation.
```
