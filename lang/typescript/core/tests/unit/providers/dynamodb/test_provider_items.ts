/**
 * Unit tests for DynamoProvider item operations.
 */

import { describe, it, expect, beforeEach } from "vitest";
import { DynamoProvider } from "../../../../src/providers/dynamodb/provider.js";

describe("DynamoProvider putItem / getItem", () => {
  let provider: DynamoProvider;

  beforeEach(async () => {
    provider = new DynamoProvider([{ tableName: "items-table", hashKey: "pk" }]);
    await provider.start();
  });

  it("retrieves a put item by its hash key", () => {
    // Arrange
    const expectedValue = "hello";
    provider.putItem("items-table", { pk: { S: "row1" }, msg: { S: expectedValue } });

    // Act
    const actualItem = provider.getItem("items-table", { pk: { S: "row1" } });

    // Assert
    expect((actualItem?.["msg"] as { S: string } | undefined)?.S).toBe(expectedValue);
  });

  it("returns undefined for a missing item", () => {
    // Arrange (table is empty)

    // Act
    const actualItem = provider.getItem("items-table", { pk: { S: "missing" } });

    // Assert
    expect(actualItem).toBeUndefined();
  });

  it("overwrites an existing item on second put", () => {
    // Arrange
    provider.putItem("items-table", { pk: { S: "row1" }, v: { S: "original" } });
    const expectedValue = "updated";

    // Act
    provider.putItem("items-table", { pk: { S: "row1" }, v: { S: expectedValue } });
    const actualItem = provider.getItem("items-table", { pk: { S: "row1" } });

    // Assert
    expect((actualItem?.["v"] as { S: string } | undefined)?.S).toBe(expectedValue);
  });
});

describe("DynamoProvider deleteItem", () => {
  let provider: DynamoProvider;

  beforeEach(async () => {
    provider = new DynamoProvider([{ tableName: "del-table", hashKey: "pk" }]);
    await provider.start();
  });

  it("deletes an item so subsequent getItem returns undefined", () => {
    // Arrange
    provider.putItem("del-table", { pk: { S: "to-delete" } });

    // Act
    provider.deleteItem("del-table", { pk: { S: "to-delete" } });

    // Assert
    const actualItem = provider.getItem("del-table", { pk: { S: "to-delete" } });
    expect(actualItem).toBeUndefined();
  });

  it("returns the deleted item", () => {
    // Arrange
    const expectedValue = "bye";
    provider.putItem("del-table", { pk: { S: "gone" }, data: { S: expectedValue } });

    // Act
    const actualDeleted = provider.deleteItem("del-table", { pk: { S: "gone" } });

    // Assert
    expect((actualDeleted?.["data"] as { S: string } | undefined)?.S).toBe(expectedValue);
  });
});

describe("DynamoProvider updateItem", () => {
  let provider: DynamoProvider;

  beforeEach(async () => {
    provider = new DynamoProvider([{ tableName: "upd-table", hashKey: "pk" }]);
    await provider.start();
  });

  it("sets a new attribute on an existing item", () => {
    // Arrange
    provider.putItem("upd-table", { pk: { S: "row1" }, a: { S: "old" } });
    const expectedValue = "new";

    // Act
    provider.updateItem(
      "upd-table",
      { pk: { S: "row1" } },
      "SET a = :val",
      { expressionAttributeValues: { ":val": { S: expectedValue } } },
    );
    const actualItem = provider.getItem("upd-table", { pk: { S: "row1" } });

    // Assert
    expect((actualItem?.["a"] as { S: string } | undefined)?.S).toBe(expectedValue);
  });

  it("removes an attribute with REMOVE clause", () => {
    // Arrange
    provider.putItem("upd-table", { pk: { S: "row2" }, tmp: { S: "transient" } });

    // Act
    provider.updateItem("upd-table", { pk: { S: "row2" } }, "REMOVE tmp");
    const actualItem = provider.getItem("upd-table", { pk: { S: "row2" } });

    // Assert
    expect(actualItem?.["tmp"]).toBeUndefined();
  });
});

describe("DynamoProvider scan", () => {
  let provider: DynamoProvider;

  beforeEach(async () => {
    provider = new DynamoProvider([{ tableName: "scan-table", hashKey: "pk" }]);
    await provider.start();
    provider.putItem("scan-table", { pk: { S: "a" }, status: { S: "active" } });
    provider.putItem("scan-table", { pk: { S: "b" }, status: { S: "inactive" } });
    provider.putItem("scan-table", { pk: { S: "c" }, status: { S: "active" } });
  });

  it("returns all items when no filter is applied", () => {
    // Arrange
    const expectedCount = 3;

    // Act
    const actualItems = provider.scan("scan-table");

    // Assert
    expect(actualItems).toHaveLength(expectedCount);
  });

  it("applies a filter expression to narrow results", () => {
    // Arrange
    const expectedCount = 2;

    // Act
    const actualItems = provider.scan(
      "scan-table",
      "status = :s",
      { expressionAttributeValues: { ":s": { S: "active" } } },
    );

    // Assert
    expect(actualItems).toHaveLength(expectedCount);
  });
});

describe("DynamoProvider query", () => {
  let provider: DynamoProvider;

  beforeEach(async () => {
    provider = new DynamoProvider([
      { tableName: "query-table", hashKey: "pk", sortKey: "sk", sortKeyType: "S" },
    ]);
    await provider.start();
    provider.putItem("query-table", { pk: { S: "user1" }, sk: { S: "order#1" }, total: { N: "10" } });
    provider.putItem("query-table", { pk: { S: "user1" }, sk: { S: "order#2" }, total: { N: "20" } });
    provider.putItem("query-table", { pk: { S: "user2" }, sk: { S: "order#1" }, total: { N: "5" } });
  });

  it("returns all items for a given partition key", () => {
    // Arrange
    const expectedCount = 2;

    // Act
    const actualItems = provider.query(
      "query-table",
      "pk = :pk",
      { expressionAttributeValues: { ":pk": { S: "user1" } } },
    );

    // Assert
    expect(actualItems).toHaveLength(expectedCount);
  });

  it("throws when no partition key condition is provided", () => {
    // Arrange (expression missing pk)

    // Act
    const actualFn = () =>
      provider.query("query-table", "sk = :sk", {
        expressionAttributeValues: { ":sk": { S: "order#1" } },
      });

    // Assert
    expect(actualFn).toThrow("ValidationException");
  });
});
