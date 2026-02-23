"use strict";

const {
  SQSClient,
  SendMessageCommand,
  ReceiveMessageCommand,
  PurgeQueueCommand,
  GetQueueAttributesCommand,
} = require("@aws-sdk/client-sqs");

class SQSHelper {
  constructor(queueName, client, port) {
    this.queueName = queueName;
    this.client = client;
    this.queueUrl = `http://127.0.0.1:${port}/000000000000/${queueName}`;
  }

  get url() {
    return this.queueUrl;
  }

  async send(body, opts = {}) {
    const messageBody = typeof body === "string" ? body : JSON.stringify(body);
    const result = await this.client.send(
      new SendMessageCommand({
        QueueUrl: this.queueUrl,
        MessageBody: messageBody,
        ...(opts.messageGroupId ? { MessageGroupId: opts.messageGroupId } : {}),
      })
    );
    return result.MessageId ?? "";
  }

  async receive(maxMessages = 10, waitSeconds = 0) {
    const result = await this.client.send(
      new ReceiveMessageCommand({
        QueueUrl: this.queueUrl,
        MaxNumberOfMessages: Math.min(maxMessages, 10),
        WaitTimeSeconds: waitSeconds,
      })
    );
    return result.Messages ?? [];
  }

  async purge() {
    await this.client.send(new PurgeQueueCommand({ QueueUrl: this.queueUrl }));
  }

  async assertMessageCount(expectedCount) {
    const result = await this.client.send(
      new GetQueueAttributesCommand({
        QueueUrl: this.queueUrl,
        AttributeNames: ["ApproximateNumberOfMessages"],
      })
    );
    const actualCount = parseInt(
      result.Attributes?.ApproximateNumberOfMessages ?? "0",
      10
    );
    if (actualCount !== expectedCount) {
      throw new Error(
        `Expected ${expectedCount} message(s) in queue "${this.queueName}", but found approximately ${actualCount}.`
      );
    }
  }
}

void SQSClient;

module.exports = { SQSHelper };
