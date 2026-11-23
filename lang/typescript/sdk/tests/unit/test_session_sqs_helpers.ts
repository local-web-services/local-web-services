import { describe, it, expect, beforeAll, afterAll } from "vitest";
import { LwsSession } from "../../src/session.js";
import { SqsQueue } from "../../src/specs.js";

describe("LwsSession SQS endpoint helpers", () => {
  let session: LwsSession;

  beforeAll(async () => {
    session = new LwsSession(new SqsQueue("TestQueue"));
    await session.start();
  });

  afterAll(async () => {
    await session.stop();
  });

  it("endpointUrl returns HTTP URL for sqs", () => {
    // Arrange (session started in beforeAll)

    // Act
    const actualUrl = session.endpointUrl("sqs");

    // Assert
    expect(actualUrl).toMatch(/^http:\/\/127\.0\.0\.1:\d+$/);
  });

  it("endpointUrl throws for unknown service", () => {
    // Arrange
    const unknownService = "not-a-real-service";

    // Act
    const actualThrow = () => session.endpointUrl(unknownService);

    // Assert
    expect(actualThrow).toThrow(/not available/);
  });

  it("queueUrl returns expected format", () => {
    // Arrange
    const expectedQueueName = "TestQueue";
    const expectedPattern = /^http:\/\/127\.0\.0\.1:\d+\/000000000000\/TestQueue$/;

    // Act
    const actualUrl = session.queueUrl(expectedQueueName);

    // Assert
    expect(actualUrl).toMatch(expectedPattern);
  });

  it("queueUrl port matches endpointUrl port", () => {
    // Arrange
    const endpointUrl = session.endpointUrl("sqs");
    const expectedPort = new URL(endpointUrl).port;

    // Act
    const actualQueueUrl = session.queueUrl("AnyQueue");

    // Assert
    expect(new URL(actualQueueUrl).port).toBe(expectedPort);
  });

  it("clientConfig returns endpoint credentials and region", () => {
    // Arrange
    const expectedAccessKeyId = "test";
    const expectedSecretAccessKey = "test";
    const expectedRegion = "us-east-1";

    // Act
    const actualConfig = session.clientConfig("sqs");

    // Assert
    expect(actualConfig.endpoint).toMatch(/^http:\/\/127\.0\.0\.1:\d+$/);
    expect(actualConfig.credentials.accessKeyId).toBe(expectedAccessKeyId);
    expect(actualConfig.credentials.secretAccessKey).toBe(expectedSecretAccessKey);
    expect(actualConfig.region).toBe(expectedRegion);
  });

  it("clientConfig endpoint matches endpointUrl", () => {
    // Arrange
    const expectedEndpoint = session.endpointUrl("sqs");

    // Act
    const actualConfig = session.clientConfig("sqs");

    // Assert
    expect(actualConfig.endpoint).toBe(expectedEndpoint);
  });
});

describe("LwsSession ChaosBuilder and FakeBuilder factories", () => {
  let session: LwsSession;

  beforeAll(async () => {
    session = new LwsSession();
    await session.start();
  });

  afterAll(async () => {
    await session.stop();
  });

  it("chaos returns a ChaosBuilder for the given service", () => {
    // Arrange
    const expectedService = "sqs";

    // Act
    const actualBuilder = session.chaos(expectedService);

    // Assert
    expect(actualBuilder).toBeDefined();
    const payload = actualBuilder.errorRate(0.5).build();
    expect(Object.keys(payload)).toContain(expectedService);
  });

  it("fake returns a FakeBuilder for the given service", () => {
    // Arrange
    const expectedService = "sqs";

    // Act
    const actualBuilder = session.fake(expectedService);

    // Assert
    expect(actualBuilder).toBeDefined();
    const payload = actualBuilder
      .operation("SendMessage")
      .respond(500, "")
      .build();
    expect(Object.keys(payload)).toContain(expectedService);
  });
});
