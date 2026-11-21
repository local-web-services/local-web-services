import { describe, it, expect, beforeAll, afterAll } from "vitest";
import { SQSClient } from "@aws-sdk/client-sqs";
import { LwsSession, SqsQueue } from "local-web-services-typescript-sdk";
import {
  enqueueOrder,
  processNextOrder,
} from "../../src/orderQueue.js";

describe("Order queue enqueue", () => {
  let session: LwsSession;
  let client: SQSClient;
  let queueUrl: string;

  beforeAll(async () => {
    session = new LwsSession(new SqsQueue("orders"));
    await session.start();
    client = new SQSClient(session.clientConfig("sqs"));
    queueUrl = session.queueUrl("orders");
  });

  afterAll(async () => {
    await session.stop();
  });

  it("enqueueOrder returns a non-empty message ID", async () => {
    // Arrange
    const expectedOrder = { orderId: "order-001" };

    // Act
    const actualMessageId = await enqueueOrder(expectedOrder, queueUrl, client);

    // Assert
    const expectedType = "string";
    expect(actualMessageId).toBeTruthy();
    expect(typeof actualMessageId).toBe(expectedType);
  });

  it("enqueueOrder returns different IDs for different orders", async () => {
    // Arrange
    const order1 = { orderId: "order-002" };
    const order2 = { orderId: "order-003" };

    // Act
    const actualId1 = await enqueueOrder(order1, queueUrl, client);
    const actualId2 = await enqueueOrder(order2, queueUrl, client);

    // Assert
    expect(actualId1).not.toBe(actualId2);
  });
});

describe("Order queue process", () => {
  let session: LwsSession;
  let client: SQSClient;
  let queueUrl: string;

  beforeAll(async () => {
    session = new LwsSession(new SqsQueue("process-orders"));
    await session.start();
    client = new SQSClient(session.clientConfig("sqs"));
    queueUrl = session.queueUrl("process-orders");
  });

  afterAll(async () => {
    await session.stop();
  });

  it("processNextOrder returns null when queue is empty", async () => {
    // Arrange (queue is empty on session start)

    // Act
    const actualOrder = await processNextOrder(queueUrl, client);

    // Assert
    expect(actualOrder).toBeNull();
  });

  it("processNextOrder returns the enqueued order", async () => {
    // Arrange
    const expectedOrder = { orderId: "order-process-001" };
    await enqueueOrder(expectedOrder, queueUrl, client);

    // Act
    const actualOrder = await processNextOrder(queueUrl, client);

    // Assert
    expect(actualOrder?.orderId).toBe(expectedOrder.orderId);
  });

  it("processNextOrder removes the message from the queue", async () => {
    // Arrange
    const order = { orderId: "order-consume-001" };
    await enqueueOrder(order, queueUrl, client);
    await processNextOrder(queueUrl, client);

    // Act
    const actualSecondReceive = await processNextOrder(queueUrl, client);

    // Assert
    expect(actualSecondReceive).toBeNull();
  });
});
