# local-web-services-testing (TypeScript)

TypeScript testing SDK for [local-web-services](https://github.com/local-web-services/local-web-services) — spawns `ldk dev` in a subprocess and provides pre-configured AWS SDK v3 clients for testing.

## Prerequisites

Install `local-web-services`:

```bash
pip install local-web-services
```

## Installation

```bash
npm install local-web-services-testing
# or
pnpm add local-web-services-testing
```

## Quick start

```typescript
import { LwsSession } from 'local-web-services-testing';

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
const dynamodb = session.client<DynamoDBClient>('dynamodb');

// Use the helper API
const table = session.dynamodb('Orders');
await table.put({ id: { S: '1' }, status: { S: 'pending' } });
const items = await table.scan();
console.log(items.length); // 1

// Always close the session when done
await session.close();
```

## Jest example

```typescript
// jest.config.ts
export default {
  preset: 'ts-jest',
  testEnvironment: 'node',
  testTimeout: 60000,   // ldk dev needs time to start
};

// orders.test.ts
import { LwsSession } from 'local-web-services-testing';

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
  await session.reset();
});

test('creates an order', async () => {
  const table = session.dynamodb('Orders');
  await table.put({ id: { S: '42' }, status: { S: 'pending' } });

  const item = await table.assertItemExists({ id: { S: '42' } });
  expect(item.status.S).toBe('pending');
});
```

## API

### `LwsSession`

| Method | Description |
|--------|-------------|
| `LwsSession.create(spec)` | Start with explicit resource spec |
| `LwsSession.fromCdk(projectDir)` | Auto-discover from CDK cloud assembly |
| `LwsSession.fromHcl(projectDir)` | Auto-discover from Terraform `.tf` files |
| `session.client<T>(service)` | Get AWS SDK v3 client |
| `session.dynamodb(tableName)` | Get `DynamoDBHelper` |
| `session.sqs(queueName)` | Get `SQSHelper` |
| `session.s3(bucketName)` | Get `S3Helper` |
| `session.reset()` | Clear all state (use in `beforeEach`) |
| `session.close()` | Stop `ldk dev` process |
| `session.fake(service)` | Get `FakeBuilder` for service |
| `session.chaos(service)` | Get `ChaosBuilder` for service |
| `session.iam` | Get `IamBuilder` |

## License

MIT
