# Session Context

**Session ID:** b578e9a4-a0ec-4d76-9e5a-5a46286171ec

**Commit Message:** Implement the following plan:

# Plan: Fix E2E Test Failures

## Context

## Prompt

Implement the following plan:

# Plan: Fix E2E Test Failures

## Context

`make test-e2e` has 22 failures and 1 error across 4 root causes. The e2e tests start `ldk dev --mode terraform` and exercise CLI commands against it.

## Root Causes

### 1. Service name mismatch in terraform mode (7 cognito + 7 events = 14 tests)

The terraform `ports` dict in `src/lws/cli/ldk.py:501-515` uses `"cognito"` and `"eventbridge"`, but the CLI expects `"cognito-idp"` and `"events"` (matching CDK mode's `_service_ports()` at line 1294).

### 2. CLI commands exit on missing resource metadata (5 SQS + 1 SNS = 6 tests)

Commands like `sqs send-message` and `sns publish` call `client.resolve_resource()` to get resource metadata (queue_url, topic ARN). In terraform mode, metadata is initialized with empty resource lists (`ldk.py:451`). When `resolve_resource` raises `DiscoveryError`, these commands call `exit_with_error()` instead of constructing defaults.

Step Functions `start-execution` already handles this correctly with a try/except fallback — use the same pattern.

### 3. S3 test response parsing bugs (2 tests)

`test_list_buckets.py` does `.get("Buckets", [])` but the actual XML-to-dict output is nested: `{"ListAllMyBucketsResult": {"Buckets": {"Bucket": ...}}}`. Same issue in `test_list_objects_v2.py` accessing `{"Contents": ...}` instead of `{"ListBucketResult": {"Contents": ...}}`.

### 4. StepFunctions start-execution ERROR (1 test)

Pytest ERROR (likely fixture teardown), not a test failure. The command already has an ARN fallback. Investigate the specific error during implementation.

## Fixes

### Fix 1: Rename terraform ports keys

**File:** `src/lws/cli/ldk.py`

In `_create_terraform_providers` (line 501), change:
- `"cognito"` → `"cognito-idp"`
- `"eventbridge"` → `"events"`

Update all `ports[...]` lookups in that function and `_register_http_providers` to use the new keys. The `local_endpoints` dict (line 555) already uses the correct AWS service names — just update the dict lookups from `ports['cognito']` → `ports['cognito-idp']` etc.

### Fix 2: Add resource fallbacks to CLI commands

Use the same pattern as `src/lws/cli/services/stepfunctions.py:31-37` which already handles this correctly:

```python
try:
    resource = await client.resolve_resource(_SERVICE, name)
    value = resource.get("key", "default")
except Exception:
    value = "default"
```

**Files to update:**

| File | Functions to fix | Fallback |
|------|-----------------|----------|
| `src/lws/cli/services/sqs.py` | `_send_message`, `_receive_message`, `_purge_queue`, `_get_queue_attributes`, `_delete_message` | Construct `queue_url = f"http://localhost:{port}/000000000000/{name}"` via `client.service_port()` |
| `src/lws/cli/services/sns.py` | `_publish` | Construct `arn = f"arn:aws:sns:us-east-1:000000000000:{name}"` (value already inline, just fix exception handling) |

### Fix 3: Fix S3 test response parsing

| File | Fix |
|------|-----|
| `tests/e2e/s3api/test_list_buckets.py` | Navigate `{"ListAllMyBucketsResult": {"Buckets": {"Bucket": ...}}}`, handle single-item dict vs list |
| `tests/e2e/s3api/test_list_objects_v2.py` | Navigate `{"ListBucketResult": {"Contents": ...}}`, handle single-item dict vs list |

### Fix 4: StepFunctions start-execution

Investigate and fix the pytest ERROR (likely fixture/teardown).

## Verification

```bash
make test-e2e   # all ~70 tests pass
make check      # all 6 checks still pass
```


If you need specific details from before exiting plan mode (like exact code snippets, error messages, or content you generated), read the full transcript at: /Users/eamonnfaherty/.REDACTED.jsonl

## Summary

Here's a summary of everything done:

## E2E Fix Summary

**All 69 e2e tests now pass** (from 22 failures + 1 error). **All 1732 `make check` tests pass.**

### Fixes Applied

**1. Service name mismatch in terraform mode** (`src/lws/cli/ldk.py`)
- Renamed `"eventbridge"` → `"events"` and `"cognito"` → `"cognito-idp"` in the terraform `ports` dict
- Updated all references in `_create_terraform_providers`, `_register_http_providers`, and the CDK mode's `_create_providers` call site
- Updated corresponding unit tests

**2. CLI commands exit on missing resource metadata** (`src/lws/cli/services/sqs.py`, `sns.py`, `cognito.py`)
- Changed `_send_message`, `_receive_message`, `_delete_message`, `_get_queue_attributes` in SQS to construct default queue URLs via `service_port()` on fallback
- Changed `_publish` in SNS to use default ARN on fallback
- Changed `_sign_up`, `_confirm_sign_up`, `_initiate_auth` in Cognito to use default client_id on fallback

**3. S3 test response parsing** (`tests/e2e/s3api/test_list_buckets.py`, `test_list_objects_v2.py`)
- Fixed to navigate the XML-to-dict nested structure (`ListAllMyBucketsResult.Buckets.Bucket`, `ListBucketResult.Contents`)
- Handled single-item dict vs list

**4. Cognito provider not started in terraform mode** (`src/lws/cli/ldk.py`)
- Added `providers["__cognito_default__"] = cognito_provider` so the orchestrator calls `start()` to initialize the SQLite database

**5. Cognito CreateUserPool/DeleteUserPool stubs** (`src/lws/providers/cognito/routes.py`)
- `_create_user_pool` now updates `config.user_pool_name`
- `_delete_user_pool` clears the pool name so `_list_user_pools` returns empty

**6. Fixture teardown timeout** (`tests/e2e/conftest.py`)
- Added try/except with `proc.kill()` fallback for `proc.wait()` timeout

### Architecture Tests Created

**`test_service_name_consistency.py`** — 2 tests:
- Terraform ports keys must be a superset of CDK mode's `_service_ports` keys
- Terraform ports must not use internal names like `"cognito"` or `"eventbridge"`

**`test_cli_resolve_resource_fallback.py`** — 1 test:
- CLI commands must not call `exit_with_error` after `resolve_resource` failure (must use try/except fallback instead)

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/ldk.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/sqs.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/sns.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/stepfunctions.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/e2e/s3api/test_list_buckets.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/e2e/s3api/test_list_objects_v2.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/ldk.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/e2e/stepfunctions/test_start_execution.py
- - **Glob**: tests/e2e/conftest.py
- - **Grep**: def _register_http_providers
