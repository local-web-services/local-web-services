/** Step definitions: chaos_injection */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { LwsSession } from "../../src/session";
import type { SdkWorld } from "../support/world";

// ── Compound Given — session with 100% chaos already applied ───────────────────

Given(
  "a running session with 100% error rate on {string}",
  async function (this: SdkWorld, service: string) {
    this.session = await LwsSession.create();
    await this.session.chaos(service).errorRate(1.0).apply();
  },
);

// ── Chaos control ──────────────────────────────────────────────────────────────

When("I set a 100% error rate on {string}", async function (this: SdkWorld, service: string) {
  assert.ok(this.session, "No session");
  await this.session!.chaos(service).errorRate(1.0).apply();
});

When("I clear chaos for {string}", async function (this: SdkWorld, service: string) {
  assert.ok(this.session, "No session");
  await this.session!.chaos(service).clear();
});

// ── Make a service call and store the result ───────────────────────────────────

When(
  "I call {string} {string}",
  async function (this: SdkWorld, service: string, operation: string) {
    assert.ok(this.session, "No session");

    try {
      let output: unknown;

      if (service === "stepfunctions" && operation === "StartExecution") {
        const {
          SFNClient,
          StartExecutionCommand,
          ListStateMachinesCommand,
        } = require("@aws-sdk/client-sfn");
        const client = this.session!.client<typeof SFNClient>("stepfunctions");
        // Try to get a real state machine ARN; if none exists use a placeholder
        // (fakes will intercept before validation).
        let arn: string;
        try {
          const listResult = await client.send(new ListStateMachinesCommand({}));
          const machines: Array<{ name: string; stateMachineArn: string }> =
            listResult.stateMachines ?? [];
          const match = machines.find((m) => m.name === "OrderProcessor");
          arn =
            match?.stateMachineArn ??
            "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor";
        } catch {
          arn = "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor";
        }
        output = await client.send(
          new StartExecutionCommand({
            stateMachineArn: arn,
            input: JSON.stringify({ test: true }),
          }),
        );
      } else if (service === "stepfunctions" && operation === "ListStateMachines") {
        const { SFNClient, ListStateMachinesCommand } = require("@aws-sdk/client-sfn");
        const client = this.session!.client<typeof SFNClient>("stepfunctions");
        output = await client.send(new ListStateMachinesCommand({}));
      } else if (service === "dynamodb" && operation === "ListTables") {
        const { DynamoDBClient, ListTablesCommand } = require("@aws-sdk/client-dynamodb");
        const client = this.session!.client<typeof DynamoDBClient>("dynamodb");
        output = await client.send(new ListTablesCommand({}));
      } else {
        throw new Error(`No implementation for call "${service}" "${operation}"`);
      }

      this.lastCallResult = { success: true, output };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
  },
);

// ── Assertions ─────────────────────────────────────────────────────────────────

Then("an AWS error is returned", function (this: SdkWorld) {
  assert.strictEqual(
    this.lastCallResult.success,
    false,
    `Expected an AWS error but the call succeeded with output: ${JSON.stringify(
      this.lastCallResult.output,
    )}`,
  );
});

Then("the call succeeds", function (this: SdkWorld) {
  assert.strictEqual(
    this.lastCallResult.success,
    true,
    `Expected the call to succeed but got error: ${JSON.stringify(this.lastCallResult.error)}`,
  );
});
