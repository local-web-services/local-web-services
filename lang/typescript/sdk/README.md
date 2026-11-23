# local-web-services-typescript-sdk

TypeScript testing SDK for [local-web-services](https://local-web-services.github.io) — starts
in-process AWS service emulators and provides pre-configured `@aws-sdk` clients that point at them.
Your production code works unchanged: the SDK sets `AWS_ENDPOINT_URL_*` environment variables
that the AWS SDK picks up automatically.

## Installation

```bash
npm install local-web-services-typescript-sdk
# or
pnpm add local-web-services-typescript-sdk
```

Requires Node.js 20+.

## Quick start

```typescript
import { LwsSession, SqsQueue, DynamoTable, S3Bucket } from "local-web-services-typescript-sdk";
import { SQSClient, SendMessageCommand, ReceiveMessageCommand } from "@aws-sdk/client-sqs";
import { DynamoDBClient, PutItemCommand, GetItemCommand } from "@aws-sdk/client-dynamodb";

const session = new LwsSession(
  new SqsQueue("OrderQueue"),
  new DynamoTable("Orders", "id"),
  new S3Bucket("my-bucket"),
);

await session.start();
try {
  // SQS
  const sqs = new SQSClient(session.clientConfig("sqs"));
  const queueUrl = session.queueUrl("OrderQueue");
  await sqs.send(new SendMessageCommand({ QueueUrl: queueUrl, MessageBody: "hello" }));

  // DynamoDB
  const dynamo = new DynamoDBClient(session.clientConfig("dynamodb"));
  await dynamo.send(new PutItemCommand({
    TableName: "Orders",
    Item: { id: { S: "1" }, status: { S: "pending" } },
  }));
  const result = await dynamo.send(new GetItemCommand({
    TableName: "Orders",
    Key: { id: { S: "1" } },
  }));
} finally {
  await session.stop();
}
```

## Vitest fixture

```typescript
import { lwsSessionFixture, SqsQueue } from "local-web-services-typescript-sdk";
import { test, expect } from "vitest";

const { lwsSession } = lwsSessionFixture(new SqsQueue("my-queue"));

test("sends a message", lwsSession(async ({ session }) => {
  const queueUrl = session.queueUrl("my-queue");
  // ...
}));
```

## Auto-discover from CDK / Terraform

```typescript
import { discoverFromCdk, discoverFromHcl } from "local-web-services-typescript-sdk";

const session = new LwsSession(...await discoverFromCdk("../my-cdk-project"));
const session2 = new LwsSession(...await discoverFromHcl("../my-terraform-project"));
```

## Supported services

| Service | Spec class | `clientConfig()` key |
|---|---|---|
| SQS | `SqsQueue` | `"sqs"` |
| DynamoDB | `DynamoTable` | `"dynamodb"` |
| S3 | `S3Bucket` | `"s3"` |
| SNS | `SnsTopic` | `"sns"` |
| SSM Parameter Store | `SsmParameter` | `"ssm"` |
| Secrets Manager | `Secret` | `"secretsmanager"` |
| EventBridge | `EventBus` | `"events"` |
| Step Functions | `StateMachine` | `"states"` |

## API reference

### `LwsSession(...specs)`

| Method | Description |
|---|---|
| `start()` | Start all emulators and patch `AWS_ENDPOINT_URL_*` env vars |
| `stop()` | Stop all emulators and restore env |
| `reset()` | Clear all state (queues, tables, objects, etc.) |
| `clientConfig(service)` | Returns `{ endpoint }` config for an `@aws-sdk` client |
| `endpointUrl(service)` | Raw endpoint URL string |
| `queueUrl(name)` | SQS queue URL |

### Resource specs

- `new SqsQueue(name, options?)` — `options`: `{ visibilityTimeout?, messageRetentionPeriod?, redrivePolicy? }`
- `new DynamoTable(name, hashKey, hashKeyType?, sortKey?, sortKeyType?)`
- `new S3Bucket(name)`
- `new SnsTopic(name)`
- `new SsmParameter(name, value, type?)`
- `new Secret(name, secretString?)`
- `new EventBus(name)`
- `new StateMachine(name, definition)`
