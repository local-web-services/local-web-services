# Session Context

**Session ID:** 6b92ed86-72b7-49f4-bb7e-f6747825920b

**Commit Message:** ➜  sample-project-terraform git:(main) ✗ ./test-orders.sh
=== Creating o

## Prompt

➜  sample-project-terraform git:(main) ✗ ./test-orders.sh
=== Creating order ===
{
    "status": 502,
    "headers": {
        "date": "Wed, 11 Feb 2026 03:49:33 GMT",
        "server": "uvicorn",
        "content-length": "70",
        "content-type": "application/json"
    },
    "body": {
        "message": "Docker client not initialized \u2014 call start() first"
    }
}
Traceback (most recent call last):
  File "<string>", line 1, in <module>
    import sys,json; print(json.load(sys.stdin)['body']['orderId'])
                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
KeyError: 'orderId' when running ./test-orders.sh in the terraform sample project

## Summary

All 1657 tests pass. The fix: added `await compute.start()` in `routes.py:_create_function` so the Docker client is initialized when Terraform creates Lambda functions via the management API. This was a pre-existing bug — CDK mode worked because the orchestrator calls `start()` on providers, but Terraform mode's dynamic function creation path skipped it.

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/routes.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/routes.py
- - **Bash**: Run make check and show final results
