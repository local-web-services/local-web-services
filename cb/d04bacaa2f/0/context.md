# Session Context

**Session ID:** 1c9632fc-f797-49a8-901c-95079a0fd094

**Commit Message:** The lambda does not terminate after the function exits

## Prompt

the lambda does not terminate after the function exits

## Summary

Fixed both bootstrap scripts:

- **`invoker.js`** — `process.stdout.write(...)` now takes a callback that calls `process.exit(0)` once the write flushes. This ensures the Node.js process exits even when AWS SDK clients hold keep-alive connections.
- **`python_bootstrap.py`** — Added `sys.stdout.flush()` + `sys.exit(0)` after writing the result, for the same reason.

The error paths in both scripts already called `exit(1)`, so only the success paths needed fixing.

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/invoker.js
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/invoker.js
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/python_bootstrap.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/python_bootstrap.py
- - **Bash**: Lint and run tests
