/** Step definitions: fake_responses */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { LwsSession } from "../../src/session";
import type { SdkWorld } from "../support/world";

const FAKE_EXECUTION_ARN = "arn:aws:states:us-east-1:000000000000:execution:fake:fake-exec";

// ── Compound Given ─────────────────────────────────────────────────────────────

Given(
  "a running session with a fake success response on {string} {string}",
  async function (this: SdkWorld, service: string, operation: string) {
    this.session = await LwsSession.create();
    await this.session
      .fake(service)
      .operation(operation)
      .respond({ body: { executionArn: FAKE_EXECUTION_ARN, startDate: 0 } });
  },
);

// ── Fake configuration ─────────────────────────────────────────────────────────

When(
  "I configure a fake success response for {string} {string}",
  async function (this: SdkWorld, service: string, operation: string) {
    assert.ok(this.session, "No session");
    await this.session!.fake(service)
      .operation(operation)
      .respond({ body: { executionArn: FAKE_EXECUTION_ARN, startDate: 0 } });
  },
);

When(
  "I configure a fake error {string} for {string} {string}",
  async function (this: SdkWorld, errorCode: string, service: string, operation: string) {
    assert.ok(this.session, "No session");
    await this.session!.fake(service).operation(operation).error(errorCode);
  },
);

When(
  "I configure a fake success response for {string} {string} with a 50ms delay",
  async function (this: SdkWorld, service: string, operation: string) {
    assert.ok(this.session, "No session");
    await this.session!.fake(service)
      .operation(operation)
      .respond({
        body: { executionArn: FAKE_EXECUTION_ARN, startDate: 0 },
        delayMs: 50,
      });
  },
);

When("I clear fakes for {string}", async function (this: SdkWorld, service: string) {
  assert.ok(this.session, "No session");
  await this.session!.fake(service).clear();
});

// ── Calls that use fake or real responses ──────────────────────────────────────

When(
  "I call {string} {string} against a real state machine",
  async function (this: SdkWorld, service: string, operation: string) {
    assert.ok(this.session, "No session");
    try {
      let output: unknown;
      if (service === "stepfunctions" && operation === "StartExecution") {
        // Need a real state machine — create one on the fly
        const port = this.session!.portFor("stepfunctions");
        await fetch(`http://127.0.0.1:${port}`, {
          method: "POST",
          headers: {
            "Content-Type": "application/x-amz-json-1.0",
            "X-Amz-Target": "AWSStepFunctions.CreateStateMachine",
          },
          body: JSON.stringify({
            name: "RealOrderProcessor",
            definition: JSON.stringify({
              Comment: "test",
              StartAt: "Pass",
              States: { Pass: { Type: "Pass", End: true } },
            }),
            roleArn: "arn:aws:iam::000000000000:role/StepFunctionsRole",
            type: "STANDARD",
          }),
        });
        const {
          SFNClient,
          ListStateMachinesCommand,
          StartExecutionCommand,
        } = require("@aws-sdk/client-sfn");
        const client = this.session!.client<typeof SFNClient>("stepfunctions");
        const listResult = await client.send(new ListStateMachinesCommand({}));
        const machines: Array<{ name: string; stateMachineArn: string }> =
          listResult.stateMachines ?? [];
        const sm =
          machines.find((m) => m.name === "RealOrderProcessor") ||
          machines.find((m) => m.name === "OrderProcessor");
        if (!sm) throw new Error("No state machine available for real call");
        output = await client.send(
          new StartExecutionCommand({
            stateMachineArn: sm.stateMachineArn,
            input: JSON.stringify({ test: true }),
          }),
        );
      } else if (service === "stepfunctions" && operation === "ListStateMachines") {
        const { SFNClient, ListStateMachinesCommand } = require("@aws-sdk/client-sfn");
        const client = this.session!.client<typeof SFNClient>("stepfunctions");
        output = await client.send(new ListStateMachinesCommand({}));
      } else {
        throw new Error(`No real call implementation for "${service}" "${operation}"`);
      }
      this.lastCallResult = { success: true, output };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
  },
);

// ── Assertions ─────────────────────────────────────────────────────────────────

Then("the faked response body is returned", function (this: SdkWorld) {
  assert.strictEqual(
    this.lastCallResult.success,
    true,
    `Expected faked call to succeed but got: ${JSON.stringify(this.lastCallResult.error)}`,
  );
  const output = JSON.stringify(this.lastCallResult.output);
  assert.ok(
    output.includes(FAKE_EXECUTION_ARN),
    `Expected faked executionArn "${FAKE_EXECUTION_ARN}" in output but got: ${output}`,
  );
});

Then("an AWS error {string} is returned", function (this: SdkWorld, errorCode: string) {
  assert.strictEqual(
    this.lastCallResult.success,
    false,
    `Expected error "${errorCode}" but the call succeeded`,
  );
  const errStr = JSON.stringify(this.lastCallResult.error);
  assert.ok(errStr.includes(errorCode), `Expected error code "${errorCode}" but got: ${errStr}`);
});

Then("the real response is returned", function (this: SdkWorld) {
  assert.strictEqual(
    this.lastCallResult.success,
    true,
    `Expected real response but got error: ${JSON.stringify(this.lastCallResult.error)}`,
  );
  const output = JSON.stringify(this.lastCallResult.output);
  assert.ok(
    !output.includes(FAKE_EXECUTION_ARN),
    `Expected a real (non-faked) response but got the fake ARN: ${output}`,
  );
});
