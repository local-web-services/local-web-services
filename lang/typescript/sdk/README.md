# local-web-services-typescript-sdk

TypeScript testing SDK for [local-web-services](https://local-web-services.github.io) — starts
an in-process LWS server and provides pre-configured AWS SDK v3 clients for testing. No AWS
account, credentials, or Docker required.

## Installation

```bash
npm install local-web-services-typescript-sdk
# or
pnpm add local-web-services-typescript-sdk
```

Requires Node.js 18+ and `typescript`.

## Quick start

```typescript
import { LwsSession } from 'local-web-services-typescript-sdk';
import { DynamoDBClient, PutItemCommand, GetItemCommand } from '@aws-sdk/client-dynamodb';

// Explicit resource declaration
const session = await LwsSession.create({
  tables: [{ name: 'Orders', partitionKey: 'id' }],
  queues: ['OrderQueue'],
  buckets: ['ReceiptsBucket'],
});

// Get a fully-configured AWS SDK v3 client
const dynamo = session.client<DynamoDBClient>('dynamodb');

await dynamo.send(new PutItemCommand({
  TableName: 'Orders',
  Item: { id: { S: '1' }, status: { S: 'pending' } },
}));

const result = await dynamo.send(new GetItemCommand({
  TableName: 'Orders',
  Key: { id: { S: '1' } },
}));
console.log(result.Item?.status?.S); // "pending"

// Use the helper API for common operations
const table = session.dynamodb('Orders');
await table.put({ id: { S: '2' }, status: { S: 'shipped' } });
const items = await table.scan();
console.log(items.length); // 2

// Always close the session when done
await session.close();
```

## Auto-discover resources from CDK / Terraform

```typescript
// Read resource definitions from a CDK project
const session = await LwsSession.fromCdk('../my-cdk-project');

// Read resource definitions from a Terraform project
const session = await LwsSession.fromHcl('../my-terraform-project');
```

## Jest example

```typescript
// jest.config.ts
export default {
  preset: 'ts-jest',
  testEnvironment: 'node',
  testTimeout: 30000,
};

// orders.test.ts
import { LwsSession } from 'local-web-services-typescript-sdk';

let session: LwsSession;

beforeAll(async () => {
  session = await LwsSession.create({
    tables: [{ name: 'Orders', partitionKey: 'id' }],
  });
});

afterAll(async () => {
  await session.close();
});

beforeEach(async () => {
  await session.reset(); // clear all state between tests
});

test('creates an order', async () => {
  const table = session.dynamodb('Orders');
  await table.put({ id: { S: '42' }, status: { S: 'pending' } });

  const item = await table.assertItemExists({ id: { S: '42' } });
  expect(item.status.S).toBe('pending');
});
```

## Fault injection

```typescript
// Make DynamoDB return ThrottlingException on the next call
await session.chaos('dynamodb').throttle();

// Return a fake response instead of executing the real handler
await session.fake('sqs').receiveMessage({ Messages: [] });

// Require specific IAM actions to be present
session.iam.require('dynamodb:PutItem');
```

## API

### Session constructors

| Constructor | Description |
|---|---|
| `LwsSession.create(spec)` | Start with explicit resource spec |
| `LwsSession.fromCdk(projectDir)` | Auto-discover from CDK cloud assembly |
| `LwsSession.fromHcl(projectDir)` | Auto-discover from Terraform `.tf` files |

### Methods

| Method | Description |
|---|---|
| `session.client<T>(service)` | Get AWS SDK v3 client for a service |
| `session.dynamodb(tableName)` | Get `DynamoDBHelper` |
| `session.sqs(queueName)` | Get `SQSHelper` |
| `session.s3(bucketName)` | Get `S3Helper` |
| `session.reset()` | Clear all service state (use in `beforeEach`) |
| `session.close()` | Stop the in-process server |
| `session.fake(service)` | Get `FakeBuilder` for fault injection |
| `session.chaos(service)` | Get `ChaosBuilder` for error injection |
| `session.iam` | Get `IamBuilder` for policy assertions |
| `session.logs` | Get `LogCapture` for log assertions |
| `session.portFor(service)` | Port number for a named service |
| `session.queueUrl(queueName)` | Local SQS queue URL |

## Supported services

All 20 services are available via `session.client(serviceName)`:

| Service | `client(...)` name |
|---|---|
| DynamoDB | `"dynamodb"` |
| SQS | `"sqs"` |
| S3 | `"s3"` |
| SNS | `"sns"` |
| EventBridge | `"eventbridge"` |
| Step Functions | `"stepfunctions"` |
| Cognito IDP | `"cognitoidp"` |
| Lambda | `"lambda"` |
| API Gateway | `"apigateway"` |
| RDS | `"rds"` |
| DocumentDB | `"docdb"` |
| SSM Parameter Store | `"ssm"` |
| Secrets Manager | `"secretsmanager"` |
| ElastiCache | `"elasticache"` |
| Neptune | `"neptune"` |
| MemoryDB | `"memorydb"` |
| Glacier | `"glacier"` |
| Elasticsearch | `"elasticsearch"` |
| OpenSearch | `"opensearch"` |
| S3 Tables | `"s3tables"` |

## How it works

`LwsSession.create` starts the TypeScript LWS core in-process on a randomly chosen base port.
Each service listens at `basePort + offset`. The session returns AWS SDK v3 clients pre-configured
with `http://127.0.0.1:<port>` endpoint overrides and stub credentials. On `close()` the server
shuts down and process environment is restored.

## License

MIT
