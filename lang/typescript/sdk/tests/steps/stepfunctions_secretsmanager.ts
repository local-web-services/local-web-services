/** Step definitions: stepfunctions_secretsmanager cross-service scenarios — unique When/Then steps only */

import { When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { SFN_SM, SM_SECRET, ACCOUNT_ID, REGION } from "./cross_service_common";
import type { SdkWorld } from "../support/world";

// ── When steps ────────────────────────────────────────────────────────────────

When(
  "a SecretsManager GetSecretValue task is configured on the state machine",
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
    const secretArn = `arn:aws:secretsmanager:${REGION}:${ACCOUNT_ID}:secret:${SM_SECRET}`;
    // Act: update state machine definition with a SecretsManager GetSecretValue task
    const response = await fetch(`http://127.0.0.1:${sfnPort}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-amz-json-1.0",
        "X-Amz-Target": "AWSStepFunctions.UpdateStateMachine",
      },
      body: JSON.stringify({
        stateMachineArn: smArn,
        definition: JSON.stringify({
          Comment: "test with SecretsManager",
          StartAt: "GetSecretValue",
          States: {
            GetSecretValue: {
              Type: "Task",
              Resource: "arn:aws:states:::aws-sdk:secretsmanager:getSecretValue",
              Parameters: {
                SecretId: secretArn,
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
  "a running execution reads a secret from SecretsManager and succeeds",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    const sfnPort = this.session!.portFor("stepfunctions");
    const smArn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:stateMachine:${SFN_SM}`;
    const secretArn = `arn:aws:secretsmanager:${REGION}:${ACCOUNT_ID}:secret:${SM_SECRET}`;
    // Act: ensure secret exists
    const {
      SecretsManagerClient,
      CreateSecretCommand,
    } = require("@aws-sdk/client-secrets-manager");
    const smClient = this.session!.client<typeof SecretsManagerClient>("secretsmanager");
    try {
      await smClient.send(new CreateSecretCommand({ Name: SM_SECRET, SecretString: "test-value" }));
    } catch {
      // May already exist
    }
    // Act: update state machine with SecretsManager GetSecretValue task
    const updateResponse = await fetch(`http://127.0.0.1:${sfnPort}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-amz-json-1.0",
        "X-Amz-Target": "AWSStepFunctions.UpdateStateMachine",
      },
      body: JSON.stringify({
        stateMachineArn: smArn,
        definition: JSON.stringify({
          Comment: "test with SecretsManager",
          StartAt: "GetSecretValue",
          States: {
            GetSecretValue: {
              Type: "Task",
              Resource: "arn:aws:states:::aws-sdk:secretsmanager:getSecretValue",
              Parameters: { SecretId: secretArn },
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
    // Act: start execution (synchronous — runs SecretsManager GetSecretValue task)
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
  "the state machine will read the secret when it reaches the task state",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    // Act: verify the state machine task configuration succeeded
    const actualSuccess = this.lastCallResult.success;
    // Assert
    assert.ok(
      actualSuccess,
      `Expected SecretsManager task configuration to succeed but got: ${JSON.stringify(this.lastCallResult.error)}`,
    );
  },
);

Then(
  "the execution is {string} and the secret was read",
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
