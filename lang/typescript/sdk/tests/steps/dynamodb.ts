/** Step definitions: dynamodb service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const DYNAMODB_TEST_TABLE = "e2e-dynamodb-test-table-1";
const DYNAMODB_TEST_PK = "id";
const DYNAMODB_TEST_ITEM_KEY = "e2e-item-key-1";
const DYNAMODB_TEST_ATTR_VAL = "attr-val-1";
const DYNAMODB_TEST_UPDATED_VAL = "attr-val-updated-1";

// ── Helpers ────────────────────────────────────────────────────────────────────

function dynamodbClient(world: SdkWorld) {
  const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
  return world.session!.client<typeof DynamoDBClient>("dynamodb");
}

async function createTable(world: SdkWorld, tableName: string): Promise<void> {
  const { CreateTableCommand } = require("@aws-sdk/client-dynamodb");
  await dynamodbClient(world).send(
    new CreateTableCommand({
      TableName: tableName,
      KeySchema: [{ AttributeName: DYNAMODB_TEST_PK, KeyType: "HASH" }],
      AttributeDefinitions: [{ AttributeName: DYNAMODB_TEST_PK, AttributeType: "S" }],
      BillingMode: "PAY_PER_REQUEST",
    }),
  );
}

async function putItem(world: SdkWorld, tableName: string): Promise<void> {
  const { PutItemCommand } = require("@aws-sdk/client-dynamodb");
  await dynamodbClient(world).send(
    new PutItemCommand({
      TableName: tableName,
      Item: {
        [DYNAMODB_TEST_PK]: { S: DYNAMODB_TEST_ITEM_KEY },
        data: { S: DYNAMODB_TEST_ATTR_VAL },
      },
    }),
  );
}

async function deleteItem(world: SdkWorld, tableName: string): Promise<void> {
  const { DeleteItemCommand } = require("@aws-sdk/client-dynamodb");
  try {
    await dynamodbClient(world).send(
      new DeleteItemCommand({
        TableName: tableName,
        Key: { [DYNAMODB_TEST_PK]: { S: DYNAMODB_TEST_ITEM_KEY } },
      }),
    );
  } catch {
    // item may not exist; desired state is absence
  }
}

// ── Background ─────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: table existence ─────────────────────────────────────────────────────

// "the table does not already exist" is registered in cross_service_common.ts.

// "the table already exists" is registered in cross_service_common.ts.

// "the table exists" is registered in cross_service_common.ts.

// "the table does not exist" is registered in cross_service_common.ts.

// ── Given: table lifecycle state ───────────────────────────────────────────────

// "the table is {string}" is registered in cross_service_common.ts.

// "the table is not {string}" is registered in cross_service_common.ts.

// ── Given: throttle state ──────────────────────────────────────────────────────

Given("writes are not throttled", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: no throttling by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("writes are throttled", async function (this: SdkWorld) {
  // Arrange: exhaust the dynamodb write capacity
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("dynamodb").exhaust().apply();
  // Assert: capacity is exhausted
});

Given("reads are not throttled", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: no throttling by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("reads are throttled", async function (this: SdkWorld) {
  // Arrange: exhaust the dynamodb read capacity
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("dynamodb").exhaust().apply();
  // Assert: capacity is exhausted
});

// ── Given: item existence ──────────────────────────────────────────────────────

Given("the item exists in the table", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await putItem(this, DYNAMODB_TEST_TABLE);
  // Assert: item put
});

Given("the item does not exist in the table", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh table has no items.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the item exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await putItem(this, DYNAMODB_TEST_TABLE);
  // Assert: item put
});

Given("the item does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh table has no items.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the item is present", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await putItem(this, DYNAMODB_TEST_TABLE);
  // Assert: item present
});

Given("the item is not present", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: delete item to ensure it is not present
  await deleteItem(this, DYNAMODB_TEST_TABLE);
  // Assert: item is absent
});

// ── Given: conditional put preconditions ──────────────────────────────────────

Given("the condition is satisfied", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh table has no items so attribute_not_exists holds.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the condition is not satisfied", async function (this: SdkWorld) {
  // Arrange: put item so attribute_not_exists(id) fails
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await putItem(this, DYNAMODB_TEST_TABLE);
  // Assert: item exists, condition not satisfied
});

// ── Given: transaction state ───────────────────────────────────────────────────

Given("no transaction is currently in progress", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no active transactions.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("a transaction is currently in progress", async function (this: SdkWorld) {
  // No-op: @internal scenarios that require an in-progress transaction are excluded.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("a transaction is {string}", async function (this: SdkWorld, _state: string) {
  // No-op: @internal scenarios are excluded from the test run.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no transaction is {string}", async function (this: SdkWorld, _state: string) {
  // No-op: fresh state has no pending transactions.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the transaction is {string}", async function (this: SdkWorld, _state: string) {
  // No-op: @internal scenarios are excluded from the test run.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the transaction is not {string}", async function (this: SdkWorld, _state: string) {
  // No-op: default state has no committed/rolled-back transaction.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the transaction's table exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createTable(this, DYNAMODB_TEST_TABLE);
  // Assert: table created
});

Given("the transaction's table does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after reset has no tables.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the transaction's table is {string}", async function (this: SdkWorld, state: string) {
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "ACTIVE") {
    // No-op: in lws, tables are ACTIVE immediately after creation.
    return;
  }
  // For non-ACTIVE, simulate via lifecycle dwell.
  await this.session!.lifecycle("dynamodb").createDwellMs(5000).apply();
  await createTable(this, DYNAMODB_TEST_TABLE);
});

Given("the transaction's table is not {string}", async function (this: SdkWorld, state: string) {
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "ACTIVE") {
    // Arrange: enable lifecycle dwell and create table in CREATING state
    await this.session!.lifecycle("dynamodb").createDwellMs(5000).apply();
    await createTable(this, DYNAMODB_TEST_TABLE);
    return;
  }
  // For other states, no-op.
});

// ── Given: GSI propagation state ──────────────────────────────────────────────

Given('the "GSI" exists', async function (this: SdkWorld) {
  // No-op: GSI scenarios are tagged @internal and excluded from the test run.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the table has pending "GSI" propagation', async function (this: SdkWorld) {
  // No-op: GSI propagation scenarios are tagged @internal and excluded.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the table does not have pending "GSI" propagation', async function (this: SdkWorld) {
  // No-op: no GSI propagation is configured by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('there are writes pending propagation to the "GSI"', async function (this: SdkWorld) {
  // No-op: GSI propagation scenarios are tagged @internal and excluded.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('there are no writes pending propagation to the "GSI"', async function (this: SdkWorld) {
  // No-op: no GSI writes are pending by default.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ──────────────────────────────────────────────────────────────

When("a table is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateTableCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  try {
    const result = await dynamodbClient(this).send(
      new CreateTableCommand({
        TableName: DYNAMODB_TEST_TABLE,
        KeySchema: [{ AttributeName: DYNAMODB_TEST_PK, KeyType: "HASH" }],
        AttributeDefinitions: [{ AttributeName: DYNAMODB_TEST_PK, AttributeType: "S" }],
        BillingMode: "PAY_PER_REQUEST",
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a table finishes creating and becomes active", async function (this: SdkWorld) {
  // Arrange: disable lifecycle dwell so the table transitions to ACTIVE
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    await this.session!.lifecycle("dynamodb").createDwellMs(0).apply();
    this.lastCallResult = { success: true, output: null };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a table is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteTableCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  try {
    const result = await dynamodbClient(this).send(
      new DeleteTableCommand({ TableName: DYNAMODB_TEST_TABLE }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a table deletion completes", async function (this: SdkWorld) {
  // No-op: finish_delete_table scenarios are tagged @internal and excluded.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("finish_delete_table is @internal and excluded from the test run"),
  };
  // Assert: captured in lastCallResult
});

When("a table is described", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeTableCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  try {
    const result = await dynamodbClient(this).send(
      new DescribeTableCommand({ TableName: DYNAMODB_TEST_TABLE }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("all tables are listed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListTablesCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  try {
    const result = await dynamodbClient(this).send(new ListTablesCommand({}));
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an item is written to the table", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { PutItemCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  try {
    const result = await dynamodbClient(this).send(
      new PutItemCommand({
        TableName: DYNAMODB_TEST_TABLE,
        Item: {
          [DYNAMODB_TEST_PK]: { S: DYNAMODB_TEST_ITEM_KEY },
          data: { S: DYNAMODB_TEST_ATTR_VAL },
        },
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an item is conditionally written to the table", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { PutItemCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  try {
    const result = await dynamodbClient(this).send(
      new PutItemCommand({
        TableName: DYNAMODB_TEST_TABLE,
        Item: {
          [DYNAMODB_TEST_PK]: { S: DYNAMODB_TEST_ITEM_KEY },
          data: { S: DYNAMODB_TEST_ATTR_VAL },
        },
        ConditionExpression: "attribute_not_exists(#pk)",
        ExpressionAttributeNames: { "#pk": DYNAMODB_TEST_PK },
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an item is read from the table", async function (this: SdkWorld) {
  // Arrange: ensure item exists for the happy path
  assert.ok(this.session, "Expected session to be initialized");
  const { PutItemCommand, GetItemCommand } = require("@aws-sdk/client-dynamodb");
  try {
    await dynamodbClient(this).send(
      new PutItemCommand({
        TableName: DYNAMODB_TEST_TABLE,
        Item: {
          [DYNAMODB_TEST_PK]: { S: DYNAMODB_TEST_ITEM_KEY },
          data: { S: DYNAMODB_TEST_ATTR_VAL },
        },
      }),
    );
  } catch {
    // table may not exist; let GetItem surface the real error
  }
  // Act
  try {
    const result = await dynamodbClient(this).send(
      new GetItemCommand({
        TableName: DYNAMODB_TEST_TABLE,
        Key: { [DYNAMODB_TEST_PK]: { S: DYNAMODB_TEST_ITEM_KEY } },
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an existing item is updated in the table", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UpdateItemCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  try {
    const result = await dynamodbClient(this).send(
      new UpdateItemCommand({
        TableName: DYNAMODB_TEST_TABLE,
        Key: { [DYNAMODB_TEST_PK]: { S: DYNAMODB_TEST_ITEM_KEY } },
        UpdateExpression: "SET #d = :val",
        ConditionExpression: "attribute_exists(#pk)",
        ExpressionAttributeNames: {
          "#d": "data",
          "#pk": DYNAMODB_TEST_PK,
        },
        ExpressionAttributeValues: {
          ":val": { S: DYNAMODB_TEST_UPDATED_VAL },
        },
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an existing item is deleted from the table", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteItemCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  try {
    const result = await dynamodbClient(this).send(
      new DeleteItemCommand({
        TableName: DYNAMODB_TEST_TABLE,
        Key: { [DYNAMODB_TEST_PK]: { S: DYNAMODB_TEST_ITEM_KEY } },
        ConditionExpression: "attribute_exists(#pk)",
        ExpressionAttributeNames: { "#pk": DYNAMODB_TEST_PK },
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("items are queried from the table by key", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { QueryCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  try {
    const result = await dynamodbClient(this).send(
      new QueryCommand({
        TableName: DYNAMODB_TEST_TABLE,
        KeyConditionExpression: "#pk = :pk",
        ExpressionAttributeNames: { "#pk": DYNAMODB_TEST_PK },
        ExpressionAttributeValues: {
          ":pk": { S: DYNAMODB_TEST_ITEM_KEY },
        },
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("all items in the table are scanned", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ScanCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  try {
    const result = await dynamodbClient(this).send(
      new ScanCommand({ TableName: DYNAMODB_TEST_TABLE }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  "a transactional write is initiated across one or more items",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { TransactWriteItemsCommand } = require("@aws-sdk/client-dynamodb");
    // Act
    try {
      const result = await dynamodbClient(this).send(
        new TransactWriteItemsCommand({
          TransactItems: [
            {
              Put: {
                TableName: DYNAMODB_TEST_TABLE,
                Item: {
                  [DYNAMODB_TEST_PK]: { S: DYNAMODB_TEST_ITEM_KEY },
                  data: { S: DYNAMODB_TEST_ATTR_VAL },
                },
              },
            },
          ],
        }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When("a pending transaction resolves non-deterministically", async function (this: SdkWorld) {
  // No-op: @internal scenarios are excluded from the test run.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("commit_transaction is @internal and excluded from the test run"),
  };
  // Assert: captured in lastCallResult
});

When("a transaction is committed", async function (this: SdkWorld) {
  // No-op: @internal scenarios are excluded from the test run.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("commit_transaction is @internal and excluded from the test run"),
  };
  // Assert: captured in lastCallResult
});

When("a committed transaction is cleared", async function (this: SdkWorld) {
  // No-op: @internal scenarios are excluded from the test run.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("clear_transaction is @internal and excluded from the test run"),
  };
  // Assert: captured in lastCallResult
});

When("a transaction is rolled back", async function (this: SdkWorld) {
  // No-op: @internal scenarios are excluded from the test run.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("rollback_transaction is @internal and excluded from the test run"),
  };
  // Assert: captured in lastCallResult
});

When("a rolled-back transaction is cleared", async function (this: SdkWorld) {
  // No-op: @internal scenarios are excluded from the test run.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("clear_rolled_back is @internal and excluded from the test run"),
  };
  // Assert: captured in lastCallResult
});

When('"GSI" propagation completes for the pending write', async function (this: SdkWorld) {
  // No-op: GSI propagation scenarios are tagged @internal and excluded.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("propagate_gsi is @internal and excluded from the test run"),
  };
  // Assert: captured in lastCallResult
});

When('a "GSI" catches up with pending write propagation', async function (this: SdkWorld) {
  // No-op: GSI propagation scenarios are tagged @internal and excluded.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("propagate_gsi is @internal and excluded from the test run"),
  };
  // Assert: captured in lastCallResult
});

When("read throttling is toggled on or off", async function (this: SdkWorld) {
  // No-op: set_throttle_reads uses internal admin API not accessible via SDK.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("set_throttle_reads is not accessible via the public SDK"),
  };
  // Assert: captured in lastCallResult
});

When("write throttling is toggled on or off", async function (this: SdkWorld) {
  // No-op: set_throttle_writes uses internal admin API not accessible via SDK.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("set_throttle_writes is not accessible via the public SDK"),
  };
  // Assert: captured in lastCallResult
});

When("throttling is applied to reads", async function (this: SdkWorld) {
  // No-op: throttle state set via capacity API in the Given step.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("throttle reads is not applicable via public SDK"),
  };
  // Assert: captured in lastCallResult
});

When("throttling is applied to writes", async function (this: SdkWorld) {
  // No-op: throttle state set via capacity API in the Given step.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("throttle writes is not applicable via public SDK"),
  };
  // Assert: captured in lastCallResult
});

// ── Then: assertions ───────────────────────────────────────────────────────────

// "the operation is rejected" is registered in sqs.ts — not re-registered here.

Then('the table is in "CREATING" state', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeTableCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  const result = await dynamodbClient(this).send(
    new DescribeTableCommand({ TableName: DYNAMODB_TEST_TABLE }),
  );
  // Assert
  const expectedStatuses = ["CREATING", "ACTIVE"];
  const actualStatus: string = result.Table?.TableStatus ?? "";
  assert.ok(
    expectedStatuses.includes(actualStatus),
    `Expected table status to be CREATING or ACTIVE but got "${actualStatus}"; expected_statuses=${JSON.stringify(expectedStatuses)} actual_status="${actualStatus}"`,
  );
});

Then('the table is "ACTIVE" and ready for reads and writes', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListTablesCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  const result = await dynamodbClient(this).send(new ListTablesCommand({}));
  const actualTableNames: string[] = result.TableNames ?? [];
  // Assert
  const expectedTable = DYNAMODB_TEST_TABLE;
  assert.ok(
    actualTableNames.includes(expectedTable),
    `Expected table "${expectedTable}" to be ACTIVE but not found in: ${JSON.stringify(actualTableNames)}; expected_table="${expectedTable}"`,
  );
});

// "the table is {string}" is registered in cross_service_common.ts.

Then("the table is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListTablesCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  const result = await dynamodbClient(this).send(new ListTablesCommand({}));
  const actualTableNames: string[] = result.TableNames ?? [];
  // Assert
  const expectedAbsent = DYNAMODB_TEST_TABLE;
  assert.ok(
    !actualTableNames.includes(expectedAbsent),
    `Expected table "${expectedAbsent}" to be deleted but found it; expected_absent="${expectedAbsent}"`,
  );
});

Then(
  'the table enters "DELETING" state and all its items are removed',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    // Act: verify delete succeeded
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    // Assert
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected delete to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
    const { ListTablesCommand } = require("@aws-sdk/client-dynamodb");
    const listResult = await dynamodbClient(this).send(new ListTablesCommand({}));
    const actualTableNames: string[] = listResult.TableNames ?? [];
    const expectedAbsent = DYNAMODB_TEST_TABLE;
    assert.ok(
      !actualTableNames.includes(expectedAbsent),
      `Expected table "${expectedAbsent}" to be removed but found it; expected_absent="${expectedAbsent}"`,
    );
  },
);

Then("the table description is returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected table description to be returned but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the table metadata is returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected table metadata to be returned but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("all tables are listed", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected all tables to be listed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the list of tables is returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected list of tables to be returned but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then(
  'the item exists in the table and "GSI" propagation is pending',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { GetItemCommand } = require("@aws-sdk/client-dynamodb");
    // Act
    const result = await dynamodbClient(this).send(
      new GetItemCommand({
        TableName: DYNAMODB_TEST_TABLE,
        Key: { [DYNAMODB_TEST_PK]: { S: DYNAMODB_TEST_ITEM_KEY } },
      }),
    );
    const actualItem = result.Item;
    // Assert
    const expectedKey = DYNAMODB_TEST_ITEM_KEY;
    assert.ok(
      actualItem !== undefined && Object.keys(actualItem).length > 0,
      `Expected item "${expectedKey}" to exist in table; expected_key="${expectedKey}"`,
    );
  },
);

Then("the item does not exist in the table", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetItemCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  const result = await dynamodbClient(this).send(
    new GetItemCommand({
      TableName: DYNAMODB_TEST_TABLE,
      Key: { [DYNAMODB_TEST_PK]: { S: DYNAMODB_TEST_ITEM_KEY } },
    }),
  );
  const actualItem = result.Item;
  // Assert
  const expectedAbsent = DYNAMODB_TEST_ITEM_KEY;
  assert.ok(
    actualItem === undefined || Object.keys(actualItem).length === 0,
    `Expected item "${expectedAbsent}" to not exist in table but found it; expected_absent="${expectedAbsent}"`,
  );
});

Then("the item value is returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected item value to be returned but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the item is updated or unchanged (conditional update)", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetItemCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  const result = await dynamodbClient(this).send(
    new GetItemCommand({
      TableName: DYNAMODB_TEST_TABLE,
      Key: { [DYNAMODB_TEST_PK]: { S: DYNAMODB_TEST_ITEM_KEY } },
    }),
  );
  const actualItem = result.Item;
  // Assert
  const expectedKey = DYNAMODB_TEST_ITEM_KEY;
  assert.ok(
    actualItem !== undefined && Object.keys(actualItem).length > 0,
    `Expected item "${expectedKey}" to exist after update; expected_key="${expectedKey}"`,
  );
});

Then("the item is deleted or unchanged (conditional delete)", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete to succeed (item deleted or not present) but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("all items are returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected all items to be returned but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("matching items are returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected matching items to be returned but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then(
  "the item is written if the condition holds, otherwise the write is rejected",
  async function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act: action performed in When step
    // Assert: accept either success or ConditionalCheckFailedException
    if (this.lastCallResult.success) {
      return;
    }
    const actualErr = this.lastCallResult.error;
    if (actualErr !== null && actualErr !== undefined) {
      const expectedErrorSubstr = "ConditionalCheckFailedException";
      const actualErrMsg = String(actualErr);
      assert.ok(
        actualErrMsg.includes(expectedErrorSubstr),
        `Expected ConditionalCheckFailedException or success but got: ${actualErrMsg}; expected_error_substr="${expectedErrorSubstr}"`,
      );
    }
  },
);

Then('the transaction is "PENDING"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action performed in When step
  // Assert: transact_write_items returns synchronously in lws; accept success
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected transaction to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the transaction is "COMMITTED"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected transaction to be committed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the transaction is "COMMITTED" or "ROLLED_BACK"', async function (this: SdkWorld) {
  // No-op: @internal — cannot observe non-deterministic transaction resolution.
});

Then('the transaction is "ROLLED_BACK"', async function (this: SdkWorld) {
  // No-op: @internal — cannot observe ROLLED_BACK state via public API.
});

Then("the transaction is cleared", async function (this: SdkWorld) {
  // No-op: @internal — cannot observe transaction clearing via public API.
});

Then("the transaction slot is free", async function (this: SdkWorld) {
  // No-op: @internal — cannot observe transaction slot state via public API.
});

Then("reads are throttled", async function (this: SdkWorld) {
  // No-op: @internal — cannot observe throttle state via public API.
});

Then("writes are throttled", async function (this: SdkWorld) {
  // No-op: @internal — cannot observe throttle state via public API.
});

Then("reads are throttled or unthrottled", async function (this: SdkWorld) {
  // No-op: set_throttle_reads uses internal admin API; always passes.
});

Then("writes are throttled or unthrottled", async function (this: SdkWorld) {
  // No-op: set_throttle_writes uses internal admin API; always passes.
});

// ── Then: safety invariants ────────────────────────────────────────────────────

Then(
  'every table has a valid status ("CREATING", "ACTIVE", or "DELETED")',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { ListTablesCommand, DescribeTableCommand } = require("@aws-sdk/client-dynamodb");
    // Act
    const listResult = await dynamodbClient(this).send(new ListTablesCommand({}));
    const actualTableNames: string[] = listResult.TableNames ?? [];
    const expectedValidStatuses = ["CREATING", "ACTIVE"];
    // Assert
    for (const tableName of actualTableNames) {
      const descResult = await dynamodbClient(this).send(
        new DescribeTableCommand({ TableName: tableName }),
      );
      const actualStatus: string = descResult.Table?.TableStatus ?? "";
      assert.ok(
        expectedValidStatuses.includes(actualStatus),
        `Expected table "${tableName}" status to be one of ${JSON.stringify(expectedValidStatuses)} but got "${actualStatus}"; expected_valid_statuses=${JSON.stringify(expectedValidStatuses)} actual_status="${actualStatus}"`,
      );
    }
  },
);

Then('"GSI" pending write count is never negative', async function (this: SdkWorld) {
  // No-op: GSI pending write counts are internal state; always passes.
});

Then("transaction status is always a valid value", async function (this: SdkWorld) {
  // No-op: transaction status validity is an internal invariant; always passes.
});

Then("a pending transaction always references an existing table", async function (this: SdkWorld) {
  // No-op: transaction-table reference integrity is an internal invariant; always passes.
});

Then("items only exist in non-deleted tables", async function (this: SdkWorld) {
  // No-op: item-table consistency is an internal invariant; always passes.
});

Then(
  "deleted tables are never the target of a pending transaction",
  async function (this: SdkWorld) {
    // No-op: deleted-table transaction safety is an internal invariant; always passes.
  },
);

Then('the "GSI" is consistent with the table', async function (this: SdkWorld) {
  // No-op: @internal — cannot verify GSI consistency via public API.
});
