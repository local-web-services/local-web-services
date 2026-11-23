import { describe, it, expect, beforeEach } from "vitest";
import { SnsProvider } from "../../../../src/providers/sns/provider.js";

describe("SnsProvider tagging and subscription attributes", () => {
  let provider: SnsProvider;
  let topicArn: string;

  beforeEach(async () => {
    provider = new SnsProvider();
    await provider.start();
    topicArn = provider.createTopic("test-topic");
  });

  it("tagTopic stores tags retrievable via listTopicTags", () => {
    // Arrange
    const expectedKey = "env";
    const expectedValue = "prod";

    // Act
    provider.tagTopic(topicArn, { [expectedKey]: expectedValue });
    const actualTags = provider.listTopicTags(topicArn);

    // Assert
    expect(actualTags[expectedKey]).toBe(expectedValue);
  });

  it("untagTopic removes a specific tag", () => {
    // Arrange
    provider.tagTopic(topicArn, { env: "prod", team: "platform" });
    const expectedAbsentKey = "env";
    const expectedRemainingKey = "team";
    const expectedRemainingValue = "platform";

    // Act
    provider.untagTopic(topicArn, [expectedAbsentKey]);
    const actualTags = provider.listTopicTags(topicArn);

    // Assert
    expect(actualTags[expectedAbsentKey]).toBeUndefined();
    expect(actualTags[expectedRemainingKey]).toBe(expectedRemainingValue);
  });

  it("setSubscriptionAttribute updates an attribute retrievable via getSubscriptionAttributes", () => {
    // Arrange
    const subArn = provider.subscribe(topicArn, "http", "http://example.com");
    const expectedAttributeName = "RawMessageDelivery";
    const expectedAttributeValue = "true";

    // Act
    provider.setSubscriptionAttribute(subArn, expectedAttributeName, expectedAttributeValue);
    const actualAttrs = provider.getSubscriptionAttributes(subArn);

    // Assert
    expect(actualAttrs[expectedAttributeName]).toBe(expectedAttributeValue);
  });

  it("confirmSubscription returns a SubscriptionArn", () => {
    // Arrange
    const expectedArnSubstring = topicArn;

    // Act
    const actualSubArn = provider.confirmSubscription(topicArn);

    // Assert
    expect(actualSubArn).toContain(expectedArnSubstring);
  });
});
