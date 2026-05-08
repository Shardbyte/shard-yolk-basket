# Architecture

The modernization moves the yolk ecosystem from legacy all-in-one images to a
layered image family with narrow responsibilities.

## Image Families

```text
oses/debian                         Minimal Debian 13 root image
  base/runtime                      Runtime alias layer
    games/generic                   Common game server libraries
      games/source                  amd64 SteamCMD and Source engine runtime
      games/unity                   Headless Unity runtime libraries
      steamcmd/debian               amd64 SteamCMD base (non-Source game servers)
      python/3.13                   Python 3.13 runtime
      wine/10                       amd64 Wine 10 compatibility runtime
  base/build                        Compiler and build tooling layer
    dotnet/9                        .NET 9 SDK (amd64 only)
    dotnet/10                       .NET 10 SDK
    nodejs/20-build                 Node.js 20 with npm and compilers
    go/1.24                         Go 1.24 build image
  java/21                           OpenJDK 21 runtime
  java/25                           OpenJDK 25 runtime
  nodejs/20                         Node.js 20 runtime (Debian 13 apt)
  nodejs/22                         Node.js 22 runtime (official upstream)
  nodejs/24                         Node.js 24 runtime (official upstream)

# Standalone OS bases (external upstream, not derived from oses/debian)
oses/ubuntu                         Ubuntu 24.04 runtime base
oses/alpine                         Alpine 3.21 runtime base

# Standalone runtimes (external upstream images)
java/17                             Eclipse Temurin 17 JRE (Ubuntu Noble)

# Installer images (egg install scripts only — run as root, no entrypoint)
installers/debian                   Debian 13 with curl, wget, git, jq
installers/java/21                  Java 21 JDK for install-time JVM needs
installers/dotnet/10                .NET 10 SDK for compiling solutions at install time

# Planned
legacy compatibility images         Isolated, explicitly documented (Debian 12)
```

## Public Naming

The primary public image names follow the familiar Pelican/Pterodactyl style:

- reusable runtimes and SDKs: `ghcr.io/shardbyte/yolks:<family>_<version>`
- game-specific runtimes: `ghcr.io/shardbyte/games:<name>`
- SteamCMD bases: `ghcr.io/shardbyte/steamcmd:<name>`
- egg install scripts only: `ghcr.io/shardbyte/installers:<name>`

Examples include `yolks:java_21`, `yolks:nodejs_22`, `yolks:dotnet_10`,
`games:source`, `steamcmd:debian`, and `installers:java_21`.

## Base Images

Modern base images use Debian 13 (`trixie-slim`) and provide only the common
runtime foundation required by Pelican-hosted game servers:

- non-root `container` user
- UTF-8 locale
- `tini` signal handling
- basic archive, network, process, and certificate tooling
- OCI labels

They must not include compilers, SDKs, obsolete ABI packages, or game-specific
dependencies.

## Build Images

Build images may include compilers, SDKs, package managers, and debugging tools.
They are for build, restore, publish, and diagnostic workflows. They should not
be the default runtime image for hosted servers.

The first SDK image is `.NET 10` because Microsoft's Debian 13 package feed
publishes .NET 10 for both x64 and Arm64. .NET 9 needs a separate compatibility
decision because the Debian package feed is x64-only for .NET 9.

The Node image is intentionally runtime-only. Debian's `npm` package pulls in a
large build/tooling graph, so package-manager workflows should live in a
separate Node build image instead of the runtime layer.

Java 21 is the default modern Java runtime. Java 25 is available as an explicit
newer runtime for workloads that have tested against it. Debian 13 does not ship
OpenJDK 17, so Java 17 must be handled as a separate compatibility image with an
explicit trust and update policy rather than mixed into the modern Trixie base.

Node 20 is the Debian 13 native runtime. Node 22 and Node 24 use the official
Node `trixie-slim` images and import the same Pelican entrypoint behavior so
users can choose a newer LTS line without waiting on Debian's package cadence.

SteamCMD, Source, and Wine images are `linux/amd64` only because their practical
server workloads and i386 compatibility libraries are amd64-centered. Other
modern images remain multi-platform when their upstream packages support both
x64 and Arm64.

`steamcmd:debian` provides a minimal SteamCMD base for game servers that
download via SteamCMD but do not need Source-engine libraries. `games:source`
extends it with the full Source-engine i386 compatibility layer.

## Legacy Compatibility

Legacy compatibility images are explicit opt-in images for binaries that require
old ABI surfaces such as `libssl1.1` or older ICU libraries. Those dependencies
must remain isolated and documented in the image that requires them.

Modern runtime images must not globally install old Ubuntu `.deb` packages or
obsolete compatibility libraries.
