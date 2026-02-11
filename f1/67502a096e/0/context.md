# Session Context

**Session ID:** 1c9632fc-f797-49a8-901c-95079a0fd094

**Commit Message:** When API gateway calls a lambda I do not see it in the logs.

## Prompt

when API gateway calls a lambda I do not see it in the logs.

## Summary

Done. Each invocation now logs:

- **On invoke**: `INFO Invoking CreateOrderFunction (request=abc-123)`
- **On success**: `INFO OK CreateOrderFunction (45ms, request=abc-123)`
- **On error**: `ERROR ERROR CreateOrderFunction (45ms, request=abc-123): error message`
- **On timeout**: `WARNING TIMEOUT CreateOrderFunction after 3000ms (request=abc-123)`

## Key Actions

- - **Task**: Find API Gateway invoke path
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Bash**: Lint and run tests
