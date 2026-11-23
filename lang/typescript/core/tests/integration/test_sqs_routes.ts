/**
 * Integration tests for the SQS routes plugin using Fastify's inject() transport.
 * No real network socket is opened — all requests go through Fastify's in-process
 * HTTP injection, mirroring how Python's integration tests use Starlette's TestClient.
 */

import { describe, it, expect, beforeEach } from "vitest";
import Fastify from "fastify";
import type { FastifyInstance } from "fastify";
import { SqsProvider } from "../../src/providers/sqs/provider.js";
import { sqsRoutesPlugin } from "../../src/providers/sqs/routes.js";

const FAKE_PORT = 9999;
const FAKE_ACCOUNT = "000000000000";

function queueUrl(name: string): string {
  return `http://localhost:${FAKE_PORT}/${FAKE_ACCOUNT}/${name}`;
}

async function buildSqsApp(queueNames: string[] = []): Promise<FastifyInstance> {
  const provider = new SqsProvider(queueNames.map((name) => ({ queueName: name })));
  await provider.start();
  const app = Fastify({ logger: false });
  app.register(sqsRoutesPlugin, { provider, port: FAKE_PORT });
  return app;
}

async function jsonRequest(
  app: FastifyInstance,
  action: string,
  payload: Record<string, unknown>,
): Promise<{ status: number; body: Record<string, unknown> }> {
  const response = await app.inject({
    method: "POST",
    url: "/",
    headers: {
      "content-type": "application/x-amz-json-1.0",
      "x-amz-target": `AmazonSQS.${action}`,
    },
    payload: JSON.stringify(payload),
  });
  return { status: response.statusCode, body: JSON.parse(response.body) as Record<string, unknown> };
}

describe("SQS integration — CreateQueue", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildSqsApp();
    await app.ready();
  });

  it("creates a queue and returns a QueueUrl", async () => {
    // Arrange
    const expectedQueueName = "my-queue";

    // Act
    const actualResult = await jsonRequest(app, "CreateQueue", { QueueName: expectedQueueName });

    // Assert
    expect(actualResult.status).toBe(200);
    expect(actualResult.body["QueueUrl"]).toContain(expectedQueueName);
  });

  it("returns an error when creating a queue that already exists", async () => {
    // Arrange
    const queueName = "existing-queue";
    await jsonRequest(app, "CreateQueue", { QueueName: queueName });

    // Act
    const actualResult = await jsonRequest(app, "CreateQueue", { QueueName: queueName });

    // Assert
    expect(actualResult.status).toBe(400);
    expect(actualResult.body["__type"]).toBeDefined();
  });
});

describe("SQS integration — SendMessage / ReceiveMessage", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildSqsApp(["send-recv-queue"]);
    await app.ready();
  });

  it("sends a message and returns a MessageId", async () => {
    // Arrange
    const expectedMessageBody = "hello-world";

    // Act
    const actualResult = await jsonRequest(app, "SendMessage", {
      QueueUrl: queueUrl("send-recv-queue"),
      MessageBody: expectedMessageBody,
    });

    // Assert
    expect(actualResult.status).toBe(200);
    expect(typeof actualResult.body["MessageId"]).toBe("string");
    expect((actualResult.body["MessageId"] as string).length).toBeGreaterThan(0);
  });

  it("receives the sent message", async () => {
    // Arrange
    const expectedBody = "receive-test";
    await jsonRequest(app, "SendMessage", {
      QueueUrl: queueUrl("send-recv-queue"),
      MessageBody: expectedBody,
    });

    // Act
    const actualResult = await jsonRequest(app, "ReceiveMessage", {
      QueueUrl: queueUrl("send-recv-queue"),
      MaxNumberOfMessages: 1,
    });

    // Assert
    expect(actualResult.status).toBe(200);
    const actualMessages = actualResult.body["Messages"] as Array<Record<string, unknown>>;
    expect(actualMessages).toHaveLength(1);
    expect(actualMessages[0]?.["Body"]).toBe(expectedBody);
  });

  it("returns empty Messages array when queue is empty", async () => {
    // Arrange (queue is empty on creation)

    // Act
    const actualResult = await jsonRequest(app, "ReceiveMessage", {
      QueueUrl: queueUrl("send-recv-queue"),
      MaxNumberOfMessages: 1,
    });

    // Assert
    expect(actualResult.status).toBe(200);
    const actualMessages = actualResult.body["Messages"] as Array<unknown>;
    expect(actualMessages).toHaveLength(0);
  });

  it("returns error when sending to non-existent queue", async () => {
    // Arrange
    const expectedErrorType = "AWS.SimpleQueueService.NonExistentQueue";

    // Act
    const actualResult = await jsonRequest(app, "SendMessage", {
      QueueUrl: queueUrl("does-not-exist"),
      MessageBody: "test",
    });

    // Assert
    expect(actualResult.status).toBe(400);
    expect(actualResult.body["__type"]).toBe(expectedErrorType);
  });
});

describe("SQS integration — DeleteMessage", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildSqsApp(["delete-queue"]);
    await app.ready();
  });

  it("deletes a received message so it is not re-delivered", async () => {
    // Arrange
    await jsonRequest(app, "SendMessage", {
      QueueUrl: queueUrl("delete-queue"),
      MessageBody: "to-be-deleted",
    });
    const receiveResult = await jsonRequest(app, "ReceiveMessage", {
      QueueUrl: queueUrl("delete-queue"),
      MaxNumberOfMessages: 1,
    });
    const actualMessages = receiveResult.body["Messages"] as Array<Record<string, unknown>>;
    const actualReceiptHandle = actualMessages[0]?.["ReceiptHandle"] as string;

    // Act
    await jsonRequest(app, "DeleteMessage", {
      QueueUrl: queueUrl("delete-queue"),
      ReceiptHandle: actualReceiptHandle,
    });
    const actualSecondReceive = await jsonRequest(app, "ReceiveMessage", {
      QueueUrl: queueUrl("delete-queue"),
      MaxNumberOfMessages: 1,
    });

    // Assert
    const actualRemainingMessages = actualSecondReceive.body["Messages"] as Array<unknown>;
    expect(actualRemainingMessages).toHaveLength(0);
  });
});

describe("SQS integration — DeleteQueue", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildSqsApp(["to-delete"]);
    await app.ready();
  });

  it("deletes a queue so it no longer appears in ListQueues", async () => {
    // Arrange
    const listBefore = await jsonRequest(app, "ListQueues", {});
    const expectedUrlsBefore = listBefore.body["QueueUrls"] as string[];
    expect(expectedUrlsBefore.some((u) => u.includes("to-delete"))).toBe(true);

    // Act
    await jsonRequest(app, "DeleteQueue", { QueueUrl: queueUrl("to-delete") });
    const actualListAfter = await jsonRequest(app, "ListQueues", {});

    // Assert
    const actualUrls = actualListAfter.body["QueueUrls"] as string[];
    expect(actualUrls.some((u) => u.includes("to-delete"))).toBe(false);
  });
});

describe("SQS integration — PurgeQueue", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildSqsApp(["purge-queue"]);
    await app.ready();
  });

  it("purges all messages from the queue", async () => {
    // Arrange
    await jsonRequest(app, "SendMessage", {
      QueueUrl: queueUrl("purge-queue"),
      MessageBody: "msg1",
    });
    await jsonRequest(app, "SendMessage", {
      QueueUrl: queueUrl("purge-queue"),
      MessageBody: "msg2",
    });

    // Act
    await jsonRequest(app, "PurgeQueue", { QueueUrl: queueUrl("purge-queue") });
    const actualResult = await jsonRequest(app, "ReceiveMessage", {
      QueueUrl: queueUrl("purge-queue"),
      MaxNumberOfMessages: 10,
    });

    // Assert
    const actualMessages = actualResult.body["Messages"] as Array<unknown>;
    expect(actualMessages).toHaveLength(0);
  });
});

describe("SQS integration — GetQueueAttributes", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildSqsApp(["attr-queue"]);
    await app.ready();
  });

  it("returns queue attributes including ApproximateNumberOfMessages", async () => {
    // Arrange
    await jsonRequest(app, "SendMessage", {
      QueueUrl: queueUrl("attr-queue"),
      MessageBody: "test",
    });

    // Act
    const actualResult = await jsonRequest(app, "GetQueueAttributes", {
      QueueUrl: queueUrl("attr-queue"),
      AttributeNames: ["All"],
    });

    // Assert
    expect(actualResult.status).toBe(200);
    expect(actualResult.body["Attributes"]).toBeDefined();
  });
});

describe("SQS integration — SendMessageBatch / DeleteMessageBatch", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildSqsApp(["batch-queue"]);
  });

  it("sends multiple messages in one batch call and returns all MessageIds", async () => {
    // Arrange
    const expectedSuccessCount = 2;

    // Act
    const actualResult = await jsonRequest(app, "SendMessageBatch", {
      QueueUrl: queueUrl("batch-queue"),
      Entries: [
        { Id: "1", MessageBody: "hello" },
        { Id: "2", MessageBody: "world" },
      ],
    });

    // Assert
    expect(actualResult.status).toBe(200);
    expect((actualResult.body["Successful"] as unknown[]).length).toBe(expectedSuccessCount);
  });

  it("deletes multiple messages in one batch call", async () => {
    // Arrange
    await jsonRequest(app, "SendMessageBatch", {
      QueueUrl: queueUrl("batch-queue"),
      Entries: [
        { Id: "1", MessageBody: "a" },
        { Id: "2", MessageBody: "b" },
      ],
    });
    const received = await jsonRequest(app, "ReceiveMessage", {
      QueueUrl: queueUrl("batch-queue"),
      MaxNumberOfMessages: 10,
    });
    const expectedSuccessCount = 2;
    const expectedRemainingCount = 0;

    // Act
    const msgs = received.body["Messages"] as Array<{ ReceiptHandle: string }>;
    const actualDeleteResult = await jsonRequest(app, "DeleteMessageBatch", {
      QueueUrl: queueUrl("batch-queue"),
      Entries: msgs.map((m, i) => ({ Id: String(i + 1), ReceiptHandle: m.ReceiptHandle })),
    });

    // Assert
    expect(actualDeleteResult.status).toBe(200);
    expect((actualDeleteResult.body["Successful"] as unknown[]).length).toBe(expectedSuccessCount);
    const afterReceive = await jsonRequest(app, "ReceiveMessage", {
      QueueUrl: queueUrl("batch-queue"),
      MaxNumberOfMessages: 10,
    });
    expect((afterReceive.body["Messages"] as unknown[] | undefined) ?? []).toHaveLength(expectedRemainingCount);
  });
});
