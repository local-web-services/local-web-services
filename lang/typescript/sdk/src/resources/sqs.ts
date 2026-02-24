/**
 * SQS helper for seeding and asserting queue state.
 */

import {
  SQSClient,
  SendMessageCommand,
  ReceiveMessageCommand,
  PurgeQueueCommand,
  GetQueueAttributesCommand,
  Message,
} from "@aws-sdk/client-sqs";

export class SQSHelper {
  private readonly queueUrl: string;

  constructor(
    private readonly queueName: string,
    private readonly client: SQSClient,
    port: number
  ) {
    this.queueUrl = `http://127.0.0.1:${port}/000000000000/${queueName}`;
  }

  get url(): string {
    return this.queueUrl;
  }

  async send(body: string | object, opts?: { messageGroupId?: string }): Promise<string> {
    const messageBody = typeof body === "string" ? body : JSON.stringify(body);
    const result = await this.client.send(
      new SendMessageCommand({
        QueueUrl: this.queueUrl,
        MessageBody: messageBody,
        ...(opts?.messageGroupId ? { MessageGroupId: opts.messageGroupId } : {}),
      })
    );
    return result.MessageId ?? "";
  }

  async receive(maxMessages = 10, waitSeconds = 0): Promise<Message[]> {
    const result = await this.client.send(
      new ReceiveMessageCommand({
        QueueUrl: this.queueUrl,
        MaxNumberOfMessages: Math.min(maxMessages, 10),
        WaitTimeSeconds: waitSeconds,
      })
    );
    return result.Messages ?? [];
  }

  async purge(): Promise<void> {
    await this.client.send(new PurgeQueueCommand({ QueueUrl: this.queueUrl }));
  }

  async assertMessageCount(expectedCount: number): Promise<void> {
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
