import { LwsSession, SqsQueue, DynamoTable } from "../../dist/index.js";
import { SQSClient, SendMessageCommand, ReceiveMessageCommand } from "@aws-sdk/client-sqs";
import { DynamoDBClient, PutItemCommand, GetItemCommand } from "@aws-sdk/client-dynamodb";
import assert from "assert";

async function testSqs() {
  const session = new LwsSession(new SqsQueue("smoke-queue"));
  await session.start();
  try {
    const cfg = session.clientConfig("sqs");
    const client = new SQSClient(cfg);
    const queueUrl = session.queueUrl("smoke-queue");
    await client.send(new SendMessageCommand({ QueueUrl: queueUrl, MessageBody: "hello" }));
    const result = await client.send(
      new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 1 }),
    );
    assert.strictEqual(result.Messages?.length, 1);
    assert.strictEqual(result.Messages[0].Body, "hello");
    console.log("✓ SQS smoke test passed");
  } finally {
    await session.stop();
  }
}

async function testDynamoDB() {
  const session = new LwsSession(new DynamoTable("smoke-table", "pk"));
  await session.start();
  try {
    const cfg = session.clientConfig("dynamodb");
    const client = new DynamoDBClient(cfg);
    await client.send(
      new PutItemCommand({
        TableName: "smoke-table",
        Item: { pk: { S: "test-key" }, value: { S: "test-value" } },
      }),
    );
    const result = await client.send(
      new GetItemCommand({
        TableName: "smoke-table",
        Key: { pk: { S: "test-key" } },
      }),
    );
    assert.strictEqual(result.Item?.value?.S, "test-value");
    console.log("✓ DynamoDB smoke test passed");
  } finally {
    await session.stop();
  }
}

await testSqs();
await testDynamoDB();
console.log("All ESM smoke tests passed");
