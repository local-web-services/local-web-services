import { describe, it, expect, beforeEach } from "vitest";
import { SqsProvider } from "../../../../src/providers/sqs/provider.js";

describe("SqsProvider lifecycle", () => {
  it("healthCheck returns true after start", async () => {
    // Arrange
    const provider = new SqsProvider();
    const expectedHealthy = true;

    // Act
    await provider.start();
    const actualHealthy = await provider.healthCheck();

    // Assert
    expect(actualHealthy).toBe(expectedHealthy);
  });

  it("healthCheck returns false before start", async () => {
    // Arrange
    const provider = new SqsProvider();
    const expectedHealthy = false;

    // Act
    const actualHealthy = await provider.healthCheck();

    // Assert
    expect(actualHealthy).toBe(expectedHealthy);
  });

  it("stop clears all queues", async () => {
    // Arrange
    const provider = new SqsProvider();
    await provider.start();
    await provider.createQueue("temp-queue");
    const expectedQueueCount = 0;

    // Act
    await provider.stop();
    const actualQueueCount = provider.queues.size;

    // Assert
    expect(actualQueueCount).toBe(expectedQueueCount);
  });

  it("reset purges messages but keeps preconfigured queues", async () => {
    // Arrange
    const provider = new SqsProvider([{ queueName: "pre-queue" }]);
    await provider.start();
    const queue = provider.getQueue("pre-queue")!;
    await queue.sendMessage("msg-to-be-purged");
    await provider.createQueue("dynamic-queue");
    const expectedMessageCount = 0;
    const expectedQueueCount = 1;

    // Act
    await provider.reset();

    // Assert
    const actualMessageCount = provider.getQueue("pre-queue")!.messages.length;
    const actualQueueCount = provider.queues.size;
    expect(actualMessageCount).toBe(expectedMessageCount);
    expect(actualQueueCount).toBe(expectedQueueCount);
  });

  it("name is sqs", () => {
    // Arrange
    const provider = new SqsProvider();
    const expectedName = "sqs";

    // Act
    const actualName = provider.name;

    // Assert
    expect(actualName).toBe(expectedName);
  });
});

describe("SqsProvider tagging and queue attributes", () => {
  let provider: SqsProvider;

  beforeEach(async () => {
    provider = new SqsProvider([{ queueName: "my-queue" }]);
    await provider.start();
  });

  it("tagQueue stores tags retrievable via listQueueTags", async () => {
    // Arrange
    const expectedKey = "env";
    const expectedValue = "prod";

    // Act
    await provider.tagQueue("my-queue", { [expectedKey]: expectedValue });
    const actualTags = await provider.listQueueTags("my-queue");

    // Assert
    expect(actualTags[expectedKey]).toBe(expectedValue);
  });

  it("untagQueue removes a specific tag", async () => {
    // Arrange
    await provider.tagQueue("my-queue", { env: "prod", team: "platform" });
    const expectedAbsentKey = "env";

    // Act
    await provider.untagQueue("my-queue", [expectedAbsentKey]);
    const actualTags = await provider.listQueueTags("my-queue");
    const expectedRemainingKey = "team";
    const expectedRemainingValue = "platform";

    // Assert
    expect(actualTags[expectedAbsentKey]).toBeUndefined();
    expect(actualTags[expectedRemainingKey]).toBe(expectedRemainingValue);
  });

  it("setQueueAttributes does not throw for a valid queue", async () => {
    // Arrange
    const expectedNoThrow = true;
    let actualNoThrow = false;

    // Act
    await provider.setQueueAttributes("my-queue", { VisibilityTimeout: "60" });
    actualNoThrow = true;

    // Assert
    expect(actualNoThrow).toBe(expectedNoThrow);
  });

  it("listDeadLetterSourceQueues returns an empty array", async () => {
    // Arrange
    const expectedCount = 0;

    // Act
    const actualQueues = await provider.listDeadLetterSourceQueues("my-queue");

    // Assert
    expect(actualQueues).toHaveLength(expectedCount);
  });
});
