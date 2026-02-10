# local-web-services

Run your AWS CDK and Terraform applications locally. local-web-services reads your CDK cloud assembly or Terraform configuration and spins up local emulations of API Gateway, Lambda, DynamoDB, SQS, SNS, S3, Step Functions, Cognito, EventBridge, SSM Parameter Store, Secrets Manager, and more — so you can develop and test without deploying to AWS.

## Try It Out

### CDK Sample Project

Clone the [CDK sample project](https://github.com/local-web-services/sample-project) — a serverless order processing system with API Gateway, Lambda, DynamoDB, SQS, S3, SNS, and Step Functions:

```bash
git clone https://github.com/local-web-services/sample-project.git
cd sample-project
npm install
npx cdk synth
```

Start the local environment:

```bash
uvx --from local-web-services ldk dev
```

### Terraform Sample Project

Clone the [Terraform sample project](https://github.com/local-web-services/sample-project-terraform) — the same order processing system built with Terraform:

```bash
git clone https://github.com/local-web-services/sample-project-terraform.git
cd sample-project-terraform
terraform init
```

Start the local environment, then apply:

```bash
# Terminal 1: Start local services
uvx --from local-web-services ldk dev

# Terminal 2: Apply Terraform against local endpoints
terraform apply -auto-approve
```

### Interact with Local Services

Open http://localhost:3000/_ldk/gui in your browser to see the GUI — you can watch request logs, browse DynamoDB tables, inspect S3 buckets, and interact with all your resources as you run through the steps below.

In another terminal, create an order:

```bash
uvx --from local-web-services lws apigateway test-invoke-method \
  --resource /orders \
  --http-method POST \
  --body '{"customerName": "Alice", "items": ["widget", "gadget"], "total": 49.99}'
```

Start the order processing workflow:

```bash
uvx --from local-web-services lws stepfunctions start-execution \
  --name OrderWorkflow \
  --input '{"orderId": "<ORDER_ID>", "items": ["widget", "gadget"], "total": 49.99}'
```

Check the workflow status:

```bash
uvx --from local-web-services lws stepfunctions describe-execution --execution-arn <EXECUTION_ARN>
```

Retrieve the order:

```bash
uvx --from local-web-services lws apigateway test-invoke-method \
  --resource /orders/<ORDER_ID> \
  --http-method GET
```

Store and retrieve configuration:

```bash
uvx --from local-web-services lws ssm put-parameter \
  --name /app/table-name --value orders --type String

uvx --from local-web-services lws ssm get-parameter --name /app/table-name
```

Store and retrieve secrets:

```bash
uvx --from local-web-services lws secretsmanager create-secret \
  --name app/api-key --secret-string "my-secret-key"

uvx --from local-web-services lws secretsmanager get-secret-value --secret-id app/api-key
```

Both sample projects include a full end-to-end test script (`test-orders.sh`) that runs all of these steps automatically.

## Installation

local-web-services requires Python 3.11+ and [uv](https://docs.astral.sh/uv/).

```bash
uvx --from local-web-services ldk
```

Or install from source:

```bash
git clone https://github.com/local-web-services/local-web-services.git
cd local-web-services
uv sync
```

## Quick Start (Your Own Project)

### CDK Projects

1. Make sure your CDK project has been synthesized:

```bash
cd your-cdk-project
npx cdk synth
```

2. Start local-web-services:

```bash
uvx --from local-web-services ldk dev --project-dir /path/to/your-cdk-project --port 3000
```

`ldk` will discover your API routes, Lambda functions, DynamoDB tables, SQS queues, SNS topics, S3 buckets, and Step Functions state machines automatically from the CDK output.

### Terraform Projects

1. Initialize your Terraform project:

```bash
cd your-terraform-project
terraform init
```

2. Start local-web-services:

```bash
uvx --from local-web-services ldk dev --project-dir /path/to/your-terraform-project
```

`ldk` auto-detects `.tf` files and starts all service providers in always-on mode. A `_lws_override.tf` file is generated to redirect the AWS provider to local endpoints.

3. Apply your Terraform configuration:

```bash
terraform apply
```

Terraform creates resources (tables, queues, buckets, Lambda functions, API routes) against your local services. No AWS account needed.

### Mode Selection

`ldk dev` auto-detects your project type. To force a specific mode:

```bash
uvx --from local-web-services ldk dev --mode cdk        # Force CDK mode
uvx --from local-web-services ldk dev --mode terraform   # Force Terraform mode
```

## Supported Services

Each service has two dimensions of support: **IaC constructs** parsed from your project, and **API operations** emulated at runtime.

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
| CreateTable | Yes |
| DeleteTable | Yes |
| DescribeTable | Yes |
| ListTables | Yes |
| TransactGetItems | Yes |
| TransactWriteItems | Yes |
| UpdateTable | Yes |
| DescribeContinuousBackups | Yes |
| UpdateTimeToLive | Yes |

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
| DeleteQueue | Yes |
| GetQueueUrl | Yes |
| GetQueueAttributes | Yes |
| SetQueueAttributes | Yes |
| ListQueues | Yes |
| PurgeQueue | Yes |
| SendMessageBatch | Yes |
| DeleteMessageBatch | Yes |
| ChangeMessageVisibility | Yes |
| ChangeMessageVisibilityBatch | Yes |
| ListDeadLetterSourceQueues | Yes |

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
| CreateBucket | Yes |
| DeleteBucket | Yes |
| HeadBucket | Yes |
| ListBuckets | Yes |
| CopyObject | Yes |
| DeleteObjects | Yes |
| PutBucketTagging | Yes |
| GetBucketTagging | Yes |
| DeleteBucketTagging | Yes |
| GetBucketLocation | Yes |
| PutBucketPolicy | Yes |
| GetBucketPolicy | Yes |
| PutBucketNotificationConfiguration | Yes |
| GetBucketNotificationConfiguration | Yes |
| CreateMultipartUpload | No |

Backed by the local filesystem. Supports event notifications (ObjectCreated, ObjectRemoved), presigned URL generation, ETags, and content-type headers.

### SNS

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_sns.Topic` | topicName |

`aws_sns.Subscription` is not parsed. Subscriptions are wired at runtime via the API or auto-wired by local-web-services for Lambda/SQS targets.

**API Operations:**

| Operation | Supported |
|-----------|-----------|
| Publish | Yes |
| Subscribe | Yes |
| CreateTopic | Yes |
| ListTopics | Yes |
| ListSubscriptions | Yes |
| DeleteTopic | Yes |
| SetTopicAttributes | Yes |
| Unsubscribe | Yes |
| GetSubscriptionAttributes | Yes |
| SetSubscriptionAttributes | Yes |
| ConfirmSubscription | Yes |
| ListSubscriptionsByTopic | Yes |

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
| RemoveTargets | Yes |
| DeleteRule | Yes |
| DescribeRule | Yes |
| ListTargetsByRule | Yes |
| EnableRule | Yes |
| DisableRule | Yes |
| TagResource | Yes |
| UntagResource | Yes |
| ListTagsForResource | Yes |

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
| CreateStateMachine | Yes |
| StopExecution | Yes |
| GetExecutionHistory | Yes |
| UpdateStateMachine | Yes |

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
| CreateUserPoolClient | Yes |
| DeleteUserPoolClient | Yes |
| DescribeUserPoolClient | Yes |
| ListUserPoolClients | Yes |
| AdminCreateUser | Yes |
| AdminDeleteUser | Yes |
| AdminGetUser | Yes |
| UpdateUserPool | Yes |
| ListUsers | Yes |
| ForgotPassword | No |
| ChangePassword | No |
| GlobalSignOut | No |

Backed by SQLite. Supports JWT token generation (ID, access, refresh), user attributes, and password hashing.

### Lambda

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_lambda.Function` | handler, runtime, code, timeout, memorySize, environment |

**Management API (Terraform mode):**

| Operation | Supported |
|-----------|-----------|
| CreateFunction | Yes |
| GetFunction | Yes |
| DeleteFunction | Yes |
| ListFunctions | Yes |
| Invoke | Yes |
| UpdateFunctionConfiguration | Yes |
| UpdateFunctionCode | Yes |
| TagResource | Yes |
| UntagResource | Yes |
| ListEventSourceMappings | Yes |

Runs functions locally using Python or Node.js runtimes. Supports timeout enforcement, realistic context objects, and environment variable injection. In CDK mode, functions are discovered from the cloud assembly. In Terraform mode, functions are created dynamically via the management API.

### API Gateway

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_apigateway.RestApi` | routes, methods, integrations |
| `aws_apigatewayv2.HttpApi` | routes, integrations |

**REST API (V1) Management:**

CreateRestApi, GetRestApi, DeleteRestApi, CreateResource, PutMethod, PutIntegration, CreateDeployment, CreateStage.

**HTTP API (V2) Management:**

CreateApi, GetApi, DeleteApi, CreateRoute, CreateIntegration, CreateStage, ListRoutes, ListIntegrations, ListStages.

Supports both REST API (V1) and HTTP API (V2) with Lambda proxy integration. Routes requests to local Lambda functions with path parameters, query parameters, and request/response mapping.

### ECS

**CDK Constructs:**

| Construct | Parsed Properties |
|-----------|-------------------|
| `aws_ecs.TaskDefinition` | containerDefinitions |
| `aws_ecs.FargateService` / `aws_ecs.Ec2Service` | taskDefinition |
| `aws_elasticloadbalancingv2.ApplicationListenerRule` | conditions, actions |

Runs services as local subprocesses. Supports health checking, service discovery, file watching with auto-restart, and port mapping. Supports local command overrides via `ldk.local_command` metadata. CDK mode only.

### IAM & STS

Stub APIs that return AWS-compatible responses for Terraform compatibility. IAM role and policy operations are accepted and stored in memory (CreateRole, GetRole, DeleteRole, CreatePolicy, GetPolicy, DeletePolicy, AttachRolePolicy, DetachRolePolicy, CreatePolicyVersion, ListRoles, ListPolicies). STS returns dummy credentials and caller identity (GetCallerIdentity, AssumeRole).

### SSM Parameter Store

**API Operations:**

| Operation | Supported |
|-----------|-----------|
| PutParameter | Yes |
| GetParameter | Yes |
| GetParameters | Yes |
| GetParametersByPath | Yes |
| DeleteParameter | Yes |
| DeleteParameters | Yes |
| DescribeParameters | Yes |
| AddTagsToResource | Yes |
| RemoveTagsFromResource | Yes |
| ListTagsForResource | Yes |

In-memory parameter store supporting String, StringList, and SecureString types. Supports versioning (auto-incremented on overwrite), descriptions, and tags.

### Secrets Manager

**API Operations:**

| Operation | Supported |
|-----------|-----------|
| CreateSecret | Yes |
| GetSecretValue | Yes |
| PutSecretValue | Yes |
| UpdateSecret | Yes |
| DeleteSecret | Yes |
| DescribeSecret | Yes |
| ListSecrets | Yes |
| RestoreSecret | Yes |
| TagResource | Yes |
| UntagResource | Yes |
| ListSecretVersionIds | Yes |

In-memory secret store supporting version staging (AWSCURRENT/AWSPREVIOUS), soft delete with optional recovery, and tags.

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

Visit [https://local-web-services.github.io/www/](https://local-web-services.github.io/www/) for full documentation.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
