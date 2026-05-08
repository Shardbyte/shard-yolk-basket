# Image Standards

## Dockerfile Rules

- Use BuildKit syntax and cache mounts for apt where practical.
- Use `apt-get install -y --no-install-recommends`.
- Remove `/var/lib/apt/lists/*` in the same layer as package installation.
- Do not run `apt upgrade`, `apt-get upgrade`, or `dist-upgrade`.
- Do not download and install random `.deb` packages in base/runtime images.
- Keep legacy ABI dependencies in dedicated compatibility images.
- Include OCI labels for source, license, revision, and creation date.

## Runtime Rules

- Run as the non-root `container` user.
- Use `/home/container` as the working directory.
- Use `tini -g --` as the entrypoint wrapper.
- Use `SIGINT` as the stop signal for Pelican-compatible shutdown behavior.
- Keep runtime packages narrow and explain additions in the image README when an
  image grows beyond the shared base.

## Build Rules

- Place SDKs, compilers, and toolchains in build images.
- Prefer official package repositories over manual archive downloads.
- Keep language-specific build images separate unless a game image requires a
  documented combined stack.
