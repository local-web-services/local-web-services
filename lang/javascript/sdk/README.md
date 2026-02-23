# local-web-services-javascript-sdk

JavaScript testing SDK for [local-web-services](https://github.com/local-web-services/local-web-services) — spawns `ldk dev` in a subprocess and provides pre-configured AWS SDK v3 clients for testing.

## Prerequisites

Install `local-web-services`:

```bash
pip install local-web-services
```

## Installation

```bash
npm install local-web-services-javascript-sdk
# or
pnpm add local-web-services-javascript-sdk
```

## Quick start

```js
const { LwsSession } = require('local-web-services-javascript-sdk');

// Auto-discover from a CDK project (runs ldk dev against cdk.out/)
const session = await LwsSession.fromCdk('../my-cdk-project');

// Auto-discover from a Terraform project
const session = await LwsSession.fromHcl('../my-terraform-project');

// Explicit resource declaration
const session = await LwsSession.create({
  tables: [{ name: 'Orders', partitionKey: 'id' }],
  queues: ['OrderQueue'],
  buckets: ['ReceiptsBucket'],
});

// Get a fully-configured AWS SDK v3 client
const dynamodb = session.client('dynamodb');

// Use the helper API
const table = session.dynamodb('Orders');
await table.put({ id: { S: '1' }, status: { S: 'pending' } });
const items = await table.scan();
console.log(items.length); // 1

// Always close the session when done
await session.close();
```

## Jest example

```js
// jest.config.js
module.exports = {
  testEnvironment: 'node',
  testTimeout: 60000,   // ldk dev needs time to start
};

// orders.test.js
const { LwsSession } = require('local-web-services-javascript-sdk');

let session;

beforeAll(async () => {
  session = await LwsSession.create({
    tables: [{ name: 'Orders', partitionKey: 'id' }],
  });
});

afterAll(async () => {
  await session.close();
});

beforeEach(async () => {
  await session.reset();
});

test('creates an order', async () => {
  const table = session.dynamodb('Orders');
  await table.put({ id: { S: '42' }, status: { S: 'pending' } });

  const item = await table.assertItemExists({ id: { S: '42' } });
  expect(item.status.S).toBe('pending');
});
```

## Drop-in AWS endpoint redirection

When a session starts, `AWS_ENDPOINT_URL_*` environment variables are automatically set for all supported services. Any AWS SDK v3 client created after the session starts — including clients in your production code — will hit the local LWS services without any code changes:

```js
// production code
const { DynamoDBClient } = require('@aws-sdk/client-dynamodb');
const client = new DynamoDBClient({}); // picks up AWS_ENDPOINT_URL_DYNAMODB automatically

// test code — no endpoint configuration needed
const session = await LwsSession.create({ tables: [{ name: 'Orders', partitionKey: 'id' }] });
// production client now talks to LWS
```

Env vars are restored when `session.close()` is called.

## API

### `LwsSession`

| Method | Description |
|--------|-------------|
| `LwsSession.create(spec)` | Start with explicit resource spec |
| `LwsSession.fromCdk(projectDir)` | Auto-discover from CDK cloud assembly |
| `LwsSession.fromHcl(projectDir)` | Auto-discover from Terraform `.tf` files |
| `session.client(service)` | Get AWS SDK v3 client |
| `session.dynamodb(tableName)` | Get `DynamoDBHelper` |
| `session.sqs(queueName)` | Get `SQSHelper` |
| `session.s3(bucketName)` | Get `S3Helper` |
| `session.reset()` | Clear all state (use in `beforeEach`) |
| `session.close()` | Stop `ldk dev` process |
| `session.queueUrl(queueName)` | Get local SQS queue URL |
| `session.portFor(service)` | Get port number for a service |
| `session.mock(service)` | Get `MockBuilder` for service |
| `session.chaos(service)` | Get `ChaosBuilder` for service |
| `session.iam` | Get `IamBuilder` |

### Supported services

`dynamodb`, `s3`, `sqs`, `sns`, `ssm`, `secretsmanager`, `stepfunctions`

## License

MIT
