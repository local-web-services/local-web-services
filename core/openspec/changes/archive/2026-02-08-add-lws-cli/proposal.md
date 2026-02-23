# Change: Add `lws` CLI for AWS CLI-style local resource interaction

## Why
Interacting with local LDK resources currently requires verbose curl/SDK calls with correct headers, ARNs, and wire protocols. Developers want AWS CLI-style commands that use CDK construct names and let the CLI handle endpoint discovery, ARN resolution, and wire protocol details.

## What Changes
- Add a new `lws` CLI binary (Typer app) that mirrors AWS CLI command structure
- Add a `GET /_ldk/resources` management API endpoint for resource discovery
- Add a shared `LwsClient` class for discovery and per-protocol HTTP helpers
- Add service sub-commands: stepfunctions, sqs, sns, s3api, dynamodb, events, cognito-idp
- Add `httpx` as a main dependency (currently dev-only)

## Impact
- Affected specs: cli
- Affected code: `src/lws/cli/lws.py`, `src/lws/cli/services/`, `src/lws/api/management.py`, `pyproject.toml`
