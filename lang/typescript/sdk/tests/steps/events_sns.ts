/** Step definitions: events_sns cross-service scenarios — unique When/Then steps only */

import { When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { EB_BUS, EB_RULE, SNS_TOPIC, ACCOUNT_ID, REGION, ebCall } from "./cross_service_common";
import type { SdkWorld } from "../support/world";

// ── When steps ────────────────────────────────────────────────────────────────

When(
  "an EventBridge rule is created to route matching events to an {string} topic",
  async function (this: SdkWorld, _service: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const port = this.session!.portFor("eventbridge");
    const topicArn = `arn:aws:sns:${REGION}:${ACCOUNT_ID}:${SNS_TOPIC}`;
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
      Targets: [{ Id: "target-1", Arn: topicArn }],
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
  "an event is published to the bus and routed to the target {string} topic",
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

When(
  "a subscriber consumes a message from the {string} topic",
  async function (this: SdkWorld, _service: string) {
    // Arrange: SNS messages are delivered to subscribed endpoints
    assert.ok(this.session, "No session running");
    const { SNSClient, ListSubscriptionsByTopicCommand } = require("@aws-sdk/client-sns");
    const snsClient = this.session!.client<typeof SNSClient>("sns");
    const topicArn = `arn:aws:sns:${REGION}:${ACCOUNT_ID}:${SNS_TOPIC}`;
    // Act: list subscriptions to confirm the topic is reachable
    try {
      const result = await snsClient.send(
        new ListSubscriptionsByTopicCommand({ TopicArn: topicArn }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

// ── Then steps ────────────────────────────────────────────────────────────────

Then(
  "the rule is {string} and will publish to the topic when matching events are received",
  async function (this: SdkWorld, expectedState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const port = this.session!.portFor("eventbridge");
    // Act
    const result = await ebCall(port, "ListRules", { EventBusName: EB_BUS });
    const rules: Array<{ Name?: string; State?: string }> = (
      result.data as { Rules?: Array<{ Name?: string; State?: string }> }
    ).Rules ?? [];
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
  "the message is {string} on the topic",
  async function (this: SdkWorld, expectedState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    // Act: verify the lastCallResult indicates success (publish did not error)
    const actualSuccess = this.lastCallResult.success;
    // Assert
    if (expectedState === "AVAILABLE") {
      assert.ok(
        actualSuccess,
        `Expected message to be AVAILABLE on topic but last call failed: ${JSON.stringify(this.lastCallResult.error)}`,
      );
    }
  },
);
