# Continuous Integration

The GitHub Actions setup is designed to make image quality visible before any
image becomes trusted by users.

## CI Workflow

`.github/workflows/ci.yml` runs on pull requests, pushes to `main`, and manual
dispatches.

It checks:

- repository modernization policy with `scripts/validate.sh`
- whitespace and executable bits
- shell scripts with ShellCheck
- workflow files with actionlint
- Dockerfiles with hadolint
- Docker Buildx Bake rendering and target listing
- changed image detection with `scripts/changed-targets.sh`
- affected image builds with GitHub Actions cache

Image builds are dependency-aware. For example, a change under `oses/debian/`
builds every image, a change under `base/build/` builds the SDK family,
and a change under `games/generic/` builds the game runtime family. Manual CI
runs build every image. Documentation-only changes skip image builds after the
policy, lint, and Bake definition checks pass.

## Publish Workflow

`.github/workflows/publish.yml` runs on pushes to `main`, version tags, and
manual dispatches.

It publishes images to GHCR using:

- Buildx Bake targets from `build/docker-bake.hcl`
- GitHub Actions cache
- multi-platform builds (`linux/amd64,linux/arm64` by default)
- SBOM attestations
- provenance attestations

The workflow lowercases the GitHub repository owner before composing GHCR image
names so package names remain registry-safe.

## Dependency Maintenance

Dependabot watches GitHub Actions weekly through `.github/dependabot.yml`.
