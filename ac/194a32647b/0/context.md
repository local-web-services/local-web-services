# Session Context

**Session ID:** 204c27fd-464c-4eb1-ab96-fa2d5ad484fa

**Commit Message:** Implement the following plan:

# Plan: Fix S3 Path-Style Addressing in D

## Prompt

Implement the following plan:

# Plan: Fix S3 Path-Style Addressing in Docker Lambda Containers + E2E Test

## Context

When a Step Functions workflow invokes a Lambda function (running in Docker) that calls S3, the request fails with:
```
getaddrinfo ENOTFOUND order-receipts-123456789012-us-east-1.host.docker.internal
```

**Root cause**: AWS SDKs default to virtual-hosted-style S3 addressing, constructing URLs like `bucket-name.host.docker.internal:PORT`. DNS can't resolve this because only `host.docker.internal` is a valid hostname — the bucket prefix makes it invalid.

The Terraform override already sets `s3_use_path_style = true`, but that only affects the Terraform provider — Lambda functions in Docker use the AWS SDK directly and don't inherit that setting.

## Fix 1: Add `AWS_S3_FORCE_PATH_STYLE` to SDK environment

**File**: `src/lws/runtime/sdk_env.py`

In `build_sdk_env()`, when `"s3"` is in the endpoints dict, add `AWS_S3_FORCE_PATH_STYLE=true` to the returned env vars. This is the [official AWS SDK standard setting](https://docs.aws.amazon.com/sdkref/latest/guide/setting-global-s3_use_path_style.html) supported by AWS SDK for JavaScript v3, boto3/botocore, and AWS CLI v2.

```python
# After the endpoint loop, add:
if "s3" in endpoints:
    env["AWS_S3_FORCE_PATH_STYLE"] = "true"
```

This env var flows through `_build_container_env()` in `docker.py` (which copies `sdk_env` into container env) and gets rewritten from `localhost` to `host.docker.internal`.

## Fix 2: Write AWS config file for legacy boto3 compatibility

**File**: `src/lws/providers/lambda_runtime/python_bootstrap.py`

Older boto3 versions may not support `AWS_S3_FORCE_PATH_STYLE`. Add a helper that writes `~/.aws/config` with `addressing_style = path` inside the container before loading the handler. Only activate when `AWS_ENDPOINT_URL_S3` is set (indicating local development).

```python
def _configure_s3_path_style():
    """Write AWS config for path-style S3 when using a local endpoint."""
    if not os.environ.get("AWS_ENDPOINT_URL_S3"):
        return
    config_dir = os.path.expanduser("~/.aws")
    os.makedirs(config_dir, exist_ok=True)
    config_file = os.path.join(config_dir, "config")
    if not os.path.exists(config_file):
        with open(config_file, "w") as f:
            f.write("[default]\ns3 =\n    addressing_style = path\n")
```

Call `_configure_s3_path_style()` at the top of `main()`, before `_maybe_attach_debugger()`.

Node.js SDK v3 already supports `AWS_S3_FORCE_PATH_STYLE` natively, so `invoker.js` does not need changes.

## Fix 3: E2E test for Lambda → S3 integration

**File**: `tests/e2e/lambda_/test_lambda_s3_integration.py` (new)

This test verifies that a Lambda function in Docker can successfully write to S3 using path-style addressing. Requires Docker daemon running and the Python Lambda base image pulled.

### Test flow (AAA pattern):

**Arrange:**
1. Create an S3 bucket via `lws_invoke(["s3api", "create-bucket", ...])`
2. Create a temp directory with a Python handler (`handler.py`) that uses boto3 to `put_object`
3. Create a Lambda function via HTTP POST to the Lambda management API (`http://localhost:{lambda_port}/2015-03-31/functions`) with `Code.Filename` pointing to the temp handler directory

**Act:**
4. Invoke the Lambda via `lws lambda invoke --function-name ... --event '{"bucket":"...", "key":"..."}'`

**Assert:**
5. Verify the S3 object exists via `assert_invoke(["s3api", "get-object", ...])`

### Skip conditions:
- `@pytest.mark.skipif` if Docker daemon is not reachable (`docker info` fails)
- `@pytest.mark.skipif` if `public.ecr.aws/lambda/python:3.12` image not available locally

### Key details:
- Lambda management API port: `e2e_port + 9` (based on terraform port allocation in `ldk.py`)
- Handler code needs `boto3` — available in the Lambda Python base image
- The `Code.Filename` field accepts an absolute directory path (see `_resolve_code_path` in `routes.py:137`)
- Use unique resource names (`e2e-lambda-s3-bucket`, `e2e-s3-writer`) per E2E naming conventions

### Handler code (`handler.py`):
```python
import boto3
import os

def handler(event, context):
    s3 = boto3.client("s3")
    s3.put_object(
        Bucket=event["bucket"],
        Key=event["key"],
        Body=event.get("body", "hello from lambda").encode(),
    )
    return {"statusCode": 200, "bucket": event["bucket"], "key": event["key"]}
```

## Files changed

| File | Change |
|------|--------|
| `src/lws/runtime/sdk_env.py` | Add `AWS_S3_FORCE_PATH_STYLE=true` when S3 endpoint present |
| `src/lws/providers/lambda_runtime/python_bootstrap.py` | Write `~/.aws/config` with path-style for legacy boto3 |
| `tests/e2e/lambda_/test_lambda_s3_integration.py` | New E2E test: Lambda → S3 path-style verification |
| `tests/unit/runtime/test_sdk_env.py` | Update unit test to verify new env var |

## Verification

```bash
# Run the specific e2e test (requires Docker + Lambda image)
uv run pytest tests/e2e/lambda_/test_lambda_s3_integration.py -v

# Run full e2e suite
make test-e2e

# Run full check suite
make check
```


If you need specific details from before exiting plan mode (like exact code snippets, error messages, or content you generated), read the full transcript at: /Users/eamonnfaherty/.REDACTED.jsonl

## Summary

All four changes are complete. Here's a summary:

## Changes Made

### Fix 1: `src/lws/runtime/sdk_env.py`
Added `AWS_S3_FORCE_PATH_STYLE=true` to the SDK environment when an S3 endpoint is present. This is the official AWS SDK setting that forces path-style addressing (`http://host:port/bucket/key`) instead of virtual-hosted-style (`http://bucket.host:port/key`), which fails inside Docker containers.

### Fix 2: `src/lws/providers/lambda_runtime/python_bootstrap.py`
Added `_configure_s3_path_style()` that writes `~/.aws/config` with `addressing_style = path` inside the container for legacy boto3 compatibility. Called at the top of `main()` before `_maybe_attach_debugger()`. Only activates when `AWS_ENDPOINT_URL_S3` is set and no existing config file is present.

### Fix 3: `tests/e2e/lambda_/test_lambda_s3_integration.py` (new)
E2E test that verifies a Lambda function running in Docker can write to S3 using path-style addressing. Creates an S3 bucket, registers a Python Lambda via the management API, invokes it with an event, and verifies the object was written. Automatically skips if Docker or the Lambda Python image isn't available.

### Fix 4: `tests/unit/runtime/test_sdk_env.py`
Added two unit tests: one verifying `AWS_S3_FORCE_PATH_STYLE` is set when S3 is in endpoints, and one verifying it's absent when S3 is not in endpoints. All 7 tests pass.

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/runtime/sdk_env.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/python_bootstrap.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/unit/runtime/test_sdk_env.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/contributing/testing/END_TO_END.md
- - **Glob**: tests/e2e/lambda_/**/*.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/e2e/lambda_/test_invoke.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/e2e/lambda_/__init__.py
- - **Glob**: tests/e2e/conftest.py
- - **Grep**: _resolve_code_path
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/e2e/conftest.py
