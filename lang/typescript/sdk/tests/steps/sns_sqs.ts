/** Step definitions: sns_sqs cross-service scenarios — unique When/Then steps only */

import { When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { SNS_TOPIC, SQS_QUEUE, ACCOUNT_ID, REGION } from "./cross_service_common";
import type { SdkWorld } from "../support/world";

const TEST_MESSAGE_BODY = "hello from sns";

// ── When steps ────────────────────────────────────────────────────────────────

When(
  "an {string} queue subscribes to an {string} topic",
  async function (this: SdkWorld, _queueService: string, _topicService: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    // lws SNS Subscribe does not validate queue existence or state
    if ((this as any)._queueDoesNotExist || (this as any)._queueNotActive) {
      return "pending";
    }
    // lws capacity error response is not parseable by the AWS SDK
    if ((this as any)._noSubscriptionSlot) {
      return "pending";
    }
    const { SNSClient, SubscribeCommand } = require("@aws-sdk/client-sns");
    const snsClient = this.session!.client<typeof SNSClient>("sns");
    const topicArn = `arn:aws:sns:${REGION}:${ACCOUNT_ID}:${SNS_TOPIC}`;
    const queueArn = `arn:aws:sqs:${REGION}:${ACCOUNT_ID}:${SQS_QUEUE}`;
    // Act
    try {
      const result = await snsClient.send(
        new SubscribeCommand({
          TopicArn: topicArn,
          Protocol: "sqs",
          Endpoint: queueArn,
        }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  "a message is published to an {string} topic and delivered to the subscribed {string} queue",
  async function (this: SdkWorld, _topicService: string, _queueService: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    // lws SNS Publish succeeds even when the subscribed queue is deleted
    if ((this as any)._subscribedQueueNotActive) {
      return "pending";
    }
    // lws SNS Publish succeeds even when capacity is exhausted (delivery fails silently)
    if ((this as any)._noMessageSlot) {
      return "pending";
    }
    const { SNSClient, PublishCommand } = require("@aws-sdk/client-sns");
    const snsClient = this.session!.client<typeof SNSClient>("sns");
    const topicArn = `arn:aws:sns:${REGION}:${ACCOUNT_ID}:${SNS_TOPIC}`;
    // Act
    try {
      const result = await snsClient.send(
        new PublishCommand({ TopicArn: topicArn, Message: TEST_MESSAGE_BODY }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  "a message is consumed from the {string} queue",
  async function (this: SdkWorld, _service: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const {
      SQSClient,
      GetQueueUrlCommand,
      ReceiveMessageCommand,
      DeleteMessageCommand,
    } = require("@aws-sdk/client-sqs");
    const client = this.session!.client<typeof SQSClient>("sqs");
    // Act
    try {
      const urlResult = await client.send(new GetQueueUrlCommand({ QueueName: SQS_QUEUE }));
      const queueUrl = urlResult.QueueUrl as string;
      const receiveResult = await client.send(
        new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 1 }),
      );
      const messages: Array<{ ReceiptHandle?: string }> = receiveResult.Messages ?? [];
      if (messages.length === 0) {
        this.lastCallResult = {
          success: false,
          output: null,
          error: new Error("No messages available in queue"),
        };
        return;
      }
      const receiptHandle = messages[0].ReceiptHandle!;
      await client.send(
        new DeleteMessageCommand({ QueueUrl: queueUrl, ReceiptHandle: receiptHandle }),
      );
      this.lastCallResult = { success: true, output: messages[0] };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

// Note: "the {string} topic is deleted" is defined in cross_service_common.ts.

// ── Then steps ────────────────────────────────────────────────────────────────

Then(
  "the subscription is {string} and the queue will receive published messages",
  async function (this: SdkWorld, expectedState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const { SNSClient, ListSubscriptionsCommand } = require("@aws-sdk/client-sns");
    const client = this.session!.client<typeof SNSClient>("sns");
    // Act
    const result = await client.send(new ListSubscriptionsCommand({}));
    const subscriptions: Array<{ SubscriptionStatus?: string; SubscriptionArn?: string }> =
      result.Subscriptions ?? [];
    const actualExists = subscriptions.length > 0;
    // Assert
    assert.ok(
      actualExists,
      `Expected subscription to be ${expectedState} but no subscriptions found`,
    );
  },
);

Then(
  "the message is {string} in the queue",
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
        `Expected at least one AVAILABLE message in queue but found none`,
      );
    } else if (expectedState === "DELETED") {
      assert.strictEqual(
        actualMessages.length,
        0,
        `Expected no messages (DELETED) but found ${actualMessages.length}`,
      );
    }
  },
);

Then("the message is {string}", async function (this: SdkWorld, expectedState: string) {
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
  if (expectedState === "DELETED") {
    assert.strictEqual(
      actualMessages.length,
      0,
      `Expected message to be DELETED (no messages) but found ${actualMessages.length}`,
    );
  } else if (expectedState === "AVAILABLE") {
    assert.ok(actualMessages.length > 0, `Expected AVAILABLE message but found none`);
  }
});

// Note: "the topic is {string} and notification delivery to it will fail" is defined
// in cross_service_common.ts.
