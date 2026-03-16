/**
 * Shared step definitions for adding an OrderProcessor state machine or
 * a DynamoDB table to an already-running session.
 *
 * These steps are used by chaos, fake, iam, and log_capture features.
 */

import { Given } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const ORDER_PROCESSOR_DEFINITION = {
  Comment: "test",
  StartAt: "Pass",
  States: { Pass: { Type: "Pass", End: true } },
};

Given(
  "an OrderProcessor state machine is running",
  async function (this: SdkWorld) {
    assert.ok(this.session, "No session running — create a session first");

    const sfnPort = this.session!.portFor("stepfunctions");
    const mgmtPort = (this.session as any)._basePort as number;

    // Temporarily clear chaos on stepfunctions to ensure the create call goes through,
    // then restore the previous chaos config.
    const chaosResp = await fetch(`http://127.0.0.1:${mgmtPort}/_ldk/chaos`);
    const chaosConfig = (await chaosResp.json()) as Record<string, unknown>;
    const sfnChaos = (chaosConfig as any)?.stepfunctions ?? {};
    const chaosWasEnabled = !!(sfnChaos as any)?.enabled;

    if (chaosWasEnabled) {
      // Temporarily disable chaos so the CreateStateMachine call goes through
      await fetch(`http://127.0.0.1:${mgmtPort}/_ldk/chaos`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ stepfunctions: { enabled: false, error_rate: 0 } }),
      });
    }

    try {
      await fetch(`http://127.0.0.1:${sfnPort}`, {
        method: "POST",
        headers: {
          "Content-Type": "application/x-amz-json-1.0",
          "X-Amz-Target": "AWSStepFunctions.CreateStateMachine",
        },
        body: JSON.stringify({
          name: "OrderProcessor",
          definition: JSON.stringify(ORDER_PROCESSOR_DEFINITION),
          roleArn: "arn:aws:iam::000000000000:role/StepFunctionsRole",
          type: "STANDARD",
        }),
      });
    } finally {
      if (chaosWasEnabled) {
        // Re-enable chaos with the original config
        await fetch(`http://127.0.0.1:${mgmtPort}/_ldk/chaos`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ stepfunctions: sfnChaos }),
        });
      }
    }
  }
);

Given(
  "a DynamoDB table {string} with partition key {string}",
  async function (this: SdkWorld, tableName: string, partitionKey: string) {
    assert.ok(this.session, "No session running — create a session first");
    const { DynamoDBClient, CreateTableCommand } = require("@aws-sdk/client-dynamodb");
    const client = this.session!.client<typeof DynamoDBClient>("dynamodb");
    try {
      await client.send(
        new CreateTableCommand({
          TableName: tableName,
          KeySchema: [{ AttributeName: partitionKey, KeyType: "HASH" }],
          AttributeDefinitions: [
            { AttributeName: partitionKey, AttributeType: "S" },
          ],
          BillingMode: "PAY_PER_REQUEST",
        })
      );
    } catch (err: any) {
      // Ignore ResourceInUseException — table already exists
      if (!err.name?.includes("ResourceInUse")) throw err;
    }
  }
);
