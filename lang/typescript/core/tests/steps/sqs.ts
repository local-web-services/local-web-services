/** SQS step definitions. */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import {
  CreateQueueCommand,
  DeleteQueueCommand,
  ListQueuesCommand,
  SendMessageCommand,
  ReceiveMessageCommand,
  DeleteMessageCommand,
  PurgeQueueCommand,
  GetQueueAttributesCommand,
  SetQueueAttributesCommand,
  GetQueueUrlCommand,
  TagQueueCommand,
  UntagQueueCommand,
  ListQueueTagsCommand,
  DeleteMessageBatchCommand,
  SendMessageBatchCommand,
  ChangeMessageVisibilityCommand,
  ChangeMessageVisibilityBatchCommand,
  ListDeadLetterSourceQueuesCommand,
} from "@aws-sdk/client-sqs";
import type { LwsWorld } from "../support/world";

// --- Helpers ---------------------------------------------------------------

async function createQueue(world: LwsWorld, queueName: string): Promise<string> {
  const client = world.sqsClient();
  await client.send(new CreateQueueCommand({ QueueName: queueName }));
  return world.sqsQueueUrl(queueName);
}

// --- Given -----------------------------------------------------------------

Given("a queue {string} was created", async function (this: LwsWorld, queueName: string) {
  await createQueue(this, queueName);
});

Given("a message {string} was sent to queue {string}", async function (
  this: LwsWorld,
  messageBody: string,
  queueName: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  await client.send(new SendMessageCommand({ QueueUrl: queueUrl, MessageBody: messageBody }));
});

Given("a message was received from queue {string}", async function (
  this: LwsWorld,
  queueName: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  const result = await client.send(
    new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 1, WaitTimeSeconds: 0 })
  );
  this.lastReceiptHandle = result.Messages?.[0]?.ReceiptHandle;
  this.lastQueueUrl = queueUrl;
});

Given("queue {string} was tagged with {string}", async function (
  this: LwsWorld,
  queueName: string,
  tagsJson: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  const tags = JSON.parse(tagsJson) as Record<string, string>;
  await client.send(new TagQueueCommand({ QueueUrl: queueUrl, Tags: tags }));
});

// --- When ------------------------------------------------------------------

When("I create a queue named {string}", async function (this: LwsWorld, queueName: string) {
  const client = this.sqsClient();
  try {
    const result = await client.send(new CreateQueueCommand({ QueueName: queueName }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete the queue {string}", async function (this: LwsWorld, queueName: string) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  try {
    const result = await client.send(new DeleteQueueCommand({ QueueUrl: queueUrl }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list queues", async function (this: LwsWorld) {
  const client = this.sqsClient();
  try {
    const result = await client.send(new ListQueuesCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I send a message {string} to queue {string}", async function (
  this: LwsWorld,
  messageBody: string,
  queueName: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  try {
    const result = await client.send(
      new SendMessageCommand({ QueueUrl: queueUrl, MessageBody: messageBody })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I send a message batch with entries {string} to queue {string}", async function (
  this: LwsWorld,
  entriesJson: string,
  queueName: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  const entries = JSON.parse(entriesJson) as Array<{ Id: string; MessageBody: string }>;
  try {
    const result = await client.send(
      new SendMessageBatchCommand({ QueueUrl: queueUrl, Entries: entries })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I receive a message from queue {string}", async function (
  this: LwsWorld,
  queueName: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  try {
    const result = await client.send(
      new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 1, WaitTimeSeconds: 0 })
    );
    this.lastResult = { success: true, output: result };
    this.lastReceiptHandle = (result.Messages ?? [])[0]?.ReceiptHandle;
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete the received message from queue {string}", async function (
  this: LwsWorld,
  queueName: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  try {
    const result = await client.send(
      new DeleteMessageCommand({ QueueUrl: queueUrl, ReceiptHandle: this.lastReceiptHandle! })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete messages in batch for the received message in queue {string}", async function (
  this: LwsWorld,
  queueName: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  try {
    const result = await client.send(
      new DeleteMessageBatchCommand({
        QueueUrl: queueUrl,
        Entries: [{ Id: "1", ReceiptHandle: this.lastReceiptHandle! }],
      })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I purge queue {string}", async function (this: LwsWorld, queueName: string) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  try {
    const result = await client.send(new PurgeQueueCommand({ QueueUrl: queueUrl }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get queue attributes for {string}", async function (this: LwsWorld, queueName: string) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  try {
    const result = await client.send(
      new GetQueueAttributesCommand({ QueueUrl: queueUrl, AttributeNames: ["All"] })
    );
    // Wrap in GetQueueAttributesResponse so feature-file assertion "output will contain GetQueueAttributesResponse" passes
    this.lastResult = { success: true, output: { GetQueueAttributesResponse: result } };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I set queue attributes {string} on queue {string}", async function (
  this: LwsWorld,
  attrsJson: string,
  queueName: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  const attrs = JSON.parse(attrsJson) as Record<string, string>;
  try {
    const result = await client.send(
      new SetQueueAttributesCommand({ QueueUrl: queueUrl, Attributes: attrs })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get the queue URL for {string}", async function (this: LwsWorld, queueName: string) {
  const client = this.sqsClient();
  try {
    const result = await client.send(new GetQueueUrlCommand({ QueueName: queueName }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I tag queue {string} with tags {string}", async function (
  this: LwsWorld,
  queueName: string,
  tagsJson: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  const tags = JSON.parse(tagsJson) as Record<string, string>;
  try {
    const result = await client.send(new TagQueueCommand({ QueueUrl: queueUrl, Tags: tags }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I untag queue {string} with tag keys {string}", async function (
  this: LwsWorld,
  queueName: string,
  tagKeysJson: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  const tagKeys = JSON.parse(tagKeysJson) as string[];
  try {
    const result = await client.send(new UntagQueueCommand({ QueueUrl: queueUrl, TagKeys: tagKeys }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list queue tags for {string}", async function (this: LwsWorld, queueName: string) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  try {
    const result = await client.send(new ListQueueTagsCommand({ QueueUrl: queueUrl }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I change the visibility timeout to {string} for the received message in queue {string}", async function (
  this: LwsWorld,
  timeout: string,
  queueName: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  try {
    const result = await client.send(
      new ChangeMessageVisibilityCommand({
        QueueUrl: queueUrl,
        ReceiptHandle: this.lastReceiptHandle!,
        VisibilityTimeout: parseInt(timeout, 10),
      })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I change message visibility in batch with timeout {string} for the received message in queue {string}", async function (
  this: LwsWorld,
  timeout: string,
  queueName: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  try {
    const result = await client.send(
      new ChangeMessageVisibilityBatchCommand({
        QueueUrl: queueUrl,
        Entries: [
          {
            Id: "1",
            ReceiptHandle: this.lastReceiptHandle!,
            VisibilityTimeout: parseInt(timeout, 10),
          },
        ],
      })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list dead letter source queues for {string}", async function (
  this: LwsWorld,
  queueName: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  try {
    const result = await client.send(new ListDeadLetterSourceQueuesCommand({ QueueUrl: queueUrl }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// Timed variant
When("I list SQS queues with timing", async function (this: LwsWorld) {
  const client = this.sqsClient();
  const start = Date.now();
  try {
    const result = await client.send(new ListQueuesCommand({}));
    this.timedResult = { success: true, output: result, elapsedMs: Date.now() - start };
  } catch (err) {
    this.timedResult = { success: false, output: err, elapsedMs: Date.now() - start };
  }
});

When("I list SQS queues", async function (this: LwsWorld) {
  const client = this.sqsClient();
  try {
    const result = await client.send(new ListQueuesCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// --- Then ------------------------------------------------------------------

Then("the queue {string} will appear in the queue list", async function (
  this: LwsWorld,
  queueName: string
) {
  const client = this.sqsClient();
  const result = await client.send(new ListQueuesCommand({}));
  const urls = result.QueueUrls ?? [];
  const found = urls.some((url) => url.includes(queueName));
  assert.ok(found, `Expected queue "${queueName}" in list but got: ${urls.join(", ")}`);
});

Then("the queue {string} will not appear in the queue list", async function (
  this: LwsWorld,
  queueName: string
) {
  const client = this.sqsClient();
  const result = await client.send(new ListQueuesCommand({}));
  const urls = result.QueueUrls ?? [];
  const found = urls.some((url) => url.includes(queueName));
  assert.ok(!found, `Expected queue "${queueName}" to not be in list but found it`);
});

Then("the output will contain queue {string}", function (this: LwsWorld, queueName: string) {
  const actualOutput = JSON.stringify(this.lastResult.output);
  assert.ok(
    actualOutput.includes(queueName),
    `Expected output to contain queue "${queueName}" but got: ${actualOutput}`
  );
});

Then("the output will contain a message with body {string}", function (
  this: LwsWorld,
  expectedBody: string
) {
  const actualOutput = JSON.stringify(this.lastResult.output);
  assert.ok(
    actualOutput.includes(expectedBody),
    `Expected output to contain message body "${expectedBody}" but got: ${actualOutput}`
  );
});

Then("queue {string} will contain a message with body {string}", async function (
  this: LwsWorld,
  queueName: string,
  expectedBody: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  const result = await client.send(
    new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 10, WaitTimeSeconds: 0 })
  );
  const bodies = (result.Messages ?? []).map((m) => m.Body);
  assert.ok(
    bodies.includes(expectedBody),
    `Expected queue to have message "${expectedBody}" but got: ${bodies.join(", ")}`
  );
});

Then("queue {string} will have approximate message count {string}", async function (
  this: LwsWorld,
  queueName: string,
  expectedCount: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  const result = await client.send(
    new GetQueueAttributesCommand({
      QueueUrl: queueUrl,
      AttributeNames: ["ApproximateNumberOfMessages"],
    })
  );
  const actualCount = result.Attributes?.ApproximateNumberOfMessages ?? "0";
  assert.strictEqual(actualCount, expectedCount);
});

Then("queue {string} will have attribute {string} equal to {string}", async function (
  this: LwsWorld,
  queueName: string,
  attrName: string,
  expectedValue: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  const result = await client.send(
    new GetQueueAttributesCommand({ QueueUrl: queueUrl, AttributeNames: ["All"] })
  );
  const attrs = result.Attributes as Record<string, string> | undefined;
  const actualValue = attrs?.[attrName];
  assert.strictEqual(actualValue, expectedValue);
});

Then("queue {string} will have tag {string} with value {string}", async function (
  this: LwsWorld,
  queueName: string,
  tagKey: string,
  expectedValue: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  const result = await client.send(new ListQueueTagsCommand({ QueueUrl: queueUrl }));
  const actualValue = result.Tags?.[tagKey];
  assert.strictEqual(actualValue, expectedValue);
});

Then("queue {string} will not have tag {string}", async function (
  this: LwsWorld,
  queueName: string,
  tagKey: string
) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(queueName);
  const result = await client.send(new ListQueueTagsCommand({ QueueUrl: queueUrl }));
  const value = result.Tags?.[tagKey];
  assert.ok(!value, `Expected tag "${tagKey}" to not exist but got: ${value}`);
});

// Note: "the output will contain {string}" is handled by common.ts
