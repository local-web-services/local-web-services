import { When } from "@cucumber/cucumber";
import {
  CreateQueueCommand,
  DeleteQueueCommand,
  SendMessageCommand,
  ReceiveMessageCommand,
  DeleteMessageCommand,
  PurgeQueueCommand,
} from "@aws-sdk/client-sqs";
import type { SqsWorld } from "../support/world.js";
import { TEST_QUEUE, TEST_MESSAGE } from "../support/world.js";

When('a "sqs" "queue" is created', async function (this: SqsWorld) {
  try {
    this.result = await this.sqsClient.send(new CreateQueueCommand({ QueueName: TEST_QUEUE }));
    this.error = null;
  } catch (err) {
    this.result = null;
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "sqs" "queue" is deleted', async function (this: SqsWorld) {
  try {
    this.result = await this.sqsClient.send(
      new DeleteQueueCommand({ QueueUrl: this.session.queueUrl(TEST_QUEUE) }),
    );
    this.error = null;
  } catch (err) {
    this.result = null;
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "sqs" "message" is sent to the "sqs" "queue"', async function (this: SqsWorld) {
  try {
    this.result = await this.sqsClient.send(
      new SendMessageCommand({
        QueueUrl: this.session.queueUrl(TEST_QUEUE),
        MessageBody: TEST_MESSAGE,
      }),
    );
    this.error = null;
  } catch (err) {
    this.result = null;
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "sqs" "message" is received from the "sqs" "queue"', async function (this: SqsWorld) {
  try {
    const queueUrl =
      this.messageId === "fake-message-id"
        ? this.session.queueUrl("does-not-exist")
        : this.session.queueUrl(TEST_QUEUE);
    const resp = await this.sqsClient.send(
      new ReceiveMessageCommand({
        QueueUrl: queueUrl,
        MaxNumberOfMessages: 1,
        VisibilityTimeout: 30,
        WaitTimeSeconds: 0,
      }),
    );
    const msg = resp.Messages?.[0];
    if (msg === undefined) {
      this.error = new Error("No messages available in queue");
      this.result = null;
    } else {
      this.receiptHandle = msg.ReceiptHandle ?? null;
      this.result = resp;
      this.error = null;
    }
  } catch (err) {
    this.result = null;
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('an in-flight "sqs" "message" is deleted', async function (this: SqsWorld) {
  try {
    if (this.receiptHandle === null) {
      throw new Error("No receipt handle — message was not IN_FLIGHT");
    }
    this.result = await this.sqsClient.send(
      new DeleteMessageCommand({
        QueueUrl: this.session.queueUrl(TEST_QUEUE),
        ReceiptHandle: this.receiptHandle,
      }),
    );
    this.error = null;
  } catch (err) {
    this.result = null;
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('all "sqs" "message"s in a "sqs" "queue" are purged', async function (this: SqsWorld) {
  try {
    this.result = await this.sqsClient.send(
      new PurgeQueueCommand({ QueueUrl: this.session.queueUrl(TEST_QUEUE) }),
    );
    this.error = null;
  } catch (err) {
    this.result = null;
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('all "sqs" "messages" in the "sqs" "queue" are purged', async function (this: SqsWorld) {
  try {
    this.result = await this.sqsClient.send(
      new PurgeQueueCommand({ QueueUrl: this.session.queueUrl(TEST_QUEUE) }),
    );
    this.error = null;
  } catch (err) {
    this.result = null;
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});
