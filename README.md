# local-web-services

Polyglot monorepo for the Local Web Services project.

## Structure

```
core/                        ← ldk / lws CLI and server (Python)
lang/
  python/{sdk,example}       ← local-web-services-python-sdk
  typescript/{sdk,example}   ← local-web-services-typescript-sdk
  javascript/{sdk,example}   ← local-web-services-javascript-sdk
  java/{sdk,example}         ← local-web-services-java-sdk
  go/{sdk,example}           ← local-web-services-go-sdk
tools/                       ← repo maintenance scripts
```

## Documentation

**[local-web-services.github.io](https://local-web-services.github.io)**

## Building

```bash
bazel build //...
bazel test //...
```

## Releasing

Each SDK releases independently via a git tag:

| Tag | Publishes to |
|-----|-------------|
| `python-sdk/v*` | PyPI |
| `typescript-sdk/v*` | npm |
| `javascript-sdk/v*` | npm |
| `java-sdk/v*` | GitHub Packages |
| `go-sdk/v*` | GitHub Release |
