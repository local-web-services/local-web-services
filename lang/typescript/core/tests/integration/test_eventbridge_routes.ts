import { describe, it, expect, beforeEach, afterEach } from "vitest";
import Fastify from "fastify";
import type { FastifyInstance } from "fastify";
import { EventBridgeProvider } from "../../src/providers/eventbridge/provider.js";
import { eventBridgeRoutesPlugin } from "../../src/providers/eventbridge/routes.js";

async function buildEbApp(): Promise<FastifyInstance> {
  const provider = new EventBridgeProvider([]);
  await provider.start();
  const app = Fastify({ logger: false });
  await app.register(eventBridgeRoutesPlugin, { provider });
  await app.ready();
  return app;
}

async function ebRequest(
  app: FastifyInstance,
  operation: string,
  payload: Record<string, unknown>,
): Promise<{ status: number; body: Record<string, unknown> }> {
  const response = await app.inject({
    method: "POST",
    url: "/",
    headers: {
      "content-type": "application/x-amz-json-1.1",
      "x-amz-target": `AWSEvents.${operation}`,
    },
    payload: JSON.stringify(payload),
  });
  return { status: response.statusCode, body: JSON.parse(response.body) as Record<string, unknown> };
}

describe("EventBridge routes — CreateEventBus / DescribeEventBus", () => {
  let app: FastifyInstance;

  beforeEach(async () => { app = await buildEbApp(); });
  afterEach(async () => { await app.close(); });

  it("CreateEventBus returns an ARN", async () => {
    // Arrange
    const expectedBusName = "test-bus";

    // Act
    const actual = await ebRequest(app, "CreateEventBus", { Name: expectedBusName });

    // Assert
    expect(actual.status).toBe(200);
    expect((actual.body["EventBusArn"] as string)).toContain(expectedBusName);
  });

  it("DescribeEventBus returns the bus info", async () => {
    // Arrange
    const expectedBusName = "describe-bus";
    await ebRequest(app, "CreateEventBus", { Name: expectedBusName });

    // Act
    const actual = await ebRequest(app, "DescribeEventBus", { Name: expectedBusName });

    // Assert
    expect(actual.status).toBe(200);
    expect(actual.body["Name"]).toBe(expectedBusName);
  });

  it("CreateEventBus twice returns 400", async () => {
    // Arrange
    const expectedStatus = 400;
    await ebRequest(app, "CreateEventBus", { Name: "dup-bus" });

    // Act
    const actual = await ebRequest(app, "CreateEventBus", { Name: "dup-bus" });

    // Assert
    expect(actual.status).toBe(expectedStatus);
  });
});

describe("EventBridge routes — PutRule / ListRules", () => {
  let app: FastifyInstance;

  beforeEach(async () => { app = await buildEbApp(); });
  afterEach(async () => { await app.close(); });

  it("PutRule returns a RuleArn", async () => {
    // Arrange
    const expectedRuleName = "my-rule";

    // Act
    const actual = await ebRequest(app, "PutRule", {
      Name: expectedRuleName,
      EventPattern: '{"source":["test"]}',
    });

    // Assert
    expect(actual.status).toBe(200);
    expect((actual.body["RuleArn"] as string)).toContain(expectedRuleName);
  });

  it("ListRules returns created rules", async () => {
    // Arrange
    const expectedRuleName = "listed-rule";
    await ebRequest(app, "PutRule", { Name: expectedRuleName });

    // Act
    const actual = await ebRequest(app, "ListRules", { EventBusName: "default" });

    // Assert
    const actualRules = actual.body["Rules"] as Array<{ Name: string }>;
    expect(actualRules.some((r) => r.Name === expectedRuleName)).toBe(true);
  });
});

describe("EventBridge routes — PutEvents", () => {
  let app: FastifyInstance;

  beforeEach(async () => { app = await buildEbApp(); });
  afterEach(async () => { await app.close(); });

  it("PutEvents returns EventIds", async () => {
    // Arrange
    const expectedFailedCount = 0;

    // Act
    const actual = await ebRequest(app, "PutEvents", {
      Entries: [{ Source: "test", DetailType: "TestEvent", Detail: "{}" }],
    });

    // Assert
    expect(actual.status).toBe(200);
    expect(actual.body["FailedEntryCount"]).toBe(expectedFailedCount);
    const entries = actual.body["Entries"] as Array<{ EventId: string }>;
    expect(entries[0]?.EventId).toBeDefined();
  });

  it("DeleteEventBus on default returns 400 ValidationException", async () => {
    // Arrange
    const expectedStatus = 400;

    // Act
    const actual = await ebRequest(app, "DeleteEventBus", { Name: "default" });

    // Assert
    expect(actual.status).toBe(expectedStatus);
    expect(actual.body["__type"]).toBe("ValidationException");
  });
});
