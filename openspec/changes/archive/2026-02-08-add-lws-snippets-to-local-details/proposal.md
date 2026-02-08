# Change: Show `lws` CLI snippets in Local Details column

## Why
The Discovered Resources table currently shows endpoint URLs and environment variable names for SDK-backed services. Now that `lws` exists, developers would benefit from seeing copy-pasteable `lws` command snippets directly in the table output so they can immediately interact with each resource.

## What Changes
- Replace endpoint URL / env var strings with `lws` CLI command snippets for each resource type
- DynamoDB tables: show `lws dynamodb scan`, `put-item`, `get-item`
- SQS queues: show `lws sqs send-message`, `receive-message`
- S3 buckets: show `lws s3api list-objects-v2`, `put-object`, `get-object`
- SNS topics: show `lws sns publish`, `list-topics`
- EventBridge buses: show `lws events put-events`, `list-rules`
- Step Functions machines: show `lws stepfunctions start-execution`, `list-executions`
- Cognito pools: show `lws cognito-idp sign-up`, `initiate-auth`

## Impact
- Affected specs: cli (Local Details Column requirement)
- Affected code: `src/ldk/cli/main.py` (`_build_local_details`), tests
