# Change: Add `lws apigateway test-invoke-method` command

## Why
Developers can test API Gateway routes with curl, but it requires knowing the exact URL, method, and body format. An `lws apigateway test-invoke-method` command mirrors the AWS CLI equivalent and provides a discoverable, copy-pasteable command shown directly in the Discovered Resources table.

## What Changes
- Add `lws apigateway` sub-command with `test-invoke-method` operation
- Add API Gateway routes to `/_ldk/resources` discovery metadata
- Update the Local Details column for API routes to show `lws apigateway test-invoke-method` snippets instead of raw URLs

## Impact
- Affected specs: cli
- Affected code: `src/ldk/cli/services/apigateway.py` (new), `src/ldk/cli/lws.py`, `src/ldk/cli/main.py`, `pyproject.toml` (no change), tests
