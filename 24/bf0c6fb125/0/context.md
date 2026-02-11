# Session Context

**Session ID:** 1c9632fc-f797-49a8-901c-95079a0fd094

**Commit Message:** I still do not see lambda executions in the logs and docker containers a

## Prompt

I still do not see lambda executions in the logs and docker containers are not stopping when the execution is complete

## Summary

Fixed. The root cause was that `process.stdout.write(data, callback)` with a callback-based `process.exit(0)` can hang when stdout is a pipe and the Node.js event loop has pending async work (like AWS SDK keep-alive connections). The callback never fires, so the process never exits, so `exec_run` blocks forever.

The fix uses `fs.writeFileSync(1, data)` — a synchronous write directly to file descriptor 1 (stdout). This guarantees the data is fully written before `process.exit(0)` is called on the next line. Applied the same pattern to the error path for consistency.

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/invoker.js
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/invoker.js
- - **Bash**: Lint and run tests
