import { describe, it, expect, beforeEach } from "vitest";
import { SnsProvider } from "../../../../src/providers/sns/provider.js";

describe("SnsProvider lifecycle", () => {
  it("starts and reports healthy", async () => {
    // Arrange
    const provider = new SnsProvider([]);

    // Act
    await provider.start();

    // Assert
    const actualHealthy = await provider.healthCheck();
    expect(actualHealthy).toBe(true);
    await provider.stop();
  });

  it("pre-seeds topics from config", async () => {
    // Arrange
    const expectedName = "my-topic";
    const provider = new SnsProvider([{ name: expectedName }]);
    await provider.start();

    // Act
    const actualTopics = provider.listTopics();

    // Assert
    const expectedArnSubstring = expectedName;
    expect(actualTopics.some((a) => a.includes(expectedArnSubstring))).toBe(true);
    await provider.stop();
  });
});

describe("SnsProvider createTopic / deleteTopic", () => {
  let provider: SnsProvider;

  beforeEach(async () => {
    provider = new SnsProvider([]);
    await provider.start();
  });

  it("creates a topic and returns its ARN", () => {
    // Arrange
    const expectedTopicName = "orders-topic";

    // Act
    const actualArn = provider.createTopic(expectedTopicName);

    // Assert
    expect(actualArn).toContain(expectedTopicName);
  });

  it("lists the created topic", () => {
    // Arrange
    const expectedCount = 1;
    provider.createTopic("listed-topic");

    // Act
    const actualTopics = provider.listTopics();

    // Assert
    expect(actualTopics).toHaveLength(expectedCount);
  });

  it("deletes a topic so it no longer appears in list", () => {
    // Arrange
    const arn = provider.createTopic("temp-topic");
    const expectedCount = 0;

    // Act
    provider.deleteTopic(arn);
    const actualTopics = provider.listTopics();

    // Assert
    expect(actualTopics).toHaveLength(expectedCount);
  });

  it("throws NotFoundException when deleting a non-existent topic", () => {
    // Arrange
    const expectedError = "NotFoundException";

    // Act
    const actualFn = () => provider.deleteTopic("arn:aws:sns:us-east-1:000000000000:ghost");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });
});

describe("SnsProvider publish / subscribe", () => {
  let provider: SnsProvider;
  let topicArn: string;

  beforeEach(async () => {
    provider = new SnsProvider([]);
    await provider.start();
    topicArn = provider.createTopic("events-topic");
  });

  it("publishes a message and returns a MessageId", () => {
    // Arrange
    const expectedMessage = "hello world";

    // Act
    const actualMsgId = provider.publish(topicArn, expectedMessage);

    // Assert
    expect(actualMsgId).toBeTruthy();
  });

  it("stores published messages for inspection", () => {
    // Arrange
    const expectedMessage = "inspect-me";
    const expectedCount = 1;

    // Act
    provider.publish(topicArn, expectedMessage);
    const actualMessages = provider.getPublishedMessages(topicArn);

    // Assert
    expect(actualMessages).toHaveLength(expectedCount);
    expect(actualMessages[0]?.Message).toBe(expectedMessage);
  });

  it("subscribes to a topic and returns a SubscriptionArn", () => {
    // Arrange
    const expectedProtocol = "https";

    // Act
    const actualSubArn = provider.subscribe(topicArn, expectedProtocol, "https://example.com");

    // Assert
    expect(actualSubArn).toContain(topicArn);
  });

  it("lists subscriptions for a topic after subscribing", () => {
    // Arrange
    provider.subscribe(topicArn, "sqs", "arn:aws:sqs:us-east-1:000000000000:my-queue");
    const expectedCount = 1;

    // Act
    const actualSubs = provider.listSubscriptionsByTopic(topicArn);

    // Assert
    expect(actualSubs).toHaveLength(expectedCount);
  });

  it("reset clears published messages in pre-configured topics", async () => {
    // Arrange
    const seeded = new SnsProvider([{ name: "pre-topic" }]);
    await seeded.start();
    const arn = seeded.listTopics()[0]!;
    seeded.publish(arn, "msg-to-clear");
    const expectedCount = 0;

    // Act
    await seeded.reset();
    const actualMessages = seeded.getPublishedMessages(arn);

    // Assert
    expect(actualMessages).toHaveLength(expectedCount);
    await seeded.stop();
  });
});
