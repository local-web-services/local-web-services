# Change: Implement Phase 1 Core Runtime

## Why
Phase 0 established the foundation with basic Node.js Lambda execution, API Gateway routing, and a minimal DynamoDB provider. Phase 1 expands LDK into a comprehensive local development environment by adding Python Lambda support, full SQS/S3/SNS provider implementations, enhanced DynamoDB capabilities (GSI, streams, expressions, eventual consistency), and developer experience polish (structured logging, CLI commands, configuration).

## What Changes
- **Expanded Compute**: Python Lambda subprocess runner with `asyncio.create_subprocess_exec` and a bootstrap script, debugpy integration for Python debugging, realistic Lambda context object with countdown timer, timeout enforcement with process termination, and CloudFormation intrinsic function resolution for environment variables
- **SQS Provider**: In-memory queue with `asyncio.Lock` concurrency safety and aiosqlite persistence, SendMessage/ReceiveMessage/DeleteMessage API endpoints, Lambda event source mapping poller, dead letter queue routing, FIFO queue semantics with message group ordering and deduplication
- **S3 Provider**: Filesystem-backed object storage at `<data_dir>/s3/<bucket>/<key>` with metadata sidecar JSON files, PutObject/GetObject/DeleteObject/ListObjectsV2 API endpoints, S3 event notifications to Lambda handlers, presigned URL generation and validation
- **SNS Provider**: Topic registry and Publish operation with fan-out, SNS API endpoint, SNS-to-Lambda subscription dispatch, SNS-to-SQS subscription routing, subscription filter policy evaluation
- **Enhanced DynamoDB**: Global secondary index support with SQLite indexes, FilterExpression and UpdateExpression parsers, BatchGetItem/BatchWriteItem operations, DynamoDB Streams with Lambda event source mapping, eventual consistency simulation with configurable delay, aiosqlite persistence hardening
- **Developer Experience**: Structured logging framework with Rich/colorama, SDK call instrumentation with contextvars, end-to-end request flow tracing, error logging with full context, hot reload logging, CDK change detection with incremental apply, SQS state persistence, `ldk invoke` and `ldk reset` CLI commands, management API, graceful shutdown with state flush, `ldk.yaml` configuration file support

## Impact
- Affected specs: lambda-runtime, sqs-provider, s3-provider, sns-provider, dynamodb-provider, logging, cli, hot-reload
- Affected code: All provider implementations, runtime execution layer, CLI commands, logging framework, configuration system
- No breaking changes to existing Phase 0 functionality
