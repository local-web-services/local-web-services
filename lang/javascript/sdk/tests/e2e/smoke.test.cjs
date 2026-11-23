"use strict";
const { LwsSession, SqsQueue } = require("../../dist/index.cjs");
const { SQSClient, SendMessageCommand, ReceiveMessageCommand } = require("@aws-sdk/client-sqs");
const assert = require("assert");

async function testSqs() {
  const session = new LwsSession(new SqsQueue("cjs-smoke-queue"));
  await session.start();
  try {
    const cfg = session.clientConfig("sqs");
    const client = new SQSClient(cfg);
    const queueUrl = session.queueUrl("cjs-smoke-queue");
    await client.send(new SendMessageCommand({ QueueUrl: queueUrl, MessageBody: "cjs-hello" }));
    const result = await client.send(
      new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 1 }),
    );
    assert.strictEqual(result.Messages?.length, 1);
    assert.strictEqual(result.Messages[0].Body, "cjs-hello");
    console.log("✓ CJS SQS smoke test passed");
  } finally {
    await session.stop();
  }
}

testSqs().then(() => {
  console.log("All CJS smoke tests passed");
});
