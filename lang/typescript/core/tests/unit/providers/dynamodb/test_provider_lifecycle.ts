/**
 * Unit tests for DynamoProvider lifecycle and table management.
 */

import { describe, it, expect, beforeEach } from "vitest";
import { DynamoProvider } from "../../../../src/providers/dynamodb/provider.js";

describe("DynamoProvider lifecycle", () => {
  let provider: DynamoProvider;

  beforeEach(async () => {
    provider = new DynamoProvider();
    await provider.start();
  });

  it("reports healthy after start", async () => {
    // Arrange
    const expectedHealth = true;

    // Act
    const actualHealth = await provider.healthCheck();

    // Assert
    expect(actualHealth).toBe(expectedHealth);
  });

  it("reports unhealthy after stop", async () => {
    // Arrange
    const expectedHealth = false;
    await provider.stop();

    // Act
    const actualHealth = await provider.healthCheck();

    // Assert
    expect(actualHealth).toBe(expectedHealth);
  });
});

describe("DynamoProvider pre-configured tables", () => {
  it("creates pre-configured tables on start", async () => {
    // Arrange
    const expectedTableName = "users";
    const provider = new DynamoProvider([{ tableName: expectedTableName, hashKey: "pk" }]);

    // Act
    await provider.start();

    // Assert
    expect(provider.listTables()).toContain(expectedTableName);
  });

  it("lists pre-configured tables sorted alphabetically", async () => {
    // Arrange
    const expectedOrder = ["alpha", "beta", "gamma"];
    const provider = new DynamoProvider([
      { tableName: "gamma", hashKey: "pk" },
      { tableName: "alpha", hashKey: "pk" },
      { tableName: "beta", hashKey: "pk" },
    ]);
    await provider.start();

    // Act
    const actualTables = provider.listTables();

    // Assert
    expect(actualTables).toEqual(expectedOrder);
  });
});

describe("DynamoProvider createTable / deleteTable", () => {
  let provider: DynamoProvider;

  beforeEach(async () => {
    provider = new DynamoProvider();
    await provider.start();
  });

  it("creates a table that appears in listTables", () => {
    // Arrange
    const expectedTableName = "orders";

    // Act
    provider.createTable({ tableName: expectedTableName, hashKey: "orderId" });

    // Assert
    expect(provider.listTables()).toContain(expectedTableName);
  });

  it("throws on duplicate table creation", () => {
    // Arrange
    provider.createTable({ tableName: "dup-table", hashKey: "pk" });

    // Act
    const actualFn = () => provider.createTable({ tableName: "dup-table", hashKey: "pk" });

    // Assert
    expect(actualFn).toThrow("ResourceInUseException");
  });

  it("deletes a table so it no longer appears in listTables", () => {
    // Arrange
    provider.createTable({ tableName: "temp", hashKey: "pk" });

    // Act
    provider.deleteTable("temp");

    // Assert
    expect(provider.listTables()).not.toContain("temp");
  });

  it("throws when deleting a non-existent table", () => {
    // Arrange (no table created)

    // Act
    const actualFn = () => provider.deleteTable("ghost");

    // Assert
    expect(actualFn).toThrow("ResourceNotFoundException");
  });
});

describe("DynamoProvider reset", () => {
  it("removes dynamic tables on reset", async () => {
    // Arrange
    const provider = new DynamoProvider([{ tableName: "static-table", hashKey: "pk" }]);
    await provider.start();
    provider.createTable({ tableName: "dynamic-table", hashKey: "pk" });

    // Act
    await provider.reset();

    // Assert
    const actualTables = provider.listTables();
    expect(actualTables).toContain("static-table");
    expect(actualTables).not.toContain("dynamic-table");
  });

  it("purges items from pre-configured tables on reset", async () => {
    // Arrange
    const provider = new DynamoProvider([{ tableName: "my-table", hashKey: "pk" }]);
    await provider.start();
    provider.putItem("my-table", { pk: { S: "row1" }, data: { S: "value" } });

    // Act
    await provider.reset();

    // Assert
    const actualItem = provider.getItem("my-table", { pk: { S: "row1" } });
    expect(actualItem).toBeUndefined();
  });
});
