# Session Context

**Session ID:** 1c9632fc-f797-49a8-901c-95079a0fd094

**Commit Message:** When i run ldk dev for a cdk project the docker containers containing th

## Prompt

when i run ldk dev for a cdk project the docker containers containing the lambda functions are started. should they? I would have thought the fake lambda runtime would start them when needed.

## Summary

All good. Here's a summary of the changes:

1. **Lazy container creation** — `start()` now only validates Docker is reachable. The container is created on first `invoke()` via `_ensure_container()`.

2. **Container killed on timeout** — When a function times out, `_destroy_container()` stops and removes the container. The next invocation will get a fresh container via `_ensure_container()`, mirroring real Lambda behaviour where the execution environment is destroyed on timeout.

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Bash**: Lint the updated docker.py
- - **Bash**: Run tests
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Bash**: Lint and run tests
