import { describe, it, expect, beforeEach } from "vitest";
import { DynamoProvider } from "../../../../src/providers/dynamodb/provider.js";

describe("DynamoProvider batch and transact operations", () => {
  let provider: DynamoProvider;

  beforeEach(async () => {
    provider = new DynamoProvider([{ tableName: "batch-table", hashKey: "pk" }]);
    await provider.start();
    provider.putItem("batch-table", { pk: { S: "row1" }, val: { S: "a" } });
    provider.putItem("batch-table", { pk: { S: "row2" }, val: { S: "b" } });
  });

  it("batchGetItem returns found items for each requested key", () => {
    // Arrange
    const expectedCount = 2;
    const expectedFirstVal = "a";

    // Act
    const actualResponses = provider.batchGetItem({
      "batch-table": { Keys: [{ pk: { S: "row1" } }, { pk: { S: "row2" } }] },
    });

    // Assert
    const actualItems = actualResponses["batch-table"] ?? [];
    expect(actualItems).toHaveLength(expectedCount);
    expect((actualItems[0]?.["val"] as { S: string } | undefined)?.S).toBe(expectedFirstVal);
  });

  it("batchWriteItem applies puts and deletes", () => {
    // Arrange
    const expectedNewVal = "c";
    const expectedDeletedItem = undefined;

    // Act
    provider.batchWriteItem({
      "batch-table": [
        { PutRequest: { Item: { pk: { S: "row3" }, val: { S: expectedNewVal } } } },
        { DeleteRequest: { Key: { pk: { S: "row1" } } } },
      ],
    });

    // Assert
    const actualNew = provider.getItem("batch-table", { pk: { S: "row3" } });
    const actualDeleted = provider.getItem("batch-table", { pk: { S: "row1" } });
    expect((actualNew?.["val"] as { S: string } | undefined)?.S).toBe(expectedNewVal);
    expect(actualDeleted).toBe(expectedDeletedItem);
  });
});

describe("DynamoProvider tagging operations", () => {
  let provider: DynamoProvider;

  beforeEach(async () => {
    provider = new DynamoProvider([{ tableName: "tag-table", hashKey: "pk" }]);
    await provider.start();
  });

  it("tagResource stores tags retrievable via listTagsOfResource", () => {
    // Arrange
    const expectedKey = "env";
    const expectedValue = "prod";
    const arn = provider.tableArn("tag-table");

    // Act
    provider.tagResource(arn, [{ Key: expectedKey, Value: expectedValue }]);
    const actualTags = provider.listTagsOfResource(arn);

    // Assert
    const actualTag = actualTags.find((t) => t.Key === expectedKey);
    expect(actualTag?.Value).toBe(expectedValue);
  });

  it("untagResource removes the specified tag", () => {
    // Arrange
    const arn = provider.tableArn("tag-table");
    provider.tagResource(arn, [
      { Key: "env", Value: "prod" },
      { Key: "team", Value: "platform" },
    ]);
    const expectedRemainingKey = "team";
    const expectedAbsentKey = "env";

    // Act
    provider.untagResource(arn, [expectedAbsentKey]);
    const actualTags = provider.listTagsOfResource(arn);

    // Assert
    const expectedRemainingValue = "platform";
    expect(actualTags.find((t) => t.Key === expectedAbsentKey)).toBeUndefined();
    expect(actualTags.find((t) => t.Key === expectedRemainingKey)?.Value).toBe(expectedRemainingValue);
  });
});

describe("DynamoProvider TTL operations", () => {
  let provider: DynamoProvider;

  beforeEach(async () => {
    provider = new DynamoProvider([{ tableName: "ttl-table", hashKey: "pk" }]);
    await provider.start();
  });

  it("describeTimeToLive returns DISABLED by default", () => {
    // Arrange
    const expectedStatus = "DISABLED";

    // Act
    const actualResult = provider.describeTimeToLive("ttl-table") as { TimeToLiveDescription: { TimeToLiveStatus: string } };

    // Assert
    expect(actualResult.TimeToLiveDescription.TimeToLiveStatus).toBe(expectedStatus);
  });

  it("updateTimeToLive then describeTimeToLive returns ENABLED", () => {
    // Arrange
    const expectedStatus = "ENABLED";
    const expectedAttribute = "expires_at";

    // Act
    provider.updateTimeToLive("ttl-table", { attributeName: expectedAttribute, enabled: true });
    const actualResult = provider.describeTimeToLive("ttl-table") as { TimeToLiveDescription: { TimeToLiveStatus: string; AttributeName: string } };

    // Assert
    expect(actualResult.TimeToLiveDescription.TimeToLiveStatus).toBe(expectedStatus);
    expect(actualResult.TimeToLiveDescription.AttributeName).toBe(expectedAttribute);
  });
});
