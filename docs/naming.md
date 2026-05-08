# Image Naming

Shard Yolk Basket publishes user-facing tags that match the conventions Pelican
and Pterodactyl egg authors already recognize.

## Primary Names

Generic runtimes and SDKs use one `yolks` package:

```text
ghcr.io/shardbyte/yolks:<family>_<version>
```

Examples:

```text
ghcr.io/shardbyte/yolks:java_21
ghcr.io/shardbyte/yolks:nodejs_22
ghcr.io/shardbyte/yolks:dotnet_10
ghcr.io/shardbyte/yolks:python_3.13
```

Game-specific runtime images use one `games` package:

```text
ghcr.io/shardbyte/games:<game-or-runtime>
```

Examples:

```text
ghcr.io/shardbyte/games:source
ghcr.io/shardbyte/games:unity
ghcr.io/shardbyte/games:wine
```

## Rules

- Use lowercase image names and tags.
- Use underscores between the family and version: `java_21`, `dotnet_10`.
- Use hyphens only for variants: `nodejs_20-build`.
- Prefer explicit major versions over `latest` for runtimes used by eggs.
- Keep compatibility tags when a migration would otherwise break existing eggs.
- Use `games:<name>` for game-specific or game-family runtime images.
- Use `yolks:<name>` for reusable runtimes, SDKs, installers, and tools.

## Repository Policy

Do not publish project-specific package aliases such as `pelican-base`,
`pelican-game`, or `pelican-sdk`. The public contract should be the familiar
`yolks`, `games`, `installers`, and `steamcmd` namespace model from the start.
