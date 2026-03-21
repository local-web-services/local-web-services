/** Step definitions: events_sqs cross-service scenarios — unique When/Then steps only */

import { When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { EB_BUS, EB_RULE, SQS_QUEUE, ACCOUNT_ID, REGION, ebCall } from "./cross_service_common";
import type { SdkWorld } from "../support/world";

// ── When steps ────────────────────────────────────────────────────────────────

When(
  "an EventBridge rule is created to route matching events to the {string} queue",
  async function (this: SdkWorld, _service: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const port = this.session!.portFor("eventbridge");
    const queueArn = `arn:aws:sqs:${REGION}:${ACCOUNT_ID}:${SQS_QUEUE}`;
    // Act: create rule then attach target
    const ruleResult = await ebCall(port, "PutRule", {
      Name: EB_RULE,
      EventBusName: EB_BUS,
      EventPattern: JSON.stringify({ source: ["test"] }),
      State: "ENABLED",
    });
    if (!ruleResult.ok) {
      this.lastCallResult = { success: false, output: null, error: ruleResult.data };
      return;
    }
    const targetResult = await ebCall(port, "PutTargets", {
      Rule: EB_RULE,
      EventBusName: EB_BUS,
      Targets: [{ Id: "target-1", Arn: queueArn }],
    });
    if (targetResult.ok) {
      this.lastCallResult = { success: true, output: targetResult.data };
    } else {
      this.lastCallResult = { success: false, output: null, error: targetResult.data };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  "an event is published to the bus and routed to the target {string} queue",
  async function (this: SdkWorld, _service: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const port = this.session!.portFor("eventbridge");
    // Act
    const result = await ebCall(port, "PutEvents", {
      Entries: [
        {
          EventBusName: EB_BUS,
          Source: "test",
          DetailType: "TestEvent",
          Detail: JSON.stringify({ key: "value" }),
        },
      ],
    });
    if (result.ok) {
      this.lastCallResult = { success: true, output: result.data };
    } else {
      this.lastCallResult = { success: false, output: null, error: result.data };
    }
    // Assert: captured in lastCallResult
  },
);

// ── Then steps ────────────────────────────────────────────────────────────────

Then(
  "the rule is {string} and will forward matching events to the queue",
  async function (this: SdkWorld, expectedState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const port = this.session!.portFor("eventbridge");
    // Act
    const result = await ebCall(port, "ListRules", { EventBusName: EB_BUS });
    const rules: Array<{ Name?: string; State?: string }> =
      (result.data as { Rules?: Array<{ Name?: string; State?: string }> }).Rules ?? [];
    const actualRule = rules.find((r) => r.Name === EB_RULE);
    // Assert
    assert.ok(actualRule, `Expected rule "${EB_RULE}" to exist`);
    const actualState = actualRule?.State ?? "";
    assert.strictEqual(
      actualState,
      expectedState,
      `Expected rule state "${expectedState}" but got "${actualState}"`,
    );
  },
);

Then(
  "the message is {string} in the target queue",
  async function (this: SdkWorld, expectedState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const { SQSClient, GetQueueUrlCommand, ReceiveMessageCommand } = require("@aws-sdk/client-sqs");
    const client = this.session!.client<typeof SQSClient>("sqs");
    // Act
    const urlResult = await client.send(new GetQueueUrlCommand({ QueueName: SQS_QUEUE }));
    const queueUrl = urlResult.QueueUrl as string;
    const receiveResult = await client.send(
      new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 1 }),
    );
    const actualMessages: unknown[] = receiveResult.Messages ?? [];
    // Assert
    if (expectedState === "AVAILABLE") {
      assert.ok(
        actualMessages.length > 0,
        `Expected at least one AVAILABLE message in target queue but found none`,
      );
    }
  },
);
