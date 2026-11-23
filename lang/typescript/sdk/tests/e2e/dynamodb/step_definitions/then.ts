import { Then } from "@cucumber/cucumber";
import { GetItemCommand } from "@aws-sdk/client-dynamodb";
import type { DynamoWorld } from "../support/world.js";
import { TEST_TABLE, TEST_PK } from "../support/world.js";

Then('the "dynamodb" "item" will be "PRESENT" in the "dynamodb" "table"', async function (this: DynamoWorld) {
  const resp = await this.dynamoClient.send(
    new GetItemCommand({ TableName: TEST_TABLE, Key: { pk: { S: TEST_PK } } }),
  );
  if (resp.Item === undefined) throw new Error("Expected item to be present but it was absent");
});

Then('the "dynamodb" "item" will be "ABSENT" from the "dynamodb" "table"', async function (this: DynamoWorld) {
  const resp = await this.dynamoClient.send(
    new GetItemCommand({ TableName: TEST_TABLE, Key: { pk: { S: TEST_PK } } }),
  );
  if (resp.Item !== undefined) throw new Error("Expected item to be absent but it was present");
});

Then('the retrieved "dynamodb" "item" is "PRESENT"', async function (this: DynamoWorld) {
  if (this.item === null) throw new Error("Expected retrieved item to be present but got null");
});

Then('the retrieved "dynamodb" "item" is "ABSENT"', async function (this: DynamoWorld) {
  if (this.item !== null) throw new Error("Expected retrieved item to be absent");
});

Then('the "dynamodb" "table" scan returns at least one "item"', async function (this: DynamoWorld) {
  const resp = this.result as { Count?: number } | null;
  const count = resp?.Count ?? 0;
  if (count < 1) throw new Error(`Expected at least 1 scanned item but got ${count}`);
});

Then('the "dynamodb" query returns the "item"', async function (this: DynamoWorld) {
  const resp = this.result as { Count?: number } | null;
  const count = resp?.Count ?? 0;
  if (count < 1) throw new Error(`Expected query to return at least 1 item but got ${count}`);
});

Then("the dynamodb operation is rejected", async function (this: DynamoWorld) {
  if (this.error === null) throw new Error("Expected an error but no error was thrown");
});

Then('the "dynamodb" "item" data attribute will be "updated"', async function (this: DynamoWorld) {
  const resp = await this.dynamoClient.send(
    new GetItemCommand({ TableName: TEST_TABLE, Key: { pk: { S: TEST_PK } } }),
  );
  const item = resp.Item as Record<string, { S?: string }> | undefined;
  const actual = item?.["data"]?.S;
  const expected = "updated-value";
  if (actual !== expected) throw new Error(`Expected data="${expected}" but got "${actual}"`);
});
