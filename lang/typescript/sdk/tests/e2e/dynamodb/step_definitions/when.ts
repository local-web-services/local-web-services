import { When } from "@cucumber/cucumber";
import {
  PutItemCommand,
  GetItemCommand,
  DeleteItemCommand,
  UpdateItemCommand,
  ScanCommand,
  QueryCommand,
} from "@aws-sdk/client-dynamodb";
import type { DynamoWorld } from "../support/world.js";
import { TEST_TABLE, TEST_PK } from "../support/world.js";

When('a "dynamodb" "item" is put into the "dynamodb" "table"', async function (this: DynamoWorld) {
  try {
    this.result = await this.dynamoClient.send(
      new PutItemCommand({
        TableName: TEST_TABLE,
        Item: { pk: { S: TEST_PK }, data: { S: "test-value" } },
      }),
    );
    this.error = null;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "dynamodb" "item" is retrieved from the "dynamodb" "table"', async function (this: DynamoWorld) {
  try {
    const resp = await this.dynamoClient.send(
      new GetItemCommand({
        TableName: TEST_TABLE,
        Key: { pk: { S: TEST_PK } },
      }),
    );
    this.item = (resp.Item as Record<string, unknown>) ?? null;
    this.error = null;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "dynamodb" "item" is deleted from the "dynamodb" "table"', async function (this: DynamoWorld) {
  try {
    this.result = await this.dynamoClient.send(
      new DeleteItemCommand({
        TableName: TEST_TABLE,
        Key: { pk: { S: TEST_PK } },
      }),
    );
    this.error = null;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "dynamodb" "item" is updated in the "dynamodb" "table"', async function (this: DynamoWorld) {
  try {
    this.result = await this.dynamoClient.send(
      new UpdateItemCommand({
        TableName: TEST_TABLE,
        Key: { pk: { S: TEST_PK } },
        UpdateExpression: "SET data = :val",
        ExpressionAttributeValues: { ":val": { S: "updated-value" } },
      }),
    );
    this.error = null;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('the "dynamodb" "table" is scanned', async function (this: DynamoWorld) {
  try {
    const resp = await this.dynamoClient.send(
      new ScanCommand({ TableName: TEST_TABLE }),
    );
    this.result = resp;
    this.error = null;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('the "dynamodb" "table" is queried by "pk"', async function (this: DynamoWorld) {
  try {
    const resp = await this.dynamoClient.send(
      new QueryCommand({
        TableName: TEST_TABLE,
        KeyConditionExpression: "pk = :pk",
        ExpressionAttributeValues: { ":pk": { S: TEST_PK } },
      }),
    );
    this.result = resp;
    this.error = null;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "dynamodb" "item" is put into a non-existent "dynamodb" "table"', async function (this: DynamoWorld) {
  try {
    await this.dynamoClient.send(
      new PutItemCommand({
        TableName: "does-not-exist",
        Item: { pk: { S: "k" } },
      }),
    );
    this.error = null;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});
