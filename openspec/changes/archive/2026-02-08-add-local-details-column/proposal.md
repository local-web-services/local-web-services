# Change: Add Local Details column to Discovered Resources table

## Why
The Discovered Resources table displayed on `ldk dev` startup shows Type, Name, and Details columns, but the Details column only shows method/handler for API routes and is empty for all other resources. Developers need to see how to access each resource locally (URLs, env vars, CLI commands) without consulting documentation.

## What Changes
- Rename the "Details" column to "Local Details" in the resource summary table
- Show contextual local access information per resource type:
  - API Route: browsable/curl URL (e.g. `http://localhost:3000/orders GET -> handler`)
  - Table (DynamoDB): endpoint URL and env var (`http://localhost:3001 | AWS_ENDPOINT_URL_DYNAMODB`)
  - Function (Lambda): CLI invoke command (`ldk invoke <name>`)
  - Queue (SQS): endpoint URL and env var
  - Bucket (S3): endpoint URL and env var
  - Topic (SNS): endpoint URL and env var
  - Event Bus: endpoint URL and env var
  - State Machine: endpoint URL and env var
  - User Pool: endpoint URL and env var
  - ECS Service: (no local details currently)

## Impact
- Affected specs: cli
- Affected code: `src/lws/cli/display.py`, `src/lws/cli/main.py`
