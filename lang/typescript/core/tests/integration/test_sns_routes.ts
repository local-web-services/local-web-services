import { describe, it, expect, beforeEach, afterEach } from "vitest";
import Fastify from "fastify";
import type { FastifyInstance } from "fastify";
import { SnsProvider } from "../../src/providers/sns/provider.js";
import { snsRoutesPlugin } from "../../src/providers/sns/routes.js";

async function buildSnsApp(): Promise<FastifyInstance> {
  const provider = new SnsProvider([]);
  await provider.start();
  const app = Fastify({ logger: false });
  await app.register(snsRoutesPlugin, { provider });
  await app.ready();
  return app;
}

async function snsRequest(
  app: FastifyInstance,
  params: Record<string, string>,
): Promise<{ status: number; body: string }> {
  const body = new URLSearchParams(params).toString();
  const response = await app.inject({
    method: "POST",
    url: "/",
    headers: { "content-type": "application/x-www-form-urlencoded" },
    payload: body,
  });
  return { status: response.statusCode, body: response.body };
}

function extractArn(xml: string, tag: string): string {
  const regex = new RegExp(`<${tag}>(.*?)</${tag}>`);
  const m = regex.exec(xml);
  return m?.[1] ?? "";
}

describe("SNS routes — CreateTopic / DeleteTopic", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildSnsApp();
  });

  afterEach(async () => {
    await app.close();
  });

  it("CreateTopic returns a TopicArn in XML", async () => {
    // Arrange
    const expectedTopicName = "orders-topic";

    // Act
    const actualResult = await snsRequest(app, { Action: "CreateTopic", TopicName: expectedTopicName });

    // Assert
    expect(actualResult.status).toBe(200);
    expect(actualResult.body).toContain(expectedTopicName);
    expect(actualResult.body).toContain("TopicArn");
  });

  it("ListTopics returns the created topic", async () => {
    // Arrange
    const expectedTopicName = "listed-topic";
    await snsRequest(app, { Action: "CreateTopic", TopicName: expectedTopicName });

    // Act
    const actualResult = await snsRequest(app, { Action: "ListTopics" });

    // Assert
    expect(actualResult.status).toBe(200);
    expect(actualResult.body).toContain(expectedTopicName);
  });

  it("DeleteTopic removes the topic", async () => {
    // Arrange
    const createResult = await snsRequest(app, { Action: "CreateTopic", TopicName: "temp-topic" });
    const expectedTopicArn = extractArn(createResult.body, "TopicArn");

    // Act
    const actualDeleteResult = await snsRequest(app, { Action: "DeleteTopic", TopicArn: expectedTopicArn });
    const actualListResult = await snsRequest(app, { Action: "ListTopics" });

    // Assert
    expect(actualDeleteResult.status).toBe(200);
    expect(actualListResult.body).not.toContain(expectedTopicArn);
  });

  it("DeleteTopic returns 400 for a non-existent topic", async () => {
    // Arrange
    const expectedStatus = 400;

    // Act
    const actualResult = await snsRequest(app, {
      Action: "DeleteTopic",
      TopicArn: "arn:aws:sns:us-east-1:000000000000:ghost-topic",
    });

    // Assert
    expect(actualResult.status).toBe(expectedStatus);
  });
});

describe("SNS routes — Publish / Subscribe", () => {
  let app: FastifyInstance;
  let topicArn: string;

  beforeEach(async () => {
    app = await buildSnsApp();
    const result = await snsRequest(app, { Action: "CreateTopic", TopicName: "events-topic" });
    topicArn = extractArn(result.body, "TopicArn");
  });

  afterEach(async () => {
    await app.close();
  });

  it("Publish returns a MessageId in XML", async () => {
    // Arrange
    const expectedMessage = "hello-world";

    // Act
    const actualResult = await snsRequest(app, {
      Action: "Publish",
      TopicArn: topicArn,
      Message: expectedMessage,
    });

    // Assert
    expect(actualResult.status).toBe(200);
    expect(actualResult.body).toContain("MessageId");
  });

  it("Subscribe returns a SubscriptionArn in XML", async () => {
    // Arrange
    const expectedTopicArn = topicArn;

    // Act
    const actualResult = await snsRequest(app, {
      Action: "Subscribe",
      TopicArn: expectedTopicArn,
      Protocol: "sqs",
      Endpoint: "arn:aws:sqs:us-east-1:000000000000:my-queue",
    });

    // Assert
    expect(actualResult.status).toBe(200);
    expect(actualResult.body).toContain("SubscriptionArn");
  });
});
