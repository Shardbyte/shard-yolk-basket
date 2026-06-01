group "default" {
  targets = [
    "oses-debian",
    "base-runtime",
    "base-build",
    "oses-ubuntu",
    "oses-alpine",
    "java-8",
    "java-11",
    "java-17",
    "java-21",
    "java-25",
    "nodejs-20",
    "nodejs-22",
    "nodejs-24",
    "nodejs-20-build",
    "python-3-13",
    "dotnet-9",
    "dotnet-10",
    "go-1-24",
    "wine-10",
    "games-generic",
    "games-source",
    "games-unity",
    "steamcmd-debian",
    "installers-debian",
    "installers-java-21",
    "installers-dotnet-10"
  ]
}

variable "REGISTRY" {
  default = "ghcr.io/shardbyte"
}

variable "IMAGE_SOURCE" {
  default = "https://github.com/Shardbyte/shard-yolk-basket"
}

variable "IMAGE_REVISION" {
  default = "local"
}

variable "IMAGE_CREATED" {
  default = "local"
}

variable "PLATFORMS" {
  default = "linux/amd64"
}

# ── OS Debian ────────────────────────────────────────────────────────────────

target "oses-debian" {
  context    = "oses/debian"
  dockerfile = "Dockerfile"
  platforms  = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:debian"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "base-runtime" {
  context    = "base/runtime"
  dockerfile = "Dockerfile"
  contexts = {
    base = "target:oses-debian"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:debian-runtime"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "base-build" {
  context    = "base/build"
  dockerfile = "Dockerfile"
  contexts = {
    base = "target:oses-debian"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:debian-build"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "oses-ubuntu" {
  context    = "oses/ubuntu"
  dockerfile = "Dockerfile"
  contexts = {
    base = "target:oses-debian"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:ubuntu"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "oses-alpine" {
  context    = "oses/alpine"
  dockerfile = "Dockerfile"
  contexts = {
    base = "target:oses-debian"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:alpine"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

# ── Java ─────────────────────────────────────────────────────────────────────

target "java-8" {
  context    = "java/8"
  dockerfile = "Dockerfile"
  contexts = {
    base = "target:oses-debian"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:java_8"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "java-11" {
  context    = "java/11"
  dockerfile = "Dockerfile"
  contexts = {
    base = "target:oses-debian"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:java_11"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "java-17" {
  context    = "java/17"
  dockerfile = "Dockerfile"
  contexts = {
    base = "target:oses-debian"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:java_17"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "java-21" {
  context    = "java/21"
  dockerfile = "Dockerfile"
  contexts = {
    base = "target:oses-debian"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:java_21"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "java-25" {
  context    = "java/25"
  dockerfile = "Dockerfile"
  contexts = {
    base = "target:oses-debian"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:java_25"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

# ── Node.js ───────────────────────────────────────────────────────────────────

target "nodejs-24" {
  context    = "nodejs/24"
  dockerfile = "Dockerfile"
  contexts = {
    base = "target:oses-debian"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:nodejs_24"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "nodejs-20" {
  context    = "nodejs/20"
  dockerfile = "Dockerfile"
  contexts = {
    base = "target:oses-debian"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:nodejs_20"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "nodejs-22" {
  context    = "nodejs/22"
  dockerfile = "Dockerfile"
  contexts = {
    base = "target:oses-debian"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:nodejs_22"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "nodejs-20-build" {
  context    = "nodejs/20-build"
  dockerfile = "Dockerfile"
  contexts = {
    build = "target:base-build"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:nodejs_20-build"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

# ── Python ───────────────────────────────────────────────────────────────────

target "python-3-13" {
  context    = "python/3.13"
  dockerfile = "Dockerfile"
  contexts = {
    generic = "target:games-generic"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:python_3.13"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

# ── .NET ─────────────────────────────────────────────────────────────────────

target "dotnet-9" {
  context    = "dotnet/9"
  dockerfile = "Dockerfile"
  contexts = {
    build = "target:base-build"
  }
  platforms = ["linux/amd64"]
  tags = [
    "${REGISTRY}/yolks:dotnet_9"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "dotnet-10" {
  context    = "dotnet/10"
  dockerfile = "Dockerfile"
  contexts = {
    build = "target:base-build"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:dotnet_10"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

# ── Go ───────────────────────────────────────────────────────────────────────

target "go-1-24" {
  context    = "go/1.24"
  dockerfile = "Dockerfile"
  contexts = {
    build = "target:base-build"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/yolks:go_1.24"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

# ── Wine ─────────────────────────────────────────────────────────────────────

target "wine-10" {
  context    = "wine/10"
  dockerfile = "Dockerfile"
  contexts = {
    generic = "target:games-generic"
  }
  platforms = ["linux/amd64"]
  tags = [
    "${REGISTRY}/games:wine",
    "${REGISTRY}/yolks:wine_10"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

# ── Games ─────────────────────────────────────────────────────────────────────

target "games-generic" {
  context    = "games/generic"
  dockerfile = "Dockerfile"
  contexts = {
    runtime = "target:base-runtime"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/games:generic"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "games-source" {
  context    = "games/source"
  dockerfile = "Dockerfile"
  contexts = {
    generic = "target:games-generic"
  }
  platforms = ["linux/amd64"]
  tags = [
    "${REGISTRY}/games:source"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "games-unity" {
  context    = "games/unity"
  dockerfile = "Dockerfile"
  contexts = {
    generic = "target:games-generic"
  }
  platforms = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/games:unity"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

# ── SteamCMD ──────────────────────────────────────────────────────────────────

target "steamcmd-debian" {
  context    = "steamcmd/debian"
  dockerfile = "Dockerfile"
  contexts = {
    generic = "target:games-generic"
  }
  platforms = ["linux/amd64"]
  tags = [
    "${REGISTRY}/steamcmd:debian"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

# ── Installers ────────────────────────────────────────────────────────────────

target "installers-debian" {
  context    = "installers/debian"
  dockerfile = "Dockerfile"
  platforms  = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/installers:debian"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "installers-java-21" {
  context    = "installers/java/21"
  dockerfile = "Dockerfile"
  platforms  = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/installers:java_21"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}

target "installers-dotnet-10" {
  context    = "installers/dotnet/10"
  dockerfile = "Dockerfile"
  platforms  = split(",", PLATFORMS)
  tags = [
    "${REGISTRY}/installers:dotnet_10"
  ]
  args = {
    IMAGE_SOURCE   = "${IMAGE_SOURCE}"
    IMAGE_REVISION = "${IMAGE_REVISION}"
    IMAGE_CREATED  = "${IMAGE_CREATED}"
  }
}
