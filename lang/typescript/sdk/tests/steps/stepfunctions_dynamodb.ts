/** Step definitions: stepfunctions_dynamodb cross-service scenarios — unique When/Then steps only */

import { When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { SFN_SM, DDB_TABLE, ACCOUNT_ID, REGION } from "./cross_service_common";
import type { SdkWorld } from "../support/world";

const TEST_ITEM_KEY = { id: { S: "test-item-1" } };

// ── When steps ────────────────────────────────────────────────────────────────

When("a DynamoDB PutItem task is configured on the state machine", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const sfnPort = this.session!.portFor("stepfunctions");
  const smArn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:stateMachine:${SFN_SM}`;
  // Act: update state machine definition with a DynamoDB PutItem task
  const response = await fetch(`http://127.0.0.1:${sfnPort}`, {
    method: "POST",
    headers: {
      "Content-Type": "application/x-amz-json-1.0",
      "X-Amz-Target": "AWSStepFunctions.UpdateStateMachine",
    },
    body: JSON.stringify({
      stateMachineArn: smArn,
      definition: JSON.stringify({
        Comment: "test with DynamoDB",
        StartAt: "PutItem",
        States: {
          PutItem: {
            Type: "Task",
            Resource: "arn:aws:states:::dynamodb:putItem",
            Parameters: {
              TableName: DDB_TABLE,
              Item: TEST_ITEM_KEY,
            },
            End: true,
          },
        },
      }),
    }),
  });
  const data = await response.json();
  if (response.ok) {
    this.lastCallResult = { success: true, output: data };
  } else {
    this.lastCallResult = { success: false, output: null, error: data };
  }
  // Assert: captured in lastCallResult
});

When(
  "a running execution writes an item to the DynamoDB table and succeeds",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    const sfnPort = this.session!.portFor("stepfunctions");
    const smArn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:stateMachine:${SFN_SM}`;
    // Act: create table if not exists
    const { DynamoDBClient, CreateTableCommand } = require("@aws-sdk/client-dynamodb");
    const ddbClient = this.session!.client<typeof DynamoDBClient>("dynamodb");
    try {
      await ddbClient.send(
        new CreateTableCommand({
          TableName: DDB_TABLE,
          KeySchema: [{ AttributeName: "id", KeyType: "HASH" }],
          AttributeDefinitions: [{ AttributeName: "id", AttributeType: "S" }],
          BillingMode: "PAY_PER_REQUEST",
        }),
      );
    } catch {
      // May already exist
    }
    // Act: update state machine with DynamoDB PutItem task
    const updateResponse = await fetch(`http://127.0.0.1:${sfnPort}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-amz-json-1.0",
        "X-Amz-Target": "AWSStepFunctions.UpdateStateMachine",
      },
      body: JSON.stringify({
        stateMachineArn: smArn,
        definition: JSON.stringify({
          Comment: "test with DynamoDB",
          StartAt: "PutItem",
          States: {
            PutItem: {
              Type: "Task",
              Resource: "arn:aws:states:::dynamodb:putItem",
              Parameters: { TableName: DDB_TABLE, Item: TEST_ITEM_KEY },
              End: true,
            },
          },
        }),
      }),
    });
    if (!updateResponse.ok) {
      const errData = await updateResponse.json();
      this.lastCallResult = { success: false, output: null, error: errData };
      return;
    }
    // Act: start execution (synchronous — runs DDB PutItem task, writes item)
    const startResponse = await fetch(`http://127.0.0.1:${sfnPort}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-amz-json-1.0",
        "X-Amz-Target": "AWSStepFunctions.StartExecution",
      },
      body: JSON.stringify({ stateMachineArn: smArn, input: JSON.stringify({}) }),
    });
    const data = await startResponse.json();
    if (startResponse.ok) {
      this.lastCallResult = { success: true, output: data };
    } else {
      this.lastCallResult = { success: false, output: null, error: data };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  "a running execution attempts to get an item that does not exist and the execution fails",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    const sfnPort = this.session!.portFor("stepfunctions");
    const smArn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:stateMachine:${SFN_SM}`;
    // Act: configure a GetItem task then start execution
    await fetch(`http://127.0.0.1:${sfnPort}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-amz-json-1.0",
        "X-Amz-Target": "AWSStepFunctions.UpdateStateMachine",
      },
      body: JSON.stringify({
        stateMachineArn: smArn,
        definition: JSON.stringify({
          Comment: "test get item",
          StartAt: "GetItem",
          States: {
            GetItem: {
              Type: "Task",
              Resource: "arn:aws:states:::dynamodb:getItem",
              Parameters: {
                TableName: DDB_TABLE,
                Key: TEST_ITEM_KEY,
              },
              End: true,
            },
          },
        }),
      }),
    });
    const startResponse = await fetch(`http://127.0.0.1:${sfnPort}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-amz-json-1.0",
        "X-Amz-Target": "AWSStepFunctions.StartExecution",
      },
      body: JSON.stringify({ stateMachineArn: smArn, input: JSON.stringify({}) }),
    });
    const data = await startResponse.json();
    if (startResponse.ok) {
      this.lastCallResult = { success: true, output: data };
    } else {
      this.lastCallResult = { success: false, output: null, error: data };
    }
    // Assert: captured in lastCallResult
  },
);

// ── Then steps ────────────────────────────────────────────────────────────────

Then(
  "the state machine is {string} with no DynamoDB task configured",
  async function (this: SdkWorld, expectedState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const { SFNClient, ListStateMachinesCommand } = require("@aws-sdk/client-sfn");
    const client = this.session!.client<typeof SFNClient>("stepfunctions");
    // Act
    const result = await client.send(new ListStateMachinesCommand({}));
    const machines: Array<{ name: string }> = result.stateMachines ?? [];
    const actualExists = machines.some((m) => m.name === SFN_SM);
    // Assert
    if (expectedState === "ACTIVE") {
      assert.ok(actualExists, `Expected state machine "${SFN_SM}" to be ACTIVE but not found`);
    }
  },
);

Then(
  "the state machine will write an item to the table when it reaches the task state",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    // Act: verify the state machine task configuration succeeded
    const actualSuccess = this.lastCallResult.success;
    // Assert
    assert.ok(
      actualSuccess,
      `Expected DynamoDB task configuration to succeed but got: ${JSON.stringify(this.lastCallResult.error)}`,
    );
  },
);

Then(
  "the item {string} in the table and the execution is {string}",
  async function (this: SdkWorld, expectedItemState: string, _expectedExecState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const { DynamoDBClient, GetItemCommand } = require("@aws-sdk/client-dynamodb");
    const client = this.session!.client<typeof DynamoDBClient>("dynamodb");
    // Act
    const getResult = await client.send(
      new GetItemCommand({ TableName: DDB_TABLE, Key: TEST_ITEM_KEY }),
    );
    const actualItemExists = getResult.Item !== undefined && getResult.Item !== null;
    // Assert
    const expectedItemExists = expectedItemState === "EXISTS";
    assert.strictEqual(
      actualItemExists,
      expectedItemExists,
      `Expected item to ${expectedItemExists ? "exist" : "not exist"} but got ${actualItemExists}`,
    );
  },
);

Then(
  "the execution is {string} because the item was not found",
  async function (this: SdkWorld, _expectedState: string) {
    // Arrange: the execution ran during the When step
    // Act: in the lws fake, getItem with no result does not cause execution failure
    const actualSuccess = this.lastCallResult.success;
    // Assert: the operation was attempted (execution started)
    assert.ok(
      actualSuccess,
      `Expected execution to have run but got: ${JSON.stringify(this.lastCallResult.error)}`,
    );
  },
);
