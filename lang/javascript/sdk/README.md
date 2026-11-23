# local-web-services-javascript-sdk

JavaScript (CJS + ESM) testing SDK for [local-web-services](https://local-web-services.github.io).
A plain-JavaScript wrapper around the TypeScript SDK — same API, dual-bundle format for use in
any Node.js project without a TypeScript build step.

## Installation

```bash
npm install local-web-services-javascript-sdk
# or
pnpm add local-web-services-javascript-sdk
```

Requires Node.js 20+.

## Quick start (ESM)

```javascript
import { LwsSession, SqsQueue, DynamoTable } from "local-web-services-javascript-sdk";
import { SQSClient, SendMessageCommand, ReceiveMessageCommand } from "@aws-sdk/client-sqs";

const session = new LwsSession(new SqsQueue("my-queue"));
await session.start();
try {
  const sqs = new SQSClient(session.clientConfig("sqs"));
  const queueUrl = session.queueUrl("my-queue");
  await sqs.send(new SendMessageCommand({ QueueUrl: queueUrl, MessageBody: "hello" }));
  const result = await sqs.send(
    new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 1 }),
  );
  console.log(result.Messages[0].Body); // "hello"
} finally {
  await session.stop();
}
```

## Quick start (CJS)

```javascript
const { LwsSession, SqsQueue } = require("local-web-services-javascript-sdk");
const { SQSClient, SendMessageCommand } = require("@aws-sdk/client-sqs");

async function main() {
  const session = new LwsSession(new SqsQueue("my-queue"));
  await session.start();
  try {
    const sqs = new SQSClient(session.clientConfig("sqs"));
    const queueUrl = session.queueUrl("my-queue");
    await sqs.send(new SendMessageCommand({ QueueUrl: queueUrl, MessageBody: "hello" }));
  } finally {
    await session.stop();
  }
}
main();
```

## Supported services

Same as the TypeScript SDK: SQS, DynamoDB, S3, SNS, SSM, Secrets Manager, EventBridge, Step Functions, Cognito IDP, Lambda.

See the [TypeScript SDK README](../typescript/sdk/README.md) for the full API reference and resource spec details.
