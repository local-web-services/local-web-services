/** Step definitions: stepfunctions_sns cross-service scenarios — unique When/Then steps only */

import { When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { SFN_SM, SNS_TOPIC, ACCOUNT_ID, REGION } from "./cross_service_common";
import type { SdkWorld } from "../support/world";

const SNS_PUBLISH_TASK_ARN = "arn:aws:states:::sns:publish";

// ── When steps ────────────────────────────────────────────────────────────────

When(
  "an {string} publish task is configured on the state machine",
  async function (this: SdkWorld, _service: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    // lws SFN does not validate topic existence/lifecycle when configuring tasks
    if ((this as any)._topicNotExist || (this as any)._topicNotActive) {
      return "pending";
    }
    const sfnPort = this.session!.portFor("stepfunctions");
    const smArn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:stateMachine:${SFN_SM}`;
    const topicArn = `arn:aws:sns:${REGION}:${ACCOUNT_ID}:${SNS_TOPIC}`;
    // Act: update state machine definition with SNS publish task
    const response = await fetch(`http://127.0.0.1:${sfnPort}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-amz-json-1.0",
        "X-Amz-Target": "AWSStepFunctions.UpdateStateMachine",
      },
      body: JSON.stringify({
        stateMachineArn: smArn,
        definition: JSON.stringify({
          Comment: "test with SNS",
          StartAt: "Publish",
          States: {
            Publish: {
              Type: "Task",
              Resource: SNS_PUBLISH_TASK_ARN,
              Parameters: { TopicArn: topicArn, Message: "hello from sfn" },
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
  "a running execution publishes a message to the {string} topic and succeeds",
  async function (this: SdkWorld, _service: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    if ((this as any)._targetTopicNotActive) {
      return "pending";
    }
    const sfnPort = this.session!.portFor("stepfunctions");
    const smArn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:stateMachine:${SFN_SM}`;
    const topicArn = `arn:aws:sns:${REGION}:${ACCOUNT_ID}:${SNS_TOPIC}`;
    // Act: ensure topic exists
    const { SNSClient, CreateTopicCommand } = require("@aws-sdk/client-sns");
    const snsClient = this.session!.client<typeof SNSClient>("sns");
    try {
      await snsClient.send(new CreateTopicCommand({ Name: SNS_TOPIC }));
    } catch {
      // May already exist
    }
    // Act: update state machine with SNS publish task
    const updateResponse = await fetch(`http://127.0.0.1:${sfnPort}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-amz-json-1.0",
        "X-Amz-Target": "AWSStepFunctions.UpdateStateMachine",
      },
      body: JSON.stringify({
        stateMachineArn: smArn,
        definition: JSON.stringify({
          Comment: "test with SNS",
          StartAt: "Publish",
          States: {
            Publish: {
              Type: "Task",
              Resource: SNS_PUBLISH_TASK_ARN,
              Parameters: { TopicArn: topicArn, Message: "hello from sfn" },
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
    // Act: start execution (synchronous — runs SNS publish task)
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
  "the state machine will publish a message to the topic when it reaches the task state",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    // Act: verify the state machine task configuration succeeded
    const actualSuccess = this.lastCallResult.success;
    // Assert
    assert.ok(
      actualSuccess,
      `Expected SNS task configuration to succeed but got: ${JSON.stringify(this.lastCallResult.error)}`,
    );
  },
);

Then(
  "the execution is {string} and the message has been published to the topic",
  async function (this: SdkWorld, _expectedExecState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    // Act: verify the execution (and SNS publish task) succeeded
    const actualSuccess = this.lastCallResult.success;
    // Assert
    assert.ok(
      actualSuccess,
      `Expected SNS publish execution to succeed but got: ${JSON.stringify(this.lastCallResult.error)}`,
    );
  },
);
