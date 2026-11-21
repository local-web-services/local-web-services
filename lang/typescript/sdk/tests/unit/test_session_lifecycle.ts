import { describe, it, expect, beforeAll, afterAll } from "vitest";
import { LwsSession } from "../../src/session.js";
import { SqsQueue } from "../../src/specs.js";

describe("LwsSession start and stop", () => {
  it("sets AWS_ENDPOINT_URL_SQS after start", async () => {
    // Arrange
    const session = new LwsSession(new SqsQueue("TestQueue"));
    const originalUrl = process.env["AWS_ENDPOINT_URL_SQS"];

    // Act
    await session.start();

    // Assert
    expect(process.env["AWS_ENDPOINT_URL_SQS"]).toMatch(/^http:\/\/127\.0\.0\.1:\d+$/);

    await session.stop();
    expect(process.env["AWS_ENDPOINT_URL_SQS"]).toBe(originalUrl);
  });

  it("sets AWS test credentials after start", async () => {
    // Arrange
    const expectedCredential = "ldk-local";
    const session = new LwsSession(new SqsQueue("TestQueue"));

    // Act
    await session.start();

    // Assert
    expect(process.env["AWS_ACCESS_KEY_ID"]).toBe(expectedCredential);
    expect(process.env["AWS_SECRET_ACCESS_KEY"]).toBe(expectedCredential);

    await session.stop();
  });

  it("restores env vars after stop", async () => {
    // Arrange
    const savedSqsUrl = process.env["AWS_ENDPOINT_URL_SQS"];
    const savedKeyId = process.env["AWS_ACCESS_KEY_ID"];
    const session = new LwsSession(new SqsQueue("TestQueue"));

    // Act
    await session.start();
    await session.stop();

    // Assert
    expect(process.env["AWS_ENDPOINT_URL_SQS"]).toBe(savedSqsUrl);
    expect(process.env["AWS_ACCESS_KEY_ID"]).toBe(savedKeyId);
  });

  it("starts without any resource specs", async () => {
    // Arrange
    const session = new LwsSession();

    // Act
    const actualPromise = session.start();

    // Assert
    await expect(actualPromise).resolves.toBeUndefined();
    await session.stop();
  });

  it("supports Symbol.asyncDispose", async () => {
    // Arrange
    const session = new LwsSession(new SqsQueue("TestQueue"));
    await session.start();

    // Act
    await session[Symbol.asyncDispose]();

    // Assert — env should be restored
    expect(process.env["AWS_ENDPOINT_URL_SQS"]).toBeUndefined();
  });
});

describe("LwsSession reset", () => {
  let session: LwsSession;

  beforeAll(async () => {
    session = new LwsSession(new SqsQueue("ResetQueue"));
    await session.start();
  });

  afterAll(async () => {
    await session.stop();
  });

  it("reset returns without error", async () => {
    // Arrange (session started in beforeAll)

    // Act
    const actualPromise = session.reset();

    // Assert
    await expect(actualPromise).resolves.toBeUndefined();
  });
});

describe("LwsSession management URL", () => {
  it("management URL follows expected format", async () => {
    // Arrange
    const session = new LwsSession();

    // Act
    await session.start();

    // Assert
    expect(session.managementUrl).toMatch(/^http:\/\/127\.0\.0\.1:\d+$/);

    await session.stop();
  });
});
