import { Given } from "@cucumber/cucumber";
import { PutItemCommand } from "@aws-sdk/client-dynamodb";
import type { DynamoWorld } from "../support/world.js";
import { TEST_TABLE, TEST_PK } from "../support/world.js";

Given("the dynamodb system is initialized", async function (this: DynamoWorld) {
  // Session started in BeforeAll
});

Given('the "dynamodb" "table" existed', async function (this: DynamoWorld) {
  // Pre-configured table is always present after session start
});

Given('the "dynamodb" "table" did not exist', async function (this: DynamoWorld) {
  // After reset(), pre-configured tables have no items; dynamic tables removed
});

Given('the "dynamodb" "item" existed', async function (this: DynamoWorld) {
  await this.dynamoClient.send(
    new PutItemCommand({
      TableName: TEST_TABLE,
      Item: { pk: { S: TEST_PK }, data: { S: "seed-value" } },
    }),
  );
});

Given('the "dynamodb" "item" did not exist', async function (this: DynamoWorld) {
  // Table is empty after reset()
});

Given('the "dynamodb" "item" was "PRESENT"', async function (this: DynamoWorld) {
  // Item already exists from the "existed" step
});
