/** SNS step definitions. */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import {
  CreateTopicCommand,
  DeleteTopicCommand,
  ListTopicsCommand,
  PublishCommand,
  SubscribeCommand,
  UnsubscribeCommand,
  ListSubscriptionsCommand,
  ListSubscriptionsByTopicCommand,
  GetTopicAttributesCommand,
  SetTopicAttributesCommand,
  GetSubscriptionAttributesCommand,
  SetSubscriptionAttributesCommand,
  TagResourceCommand,
  UntagResourceCommand,
  ListTagsForResourceCommand,
  ConfirmSubscriptionCommand,
} from "@aws-sdk/client-sns";
import type { LwsWorld } from "../support/world";

const ACCOUNT = "000000000000";
const REGION = "us-east-1";

function topicArn(port: number, topicName: string): string {
  return `arn:aws:sns:${REGION}:${ACCOUNT}:${topicName}`;
}

async function createTopic(world: LwsWorld, topicName: string): Promise<string> {
  const client = world.snsClient();
  const result = await client.send(new CreateTopicCommand({ Name: topicName }));
  return result.TopicArn!;
}

// --- Given -----------------------------------------------------------------

Given("a topic {string} was created", async function (this: LwsWorld, topicName: string) {
  const arn = await createTopic(this, topicName);
  this.lastTopicArn = arn;
});

Given("an SQS subscription to {string} was added to topic {string}", async function (
  this: LwsWorld,
  sqsArn: string,
  topicName: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  const result = await client.send(
    new SubscribeCommand({ TopicArn: arn, Protocol: "sqs", Endpoint: sqsArn })
  );
  this.lastSubscriptionArn = result.SubscriptionArn;
});

Given("tags {string} were added to topic {string}", async function (
  this: LwsWorld,
  tagsJson: string,
  topicName: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  const tags = (JSON.parse(tagsJson) as Array<{ Key: string; Value: string }>).map((t) => ({
    Key: t.Key,
    Value: t.Value,
  }));
  await client.send(new TagResourceCommand({ ResourceArn: arn, Tags: tags }));
});

// --- When ------------------------------------------------------------------

When("I create topic {string}", async function (this: LwsWorld, topicName: string) {
  const client = this.snsClient();
  try {
    const result = await client.send(new CreateTopicCommand({ Name: topicName }));
    this.lastTopicArn = result.TopicArn;
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete the topic {string}", async function (this: LwsWorld, topicName: string) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  try {
    const result = await client.send(new DeleteTopicCommand({ TopicArn: arn }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list topics", async function (this: LwsWorld) {
  const client = this.snsClient();
  try {
    const result = await client.send(new ListTopicsCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I publish message {string} to topic {string}", async function (
  this: LwsWorld,
  message: string,
  topicName: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  try {
    const result = await client.send(
      new PublishCommand({ TopicArn: arn, Message: message })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I subscribe {string} with protocol {string} to the topic {string}", async function (
  this: LwsWorld,
  endpoint: string,
  protocol: string,
  topicName: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  try {
    const result = await client.send(
      new SubscribeCommand({ TopicArn: arn, Protocol: protocol, Endpoint: endpoint })
    );
    this.lastSubscriptionArn = result.SubscriptionArn;
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I unsubscribe the subscription on topic {string}", async function (
  this: LwsWorld,
  _topicName: string
) {
  const client = this.snsClient();
  try {
    const result = await client.send(
      new UnsubscribeCommand({ SubscriptionArn: this.lastSubscriptionArn! })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list subscriptions", async function (this: LwsWorld) {
  const client = this.snsClient();
  try {
    const result = await client.send(new ListSubscriptionsCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list subscriptions by topic {string}", async function (
  this: LwsWorld,
  topicName: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  try {
    const result = await client.send(new ListSubscriptionsByTopicCommand({ TopicArn: arn }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get topic attributes for topic {string}", async function (
  this: LwsWorld,
  topicName: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  try {
    const result = await client.send(new GetTopicAttributesCommand({ TopicArn: arn }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I set topic attribute {string} to {string} for topic {string}", async function (
  this: LwsWorld,
  attrName: string,
  attrValue: string,
  topicName: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  try {
    const result = await client.send(
      new SetTopicAttributesCommand({ TopicArn: arn, AttributeName: attrName, AttributeValue: attrValue })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get subscription attributes for the subscription on topic {string}", async function (
  this: LwsWorld,
  _topicName: string
) {
  const client = this.snsClient();
  try {
    const result = await client.send(
      new GetSubscriptionAttributesCommand({ SubscriptionArn: this.lastSubscriptionArn! })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I set subscription attribute {string} to {string} for the subscription on topic {string}", async function (
  this: LwsWorld,
  attrName: string,
  attrValue: string,
  _topicName: string
) {
  const client = this.snsClient();
  try {
    const result = await client.send(
      new SetSubscriptionAttributesCommand({
        SubscriptionArn: this.lastSubscriptionArn!,
        AttributeName: attrName,
        AttributeValue: attrValue,
      })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I tag resource {string} with tags {string}", async function (
  this: LwsWorld,
  topicName: string,
  tagsJson: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  const tags = (JSON.parse(tagsJson) as Array<{ Key: string; Value: string }>).map((t) => ({
    Key: t.Key,
    Value: t.Value,
  }));
  try {
    const result = await client.send(new TagResourceCommand({ ResourceArn: arn, Tags: tags }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I untag resource {string} with tag keys {string}", async function (
  this: LwsWorld,
  topicName: string,
  tagKeysJson: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  const tagKeys = JSON.parse(tagKeysJson) as string[];
  try {
    const result = await client.send(new UntagResourceCommand({ ResourceArn: arn, TagKeys: tagKeys }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list tags for resource {string}", async function (this: LwsWorld, resourceRef: string) {
  // Route based on whether it's an EventBridge ARN or SNS topic name
  if (resourceRef.startsWith("arn:aws:events:")) {
    const { EventBridgeClient, ListTagsForResourceCommand: EbListTags } = await import("@aws-sdk/client-eventbridge");
    const client = new EventBridgeClient({
      endpoint: `http://127.0.0.1:${this.eventbridgePort}`,
      credentials: { accessKeyId: "test", secretAccessKey: "test" },
      region: "us-east-1",
    });
    try {
      const result = await client.send(new EbListTags({ ResourceARN: resourceRef }));
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  } else {
    const client = this.snsClient();
    const arn = topicArn(this.snsPort, resourceRef);
    try {
      const result = await client.send(new ListTagsForResourceCommand({ ResourceArn: arn }));
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  }
});

When("I confirm subscription for topic {string} with token {string}", async function (
  this: LwsWorld,
  topicName: string,
  token: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  try {
    const result = await client.send(
      new ConfirmSubscriptionCommand({ TopicArn: arn, Token: token })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// Timed variant
When("I list SNS topics with timing", async function (this: LwsWorld) {
  const client = this.snsClient();
  const start = Date.now();
  try {
    const result = await client.send(new ListTopicsCommand({}));
    this.timedResult = { success: true, output: result, elapsedMs: Date.now() - start };
  } catch (err) {
    this.timedResult = { success: false, output: err, elapsedMs: Date.now() - start };
  }
});

When("I list SNS topics", async function (this: LwsWorld) {
  const client = this.snsClient();
  try {
    const result = await client.send(new ListTopicsCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// --- Then ------------------------------------------------------------------

Then("the topic {string} will appear in the topic list", async function (
  this: LwsWorld,
  topicName: string
) {
  const client = this.snsClient();
  const result = await client.send(new ListTopicsCommand({}));
  const arns = (result.Topics ?? []).map((t) => t.TopicArn ?? "");
  assert.ok(
    arns.some((a) => a.includes(topicName)),
    `Expected topic "${topicName}" in list but got: ${arns.join(", ")}`
  );
});

Then("the topic {string} will not appear in the topic list", async function (
  this: LwsWorld,
  topicName: string
) {
  const client = this.snsClient();
  const result = await client.send(new ListTopicsCommand({}));
  const arns = (result.Topics ?? []).map((t) => t.TopicArn ?? "");
  assert.ok(
    !arns.some((a) => a.includes(topicName)),
    `Expected topic "${topicName}" to not be in list`
  );
});

Then("the output will contain a ListSubscriptionsResponse", function (this: LwsWorld) {
  const output = this.lastResult.output as { Subscriptions?: unknown[] };
  assert.ok(output?.Subscriptions !== undefined, "Expected Subscriptions in output");
});

Then("the output will contain a PublishResponse", function (this: LwsWorld) {
  const output = this.lastResult.output as { MessageId?: string };
  assert.ok(output?.MessageId, "Expected MessageId in PublishResponse");
});

Then("the topic {string} will have a subscription in the subscription list", async function (
  this: LwsWorld,
  topicName: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  const result = await client.send(new ListSubscriptionsByTopicCommand({ TopicArn: arn }));
  assert.ok((result.Subscriptions ?? []).length > 0, "Expected at least one subscription");
});

Then("the topic {string} will not have a subscription in the subscription list", async function (
  this: LwsWorld,
  topicName: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  const result = await client.send(new ListSubscriptionsByTopicCommand({ TopicArn: arn }));
  assert.strictEqual((result.Subscriptions ?? []).length, 0, "Expected no subscriptions");
});

Then("the topic {string} will have display name {string}", async function (
  this: LwsWorld,
  topicName: string,
  expectedDisplayName: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  const result = await client.send(new GetTopicAttributesCommand({ TopicArn: arn }));
  const actualDisplayName = result.Attributes?.DisplayName;
  assert.strictEqual(actualDisplayName, expectedDisplayName);
});

Then("the subscription on topic {string} will have attribute {string} equal to {string}", async function (
  this: LwsWorld,
  _topicName: string,
  attrName: string,
  expectedValue: string
) {
  const client = this.snsClient();
  const result = await client.send(
    new GetSubscriptionAttributesCommand({ SubscriptionArn: this.lastSubscriptionArn! })
  );
  const actualValue = result.Attributes?.[attrName];
  assert.strictEqual(actualValue, expectedValue);
});

Then("topic {string} will have tag {string} with value {string}", async function (
  this: LwsWorld,
  topicName: string,
  tagKey: string,
  expectedValue: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  const result = await client.send(new ListTagsForResourceCommand({ ResourceArn: arn }));
  const tags = result.Tags ?? [];
  const tag = tags.find((t) => t.Key === tagKey);
  assert.strictEqual(tag?.Value, expectedValue);
});

Then("topic {string} will not have tag {string}", async function (
  this: LwsWorld,
  topicName: string,
  tagKey: string
) {
  const client = this.snsClient();
  const arn = topicArn(this.snsPort, topicName);
  const result = await client.send(new ListTagsForResourceCommand({ ResourceArn: arn }));
  const tags = result.Tags ?? [];
  const tag = tags.find((t) => t.Key === tagKey);
  assert.ok(!tag, `Expected tag "${tagKey}" to not exist`);
});
