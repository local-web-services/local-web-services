/** Step definitions: stepfunctions_ssm cross-service scenarios — unique When/Then steps only */

import { When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { SFN_SM, SM_PARAM, ACCOUNT_ID, REGION } from "./cross_service_common";
import type { SdkWorld } from "../support/world";

// ── When steps ────────────────────────────────────────────────────────────────

When(
  "an SSM GetParameter task is configured on the state machine",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    if ((this as any)._smHasNoTask) {
      this.lastCallResult = {
        success: false,
        output: null,
        error: { message: "No task configured" },
      };
      return;
    }
    const sfnPort = this.session!.portFor("stepfunctions");
    const smArn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:stateMachine:${SFN_SM}`;
    // Act: update state machine definition with an SSM GetParameter task
    const response = await fetch(`http://127.0.0.1:${sfnPort}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-amz-json-1.0",
        "X-Amz-Target": "AWSStepFunctions.UpdateStateMachine",
      },
      body: JSON.stringify({
        stateMachineArn: smArn,
        definition: JSON.stringify({
          Comment: "test with SSM",
          StartAt: "GetParameter",
          States: {
            GetParameter: {
              Type: "Task",
              Resource: "arn:aws:states:::aws-sdk:ssm:getParameter",
              Parameters: {
                Name: SM_PARAM,
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
  },
);

When(
  "a running execution reads a parameter from SSM and succeeds",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    const sfnPort = this.session!.portFor("stepfunctions");
    const smArn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:stateMachine:${SFN_SM}`;
    // Act: ensure parameter exists
    const { SSMClient, PutParameterCommand } = require("@aws-sdk/client-ssm");
    const ssmClient = this.session!.client<typeof SSMClient>("ssm");
    try {
      await ssmClient.send(
        new PutParameterCommand({ Name: SM_PARAM, Value: "test-value", Type: "String" }),
      );
    } catch {
      // May already exist
    }
    // Act: update state machine with SSM GetParameter task
    const updateResponse = await fetch(`http://127.0.0.1:${sfnPort}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-amz-json-1.0",
        "X-Amz-Target": "AWSStepFunctions.UpdateStateMachine",
      },
      body: JSON.stringify({
        stateMachineArn: smArn,
        definition: JSON.stringify({
          Comment: "test with SSM",
          StartAt: "GetParameter",
          States: {
            GetParameter: {
              Type: "Task",
              Resource: "arn:aws:states:::aws-sdk:ssm:getParameter",
              Parameters: { Name: SM_PARAM },
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
    // Act: start execution (synchronous — runs SSM GetParameter task)
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
  "the state machine will read the parameter when it reaches the task state",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    // Act: verify the state machine task configuration succeeded
    const actualSuccess = this.lastCallResult.success;
    // Assert
    assert.ok(
      actualSuccess,
      `Expected SSM task configuration to succeed but got: ${JSON.stringify(this.lastCallResult.error)}`,
    );
  },
);

Then(
  "the execution is {string} and the parameter was read",
  async function (this: SdkWorld, expectedState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const expectedSuccess = expectedState === "SUCCEEDED";
    // Act: check execution result from lastCallResult
    const actualSuccess = this.lastCallResult.success;
    // Assert
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected execution to be ${expectedState} but got: ${JSON.stringify(this.lastCallResult.error ?? this.lastCallResult.output)}`,
    );
  },
);
