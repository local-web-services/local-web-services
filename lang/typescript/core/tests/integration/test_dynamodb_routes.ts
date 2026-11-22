/**
 * Integration tests for the DynamoDB routes plugin using Fastify's inject() transport.
 */

import { describe, it, expect, beforeEach } from "vitest";
import Fastify from "fastify";
import type { FastifyInstance } from "fastify";
import { DynamoProvider } from "../../src/providers/dynamodb/provider.js";
import { dynamoRoutesPlugin } from "../../src/providers/dynamodb/routes.js";

async function buildDynamoApp(tableNames: string[] = []): Promise<FastifyInstance> {
  const provider = new DynamoProvider(tableNames.map((name) => ({ tableName: name, hashKey: "pk" })));
  await provider.start();
  const app = Fastify({ logger: false });
  app.register(dynamoRoutesPlugin, { provider });
  return app;
}

async function dynamoRequest(
  app: FastifyInstance,
  action: string,
  payload: Record<string, unknown>,
): Promise<{ status: number; body: Record<string, unknown> }> {
  const response = await app.inject({
    method: "POST",
    url: "/",
    headers: {
      "content-type": "application/x-amz-json-1.0",
      "x-amz-target": `DynamoDB_20120810.${action}`,
    },
    payload: JSON.stringify(payload),
  });
  return { status: response.statusCode, body: JSON.parse(response.body) as Record<string, unknown> };
}

describe("DynamoDB integration — CreateTable", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildDynamoApp();
    await app.ready();
  });

  it("creates a table and returns TableDescription", async () => {
    // Arrange
    const expectedTableName = "test-table";

    // Act
    const actualResult = await dynamoRequest(app, "CreateTable", {
      TableName: expectedTableName,
      KeySchema: [{ AttributeName: "pk", KeyType: "HASH" }],
      AttributeDefinitions: [{ AttributeName: "pk", AttributeType: "S" }],
      BillingMode: "PAY_PER_REQUEST",
    });

    // Assert
    expect(actualResult.status).toBe(200);
    const desc = actualResult.body["TableDescription"] as Record<string, unknown>;
    expect(desc["TableName"]).toBe(expectedTableName);
  });

  it("returns ResourceInUseException for duplicate table", async () => {
    // Arrange
    await dynamoRequest(app, "CreateTable", {
      TableName: "dup",
      KeySchema: [{ AttributeName: "pk", KeyType: "HASH" }],
      AttributeDefinitions: [{ AttributeName: "pk", AttributeType: "S" }],
      BillingMode: "PAY_PER_REQUEST",
    });

    // Act
    const actualResult = await dynamoRequest(app, "CreateTable", {
      TableName: "dup",
      KeySchema: [{ AttributeName: "pk", KeyType: "HASH" }],
      AttributeDefinitions: [{ AttributeName: "pk", AttributeType: "S" }],
      BillingMode: "PAY_PER_REQUEST",
    });

    // Assert
    expect(actualResult.status).toBe(400);
    expect(actualResult.body["__type"]).toBe("ResourceInUseException");
  });
});

describe("DynamoDB integration — PutItem / GetItem", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildDynamoApp(["put-get-table"]);
    await app.ready();
  });

  it("puts an item and retrieves it by key", async () => {
    // Arrange
    const expectedValue = "hello-dynamo";
    await dynamoRequest(app, "PutItem", {
      TableName: "put-get-table",
      Item: { pk: { S: "row1" }, msg: { S: expectedValue } },
    });

    // Act
    const actualResult = await dynamoRequest(app, "GetItem", {
      TableName: "put-get-table",
      Key: { pk: { S: "row1" } },
    });

    // Assert
    expect(actualResult.status).toBe(200);
    const item = actualResult.body["Item"] as Record<string, Record<string, string>>;
    expect(item["msg"]?.["S"]).toBe(expectedValue);
  });

  it("returns empty body for missing key", async () => {
    // Arrange (table is empty)

    // Act
    const actualResult = await dynamoRequest(app, "GetItem", {
      TableName: "put-get-table",
      Key: { pk: { S: "ghost" } },
    });

    // Assert
    expect(actualResult.status).toBe(200);
    expect(actualResult.body["Item"]).toBeUndefined();
  });

  it("returns ResourceNotFoundException for missing table", async () => {
    // Arrange (no such table)

    // Act
    const actualResult = await dynamoRequest(app, "GetItem", {
      TableName: "no-table",
      Key: { pk: { S: "row1" } },
    });

    // Assert
    expect(actualResult.status).toBe(400);
    expect(actualResult.body["__type"]).toBe("ResourceNotFoundException");
  });
});

describe("DynamoDB integration — DeleteItem", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildDynamoApp(["del-table"]);
    await app.ready();
  });

  it("deletes an item so subsequent GetItem returns nothing", async () => {
    // Arrange
    await dynamoRequest(app, "PutItem", {
      TableName: "del-table",
      Item: { pk: { S: "gone" }, data: { S: "value" } },
    });

    // Act
    await dynamoRequest(app, "DeleteItem", {
      TableName: "del-table",
      Key: { pk: { S: "gone" } },
    });
    const actualResult = await dynamoRequest(app, "GetItem", {
      TableName: "del-table",
      Key: { pk: { S: "gone" } },
    });

    // Assert
    expect(actualResult.body["Item"]).toBeUndefined();
  });
});

describe("DynamoDB integration — UpdateItem", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildDynamoApp(["upd-table"]);
    await app.ready();
  });

  it("updates an attribute and returns the new value", async () => {
    // Arrange
    await dynamoRequest(app, "PutItem", {
      TableName: "upd-table",
      Item: { pk: { S: "r1" }, v: { S: "old" } },
    });
    const expectedValue = "new-value";

    // Act
    const actualResult = await dynamoRequest(app, "UpdateItem", {
      TableName: "upd-table",
      Key: { pk: { S: "r1" } },
      UpdateExpression: "SET v = :val",
      ExpressionAttributeValues: { ":val": { S: expectedValue } },
    });

    // Assert
    expect(actualResult.status).toBe(200);
    const attrs = actualResult.body["Attributes"] as Record<string, Record<string, string>>;
    expect(attrs["v"]?.["S"]).toBe(expectedValue);
  });
});

describe("DynamoDB integration — Scan", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildDynamoApp(["scan-table"]);
    await app.ready();
    await dynamoRequest(app, "PutItem", { TableName: "scan-table", Item: { pk: { S: "a" }, type: { S: "X" } } });
    await dynamoRequest(app, "PutItem", { TableName: "scan-table", Item: { pk: { S: "b" }, type: { S: "Y" } } });
    await dynamoRequest(app, "PutItem", { TableName: "scan-table", Item: { pk: { S: "c" }, type: { S: "X" } } });
  });

  it("returns all items on full scan", async () => {
    // Arrange
    const expectedCount = 3;

    // Act
    const actualResult = await dynamoRequest(app, "Scan", { TableName: "scan-table" });

    // Assert
    expect(actualResult.status).toBe(200);
    expect(actualResult.body["Count"]).toBe(expectedCount);
  });

  it("filters items with FilterExpression", async () => {
    // Arrange
    const expectedCount = 2;

    // Act
    const actualResult = await dynamoRequest(app, "Scan", {
      TableName: "scan-table",
      FilterExpression: "type = :t",
      ExpressionAttributeValues: { ":t": { S: "X" } },
    });

    // Assert
    expect(actualResult.status).toBe(200);
    expect(actualResult.body["Count"]).toBe(expectedCount);
  });
});

describe("DynamoDB integration — Query", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    const provider = new DynamoProvider([
      { tableName: "query-table", hashKey: "pk", sortKey: "sk", sortKeyType: "S" },
    ]);
    await provider.start();
    app = Fastify({ logger: false });
    app.register(dynamoRoutesPlugin, { provider });
    await app.ready();
    await dynamoRequest(app, "PutItem", { TableName: "query-table", Item: { pk: { S: "u1" }, sk: { S: "a" }, v: { N: "1" } } });
    await dynamoRequest(app, "PutItem", { TableName: "query-table", Item: { pk: { S: "u1" }, sk: { S: "b" }, v: { N: "2" } } });
    await dynamoRequest(app, "PutItem", { TableName: "query-table", Item: { pk: { S: "u2" }, sk: { S: "a" }, v: { N: "3" } } });
  });

  it("queries items by partition key", async () => {
    // Arrange
    const expectedCount = 2;

    // Act
    const actualResult = await dynamoRequest(app, "Query", {
      TableName: "query-table",
      KeyConditionExpression: "pk = :pk",
      ExpressionAttributeValues: { ":pk": { S: "u1" } },
    });

    // Assert
    expect(actualResult.status).toBe(200);
    expect(actualResult.body["Count"]).toBe(expectedCount);
  });
});

describe("DynamoDB integration — ListTables / DescribeTable", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildDynamoApp(["t1", "t2"]);
    await app.ready();
  });

  it("returns pre-configured table names in ListTables", async () => {
    // Arrange
    const expectedNames = ["t1", "t2"];

    // Act
    const actualResult = await dynamoRequest(app, "ListTables", {});

    // Assert
    const actualNames = actualResult.body["TableNames"] as string[];
    for (const name of expectedNames) {
      expect(actualNames).toContain(name);
    }
  });

  it("returns ACTIVE status in DescribeTable", async () => {
    // Arrange
    const expectedStatus = "ACTIVE";

    // Act
    const actualResult = await dynamoRequest(app, "DescribeTable", { TableName: "t1" });

    // Assert
    const table = actualResult.body["Table"] as Record<string, unknown>;
    expect(table["TableStatus"]).toBe(expectedStatus);
  });
});
