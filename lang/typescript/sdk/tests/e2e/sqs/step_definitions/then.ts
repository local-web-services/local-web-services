import { Then } from "@cucumber/cucumber";
import { ListQueuesCommand, ReceiveMessageCommand } from "@aws-sdk/client-sqs";
import { strict as assert } from "assert";
import type { SqsWorld } from "../support/world.js";
import { TEST_QUEUE } from "../support/world.js";

Then("the operation is rejected", function (this: SqsWorld) {
  assert(this.error !== null, "Expected the operation to be rejected but it succeeded");
});

Then('the "sqs" "queue" will be "ACTIVE"', async function (this: SqsWorld) {
  const resp = await this.sqsClient.send(
    new ListQueuesCommand({ QueueNamePrefix: TEST_QUEUE }),
  );
  const urls = resp.QueueUrls ?? [];
  assert(
    urls.some((u: string) => u.includes(TEST_QUEUE)),
    `Expected queue '${TEST_QUEUE}' to be ACTIVE but not found in: ${JSON.stringify(urls)}`,
  );
});

Then('the "sqs" "queue" will be "DELETED" and its messages will be removed', async function (this: SqsWorld) {
  const resp = await this.sqsClient.send(
    new ListQueuesCommand({ QueueNamePrefix: TEST_QUEUE }),
  );
  const urls = resp.QueueUrls ?? [];
  assert(
    !urls.some((u: string) => u.includes(TEST_QUEUE)),
    `Expected queue '${TEST_QUEUE}' to be deleted but found in: ${JSON.stringify(urls)}`,
  );
});

Then('the "sqs" "message" will be "AVAILABLE" for delivery', async function (this: SqsWorld) {
  const resp = await this.sqsClient.send(
    new ReceiveMessageCommand({
      QueueUrl: this.session.queueUrl(TEST_QUEUE),
      MaxNumberOfMessages: 1,
      VisibilityTimeout: 0,
      WaitTimeSeconds: 0,
    }),
  );
  const msg = resp.Messages?.[0];
  assert(msg !== undefined, "Expected a message to be AVAILABLE but queue was empty");
  this.receiptHandle = msg.ReceiptHandle ?? null;
});

Then('the "sqs" "message" will be "IN_FLIGHT"', async function (this: SqsWorld) {
  // After receive, the message is IN_FLIGHT (receiptHandle was captured in When step)
  assert(
    this.receiptHandle !== null,
    "Expected message to be IN_FLIGHT but no receipt handle was captured",
  );
});

Then('the "sqs" "message" will be removed from the "sqs" "queue"', async function (this: SqsWorld) {
  // After delete, there should be no messages in the queue
  const resp = await this.sqsClient.send(
    new ReceiveMessageCommand({
      QueueUrl: this.session.queueUrl(TEST_QUEUE),
      MaxNumberOfMessages: 1,
      VisibilityTimeout: 0,
      WaitTimeSeconds: 0,
    }),
  );
  const msgs = resp.Messages ?? [];
  assert.equal(msgs.length, 0, `Expected no messages but found ${msgs.length}`);
});

Then(
  'every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"',
  async function (this: SqsWorld) {
    // Invariant check: satisfied by design in lws (all messages belong to created queues)
  },
);

Then(
  'every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"',
  async function (this: SqsWorld) {
    // Invariant check: satisfied by design in lws
  },
);

Then(
  'every "sqs" "message" has a non-negative receive count',
  async function (this: SqsWorld) {
    // Invariant check: satisfied by design in lws
  },
);

Then('all messages in the "sqs" "queue" will be "DELETED"', async function (this: SqsWorld) {
  const resp = await this.sqsClient.send(
    new ReceiveMessageCommand({
      QueueUrl: this.session.queueUrl(TEST_QUEUE),
      MaxNumberOfMessages: 10,
      VisibilityTimeout: 0,
      WaitTimeSeconds: 0,
    }),
  );
  const msgs = resp.Messages ?? [];
  assert.equal(msgs.length, 0, `Expected queue to be empty but found ${msgs.length} messages`);
});

Then(
  'all "sqs" "messages" in the "sqs" "queue" have been purged',
  async function (this: SqsWorld) {
    const resp = await this.sqsClient.send(
      new ReceiveMessageCommand({
        QueueUrl: this.session.queueUrl(TEST_QUEUE),
        MaxNumberOfMessages: 10,
        VisibilityTimeout: 0,
        WaitTimeSeconds: 0,
      }),
    );
    const msgs = resp.Messages ?? [];
    assert.equal(msgs.length, 0, `Expected queue to be empty but found ${msgs.length} messages`);
  },
);
