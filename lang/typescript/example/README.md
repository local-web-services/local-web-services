# local-web-services TypeScript SDK — Example Project

An example project showing how to test an AWS Step Functions workflow using the [local-web-services TypeScript SDK](https://github.com/local-web-services/local-web-services-typescript-sdk).

## What this example does

- Defines a simple `processOrder` function that starts a Step Functions execution and waits for it to complete
- Uses `LwsSession` to run a local Step Functions emulator during tests — no AWS account or credentials required
- Tests pass on any machine with Python (`ldk`) and Node.js installed

## Project structure

```
src/
  orderProcessor.ts    # Production code — AWS SDK v3, no test-specific config
tests/
  orderProcessor.test.ts  # Tests using LwsSession
```

## Prerequisites

```bash
pip install local-web-services   # installs the ldk binary
```

## Running the tests

```bash
npm install
npm test
```

## How it works

```typescript
// tests/orderProcessor.test.ts
import { LwsSession } from "local-web-services-typescript-sdk";
import { processOrder } from "../src/orderProcessor";

let session: LwsSession;
let sfnClient: SFNClient;

beforeAll(async () => {
  session = await LwsSession.create({});  // starts ldk dev

  // session.client() returns a pre-configured client pointing at the local emulator
  sfnClient = session.client<SFNClient>("stepfunctions");

  const response = await sfnClient.send(new CreateStateMachineCommand({ ... }));
  stateMachineArn = response.stateMachineArn!;
});

afterAll(() => session.close());

test("processOrder returns the order ID", async () => {
  // Pass the local SFN client — production code accepts an optional client
  // for testability; in production it creates one with default settings
  const result = await processOrder("order-123", stateMachineArn, sfnClient);
  expect(result.orderId).toBe("order-123");
});
```

## Links

- [local-web-services](https://github.com/local-web-services/local-web-services) — the core tool
- [TypeScript SDK](https://github.com/local-web-services/local-web-services-typescript-sdk) — `npm install local-web-services-typescript-sdk`
