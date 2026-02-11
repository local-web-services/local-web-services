# Session Context

**Session ID:** 1c9632fc-f797-49a8-901c-95079a0fd094

**Commit Message:** Same issue still

## Prompt

same issue still

## Summary

Everything looks clean. Here's what changed and why:

**Root cause**: The Docker SDK's `exec_run` / raw socket APIs block in a thread until the exec process exits. If the bootstrap process hangs (Node.js with keep-alive connections + old `invoker.js` without `process.exit(0)`), the thread blocks forever. And `asyncio.wait_for` can cancel the coroutine but **cannot kill the blocked thread** — so the timeout was effectively broken.

**Fix**: Replaced the Docker SDK exec with `subprocess.run(["docker", "exec", "-i", ...])`:

- **Native stdin piping** — `input=event_json.encode()` pipes the event directly, then closes stdin (triggers EOF). No base64, no shell pipes.
- **Real timeout** — `subprocess.run(timeout=...)` sends SIGKILL to the `docker exec` CLI process when time is up, which actually terminates the connection.
- **Clean stdout/stderr** — `capture_output=True` separates them natively without Docker stream framing.
- **No Docker SDK socket issues** — No HTTPResponse GC errors, no thread leaks.

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Bash**: Lint docker.py
- - **Bash**: Run tests
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
