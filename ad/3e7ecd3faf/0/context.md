# Session Context

**Session ID:** 107eef52-dd9f-4d3b-bf73-bbd507f659b3

**Commit Message:** Implement the following plan:

# Plan: Add CLI Commands for All E2E-Test

## Prompt

Implement the following plan:

# Plan: Add CLI Commands for All E2E-Tested Operations + Architecture Test

## Context

E2E tests must exercise the full stack through the `lws` CLI (via `CliRunner`, `lws_invoke`, `assert_invoke`). Currently 8 E2E test files bypass the CLI and make direct `httpx` requests. We need to:
1. Add missing CLI commands so all tested operations have CLI coverage
2. Rewrite all 8 E2E test files to use CLI commands
3. Add an architecture test preventing `httpx` imports in E2E test files

---

## Step 1: Add 13 CLI Commands

### 1A. DynamoDB — 1 command (`src/lws/cli/services/dynamodb.py`)

- `transact-write-items` — `--transact-items` (JSON), `--port`. Uses `json_target_request(_SERVICE, f"{_TARGET_PREFIX}.TransactWriteItems", {"TransactItems": parsed})`.

### 1B. S3 — 4 commands (`src/lws/cli/services/s3.py`)

Add `import json` to the file (currently missing).

- `create-multipart-upload` — `--bucket`, `--key`, `--port`. Uses `rest_request("POST", f"{bucket}/{key}", params={"uploads": ""})`. Output: `xml_to_dict(resp.text)`.
- `upload-part` — `--bucket`, `--key`, `--upload-id`, `--part-number`, `--body` (file path), `--port`. Uses `rest_request("PUT", ...)`. Output: `{"ETag": resp.headers["etag"]}`.
- `complete-multipart-upload` — `--bucket`, `--key`, `--upload-id`, `--multipart-upload` (JSON `{"Parts": [...]}`), `--port`. Converts JSON to XML body, uses `rest_request("POST", ...)`. Output: `xml_to_dict(resp.text)`.
- `abort-multipart-upload` — `--bucket`, `--key`, `--upload-id`, `--port`. Uses `rest_request("DELETE", ...)`.

### 1C. Cognito — 4 commands (`src/lws/cli/services/cognito.py`)

- `forgot-password` — `--user-pool-name`, `--username`, `--port`. Pool-based pattern (resolves `client_id` via `resolve_resource`). Target: `ForgotPassword`.
- `confirm-forgot-password` — `--user-pool-name`, `--username`, `--confirmation-code`, `--password`, `--port`. Same pool-based pattern. Target: `ConfirmForgotPassword`.
- `change-password` — `--access-token`, `--previous-password`, `--proposed-password`, `--port`. Token-based (no pool resolution needed). Target: `ChangePassword`.
- `global-sign-out` — `--access-token`, `--port`. Token-based. Target: `GlobalSignOut`.

### 1D. Lambda — 4 commands (`src/lws/cli/services/lambda_service.py`)

Add `LwsClient` import, `_SERVICE = "lambda"`, and `_client()` helper. New commands use `LwsClient.rest_request("lambda", ...)` (existing `invoke` command left as-is).

- `create-function` — `--function-name`, `--runtime`, `--handler`, `--code` (JSON), `--timeout`, `--port`. `rest_request("POST", "/2015-03-31/functions", body=json_body, headers={"Content-Type": "application/json"})`.
- `create-event-source-mapping` — `--function-name`, `--event-source-arn`, `--batch-size`, `--port`. `rest_request("POST", "/2015-03-31/event-source-mappings", ...)`.
- `list-event-source-mappings` — `--port`. `rest_request("GET", "/2015-03-31/event-source-mappings")`.
- `delete-event-source-mapping` — `--uuid`, `--port`. `rest_request("DELETE", f"/2015-03-31/event-source-mappings/{uuid}")`.

---

## Step 2: Rewrite 8 E2E Test Files

All rewrites follow the standard E2E pattern: `lws_invoke` for Arrange, `runner.invoke(app, [...])` for Act, `assert_invoke` for Assert. Remove all `import httpx` and port-discovery helpers.

### 2A. `tests/e2e/dynamodb/test_dynamodb_transact_condition_check.py` → rename to `test_transact_write_items.py`

- Act: `runner.invoke(app, ["dynamodb", "transact-write-items", "--transact-items", json.dumps([...]), "--port", str(e2e_port)])`
- Assert pass: `exit_code == 0`, verify item written via `assert_invoke(["dynamodb", "get-item", ...])`
- Assert fail: `exit_code == 0` (CLI doesn't fail on 400), parse output JSON for `__type == "TransactionCanceledException"`, verify no item written

### 2B. `tests/e2e/s3api/test_multipart_upload.py` → rename to `test_create_multipart_upload.py`

- Needs `tmp_path` fixture for part body files
- Chain: create-multipart-upload → extract `UploadId` from parsed output → upload-part ×2 (write bytes to temp files, extract ETags) → complete-multipart-upload (pass `{"Parts": [...]}` JSON) → get-object to verify merged content

### 2C. `tests/e2e/cognito_idp/test_forgot_password.py` — rewrite in place

- Use `lws_invoke` for pool/user setup
- Act: `runner.invoke(app, ["cognito-idp", "forgot-password", ...])`
- Assert: parse output for `CodeDeliveryDetails`
- Second Act: `runner.invoke(app, ["cognito-idp", "confirm-forgot-password", "--confirmation-code", "000000", ...])`
- Assert: parse output for `__type == "CodeMismatchException"`

### 2D. `tests/e2e/cognito_idp/test_change_password.py` — rewrite in place

- Arrange: create pool, sign up, confirm, then `lws_invoke(["cognito-idp", "initiate-auth", ...])` to get access token from returned JSON `["AuthenticationResult"]["AccessToken"]`
- Act: `runner.invoke(app, ["cognito-idp", "change-password", "--access-token", token, ...])`
- Assert: `exit_code == 0`, verify new password works via `assert_invoke(["cognito-idp", "initiate-auth", ...new_password...])`

### 2E. `tests/e2e/cognito_idp/test_global_sign_out.py` — rewrite in place

- Same Arrange pattern as 2D to get access token
- Act: `runner.invoke(app, ["cognito-idp", "global-sign-out", "--access-token", token, ...])`
- Assert: `exit_code == 0`

### 2F. `tests/e2e/lambda_/test_lambda_event_source_mapping.py` → rename to `test_create_event_source_mapping.py`

- Act: `runner.invoke(app, ["lambda", "create-event-source-mapping", "--function-name", ..., "--event-source-arn", ..., ...])`
- Assert: extract UUID, verify via `assert_invoke(["lambda", "list-event-source-mappings", ...])`
- Act: `runner.invoke(app, ["lambda", "delete-event-source-mapping", "--uuid", ...])`
- Assert: `exit_code == 0`

### 2G. `tests/e2e/lambda_/test_lambda_s3_integration.py` — rewrite in place

- Replace `httpx.post(f"http://localhost:{lambda_port}/2015-03-31/functions", ...)` with `runner.invoke(app, ["lambda", "create-function", "--function-name", ..., "--runtime", ..., "--handler", ..., "--code", json.dumps(...), "--timeout", "30", "--port", str(e2e_port)])`
- Replace `httpx.post(.../invocations, ...)` with `runner.invoke(app, ["lambda", "invoke", "--function-name", ..., "--event", json.dumps(...), "--port", str(e2e_port)])`
- Remove `import httpx`, `lambda_port = e2e_port + 9`

### 2H. `tests/e2e/lambda_/test_lambda_s3_nodejs_integration.py` — rewrite in place

- Same pattern as 2G but with `nodejs20.x` runtime and `index.handler`

---

## Step 3: Per-Command E2E + Integration Test Files

The `test_cli_command_test_coverage.py` architecture test requires `tests/e2e/<service>/test_<command>.py` and `tests/integration/<service>/test_<command>.py` for every CLI command. New commands need new test files.

### New E2E test files needed (beyond rewrites above)

- `tests/e2e/s3api/test_upload_part.py` — minimal: create bucket, create multipart, upload part, verify exit_code == 0
- `tests/e2e/s3api/test_complete_multipart_upload.py` — minimal: full workflow, verify complete exit_code == 0
- `tests/e2e/s3api/test_abort_multipart_upload.py` — minimal: create multipart, abort, verify exit_code == 0
- `tests/e2e/cognito_idp/test_confirm_forgot_password.py` — minimal: setup pool+user, call confirm with bad code, verify error
- `tests/e2e/lambda_/test_create_function.py` — minimal: create function, verify exit_code == 0 (Docker-gated)
- `tests/e2e/lambda_/test_list_event_source_mappings.py` — minimal: list mappings, verify exit_code == 0
- `tests/e2e/lambda_/test_delete_event_source_mapping.py` — minimal: create then delete mapping, verify exit_code == 0

### Files to delete (replaced by renamed versions)

- `tests/e2e/dynamodb/test_dynamodb_transact_condition_check.py` (→ `test_transact_write_items.py`)
- `tests/e2e/s3api/test_multipart_upload.py` (→ `test_create_multipart_upload.py`)
- `tests/e2e/lambda_/test_lambda_event_source_mapping.py` (→ `test_create_event_source_mapping.py`)

### New integration test stubs

One minimal integration test file per new command under `tests/integration/<service>/`:
- `test_transact_write_items.py`, `test_create_multipart_upload.py`, `test_upload_part.py`, `test_complete_multipart_upload.py`, `test_abort_multipart_upload.py`, `test_forgot_password.py`, `test_confirm_forgot_password.py`, `test_change_password.py`, `test_global_sign_out.py`, `test_create_function.py`, `test_create_event_source_mapping.py`, `test_list_event_source_mappings.py`, `test_delete_event_source_mapping.py`

---

## Step 4: Architecture Test

**New file: `tests/architecture/tests/e2e/test_no_httpx_imports.py`**

- Scans all `test_*.py` files under `tests/e2e/` using AST
- Checks for `import httpx` and `from httpx import ...`
- Ratchet threshold: 0 (all violations fixed)
- `conftest.py` excluded by the `test_*.py` glob pattern
- Error message: "E2E test files must not import httpx. Use the lws CLI (via CliRunner) instead."

---

## Verification

```bash
make check                    # All tests + linting
make test-e2e                 # E2E tests specifically
uv run pytest tests/architecture/ -x -q  # Architecture tests
```


If you need specific details from before exiting plan mode (like exact code snippets, error messages, or content you generated), read the full transcript at: /Users/eamonnfaherty/.REDACTED.jsonl

## Summary

All done. Here's a summary of what was implemented:

**Step 1 — 13 CLI Commands Added:**
- **DynamoDB**: `transact-write-items`
- **S3**: `create-multipart-upload`, `upload-part`, `complete-multipart-upload`, `abort-multipart-upload`
- **Cognito**: `forgot-password`, `confirm-forgot-password`, `change-password`, `global-sign-out`
- **Lambda**: `create-function`, `create-event-source-mapping`, `list-event-source-mappings`, `delete-event-source-mapping`

**Step 2 — 8 E2E Test Files Rewritten** (all `httpx` removed, now use `CliRunner`):
- `test_transact_write_items.py` (renamed from `test_dynamodb_transact_condition_check.py`)
- `test_create_multipart_upload.py` (renamed from `test_multipart_upload.py`)
- `test_forgot_password.py`, `test_change_password.py`, `test_global_sign_out.py`
- `test_create_event_source_mapping.py` (renamed from `test_lambda_event_source_mapping.py`)
- `test_lambda_s3_integration.py`, `test_lambda_s3_nodejs_integration.py`

**Step 3 — New Test Files:**
- 7 new E2E test files (per-command coverage)
- 13 new integration test stubs
- 3 old files deleted (replaced by renamed versions)

**Step 4 — Architecture Test:**
- `tests/architecture/tests/e2e/test_no_httpx_imports.py` — scans all E2E `test_*.py` files for `httpx` imports

**Verification:** `make check` passes — ruff, black, pylint 10/10, all 2125 tests green.

## Key Actions

- - **TaskCreate**: Add CLI commands: dynamodb transact-write-items, s3 create/upload/complete/abort multipart, cognito forgot-password/confirm-forgot-password/change-password/global-sign-out, lambda create-function/create-event-source-mapping/list-event-source-mappings/delete-event-source-mapping
- - **TaskCreate**: Rewrite all 8 E2E test files that currently use httpx to use CLI commands via CliRunner, lws_invoke, assert_invoke
- - **TaskCreate**: Create new E2E test files for individual commands and integration test stubs for all 13 new commands
- - **TaskCreate**: Create tests/architecture/tests/e2e/test_no_httpx_imports.py that scans E2E test files for httpx imports
- - **TaskCreate**: Run make check, make test-e2e, and architecture tests to verify everything passes
- - **TaskUpdate**: 
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/dynamodb.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/s3.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/cognito.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/lambda_service.py
