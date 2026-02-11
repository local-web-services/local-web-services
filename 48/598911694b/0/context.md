# Session Context

**Session ID:** 6b92ed86-72b7-49f4-bb7e-f6747825920b

**Commit Message:** === Creating order ===
{
    "status": 502,
    "headers": {
        "da

## Prompt

=== Creating order ===
{
    "status": 502,
    "headers": {
        "date": "Wed, 11 Feb 2026 03:54:43 GMT",
        "server": "uvicorn",
        "content-length": "50",
        "content-type": "application/json"
    },
    "body": {
        "message": "connect ECONNREFUSED 127.0.0.1:3002"
    }
}
Traceback (most recent call last):
  File "<string>", line 1, in <module>
    import sys,json; print(json.load(sys.stdin)['body']['orderId'])
                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
KeyError: 'orderId' from ./test-orders.sh

## Summary

All 1657 tests pass. Two fixes applied:

1. **`routes.py`**: Added `await compute.start()` in `_create_function` so the Docker client is initialized when Terraform creates Lambda functions
2. **`docker.py`**: Function environment variables (like `QUEUE_URL` from Terraform) are now also rewritten from `127.0.0.1`/`localhost` to `host.docker.internal`, same as SDK env vars

Restart `ldk dev`, re-run `terraform apply`, then try `./test-orders.sh` again.

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Bash**: Run make check
