# LDK - Local Development Kit

Run your AWS CDK applications locally. LDK reads your CDK project's synthesized CloudFormation templates and spins up local emulations of API Gateway, Lambda, DynamoDB, SQS, SNS, S3, and Step Functions so you can develop and test without deploying to AWS.

## Installation

LDK requires Python 3.11+ and [uv](https://docs.astral.sh/uv/).

```bash
uv tool install ldk
```

Or install from source:

```bash
git clone https://github.com/local-development-kit/ldk.git
cd ldk
uv sync
```

## Quick Start

1. Make sure your CDK project has been synthesized:

```bash
cd your-cdk-project
npx cdk synth
```

2. Start LDK:

```bash
ldk dev --project-dir /path/to/your-cdk-project --port 3000
```

3. Send requests to your local endpoints:

```bash
curl -X POST http://localhost:3000/orders \
  -H 'Content-Type: application/json' \
  -d '{"customerName": "Alice", "items": ["widget"]}'

curl http://localhost:3000/orders/some-id
```

LDK will discover your API routes, Lambda functions, DynamoDB tables, SQS queues, SNS topics, S3 buckets, and Step Functions state machines automatically from the CDK output.

## Supported Services

Each service has two dimensions of support: **CDK constructs** parsed from your `cdk synth` output, and **API operations** emulated at runtime.

### DynamoDB

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_dynamodb.Table` | tableName, partitionKey, sortKey, globalSecondaryIndexes |

**API Operations:**

| Operation | Supported |
|-----------|-----------|
| PutItem | Yes |
| GetItem | Yes |
| DeleteItem | Yes |
| UpdateItem | Yes |
| Query | Yes |
| Scan | Yes |
| BatchGetItem | Yes |
| BatchWriteItem | Yes |
| CreateTable | No |
| DeleteTable | No |
| DescribeTable | No |
| TransactGetItems | No |
| TransactWriteItems | No |

Backed by SQLite. Supports expression attribute names/values, filter expressions, and eventual consistency simulation.

### SQS

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_sqs.Queue` | queueName, fifo, visibilityTimeout, contentBasedDeduplication, deadLetterQueue |

**API Operations:**

| Operation | Supported |
|-----------|-----------|
| SendMessage | Yes |
| ReceiveMessage | Yes |
| DeleteMessage | Yes |
| CreateQueue | Yes |
| GetQueueUrl | Yes |
| GetQueueAttributes | Yes |
| SendMessageBatch | No |
| DeleteMessageBatch | No |
| PurgeQueue | No |
| ChangeMessageVisibility | No |

Supports message attributes, long polling, and dead-letter queue wiring from RedrivePolicy.

### S3

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_s3.Bucket` | bucketName |

**API Operations:**

| Operation | Supported |
|-----------|-----------|
| PutObject | Yes |
| GetObject | Yes |
| DeleteObject | Yes |
| HeadObject | Yes |
| ListObjectsV2 | Yes |
| CopyObject | No |
| DeleteObjects | No |
| CreateMultipartUpload | No |
| ListBuckets | No |

Backed by the local filesystem. Supports event notifications (ObjectCreated, ObjectRemoved), presigned URL generation, ETags, and content-type headers.

### SNS

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_sns.Topic` | topicName |

`aws_sns.Subscription` is not parsed. Subscriptions are wired at runtime via the API or auto-wired by LDK for Lambda/SQS targets.

**API Operations:**

| Operation | Supported |
|-----------|-----------|
| Publish | Yes |
| Subscribe | Yes |
| CreateTopic | Yes |
| ListTopics | Yes |
| ListSubscriptions | Yes |
| Unsubscribe | No |
| DeleteTopic | No |
| SetSubscriptionAttributes | No |

Supports Lambda and SQS subscription protocols, message attributes, and fan-out to multiple subscribers.

### EventBridge

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_events.EventBus` | eventBusName |
| `aws_events.Rule` | ruleName, eventBus, eventPattern, schedule, targets |

**API Operations:**

| Operation | Supported |
|-----------|-----------|
| PutEvents | Yes |
| PutRule | Yes |
| PutTargets | Yes |
| ListRules | Yes |
| ListEventBuses | Yes |
| RemoveTargets | No |
| DeleteRule | No |
| DescribeRule | No |

Supports event pattern matching, schedule expressions (rate and cron), Lambda targets, and input transformations.

### Step Functions

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_stepfunctions.StateMachine` | stateMachineName, definitionBody, stateMachineType |

**API Operations:**

| Operation | Supported |
|-----------|-----------|
| StartExecution | Yes |
| StartSyncExecution | Yes |
| DescribeExecution | Yes |
| ListExecutions | Yes |
| ListStateMachines | Yes |
| StopExecution | No |
| GetExecutionHistory | No |
| CreateStateMachine | No |

State types: Task, Pass, Choice, Wait, Succeed, Fail, Parallel, Map. Supports JSONPath (InputPath, OutputPath, ResultPath), error handling (Retry, Catch), and Standard & Express workflows.

### Cognito

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_cognito.UserPool` | userPoolName, lambdaTriggers (preAuthentication, postConfirmation), passwordPolicy |
| `aws_cognito.UserPoolClient` | userPool |

**API Operations:**

| Operation | Supported |
|-----------|-----------|
| SignUp | Yes |
| ConfirmSignUp | Yes |
| InitiateAuth | Yes (USER_PASSWORD_AUTH) |
| JWKS endpoint | Yes |
| AdminCreateUser | No |
| ForgotPassword | No |
| ChangePassword | No |
| GlobalSignOut | No |

Backed by SQLite. Supports JWT token generation (ID, access, refresh), user attributes, and password hashing.

### Lambda

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_lambda.Function` | handler, runtime, code, timeout, memorySize, environment |

Runs functions locally using Python or Node.js runtimes. Supports timeout enforcement, realistic context objects, and environment variable injection. Not an AWS API endpoint — functions are invoked by other services (API Gateway, SNS, EventBridge, Step Functions).

### API Gateway

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_apigateway.RestApi` | routes, methods, integrations |
| `aws_apigatewayv2.HttpApi` | routes, integrations |

HTTP API (V1 proxy integration) that routes requests to local Lambda functions. Supports path parameters, query parameters, and request/response mapping.

### ECS

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_ecs.TaskDefinition` | containerDefinitions |
| `aws_ecs.FargateService` / `aws_ecs.Ec2Service` | taskDefinition |
| `aws_elasticloadbalancingv2.ApplicationListenerRule` | conditions, actions |

Runs services as local subprocesses. Supports health checking, service discovery, file watching with auto-restart, and port mapping. Supports local command overrides via `ldk.local_command` metadata.

## Development

All development tasks are available through `make`:

```bash
make install       # Install dependencies
make test          # Run test suite
make lint          # Run linter
make format        # Auto-format code
make check         # Run all checks (lint, format, complexity, tests)
```

Run `make` with no arguments to see all available targets.

## Documentation

Visit [https://github.com/local-development-kit/ldk-site](https://github.com/local-development-kit/ldk-site) for full documentation.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
