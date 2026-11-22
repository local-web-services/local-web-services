import { Given, When, Then } from "@cucumber/cucumber";
import {
  CreateTopicCommand,
  DeleteTopicCommand,
  ListTopicsCommand,
  PublishCommand,
} from "@aws-sdk/client-sns";
import type { SnsWorld } from "../support/world.js";
import { TEST_TOPIC_NAME } from "../support/world.js";

Given("the sns system is initialized", async function (this: SnsWorld) {
  // Session started in BeforeAll
});

Given('the "sns" "topic" exists', async function (this: SnsWorld) {
  const result = await this.snsClient.send(new CreateTopicCommand({ Name: TEST_TOPIC_NAME }));
  this.topicArn = result.TopicArn ?? "";
});

When('a "sns" "topic" is created', async function (this: SnsWorld) {
  try {
    const result = await this.snsClient.send(new CreateTopicCommand({ Name: TEST_TOPIC_NAME }));
    this.topicArn = result.TopicArn ?? "";
    this.result = result;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "sns" "topic" is deleted', async function (this: SnsWorld) {
  try {
    this.result = await this.snsClient.send(new DeleteTopicCommand({ TopicArn: this.topicArn }));
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a message is published to the "sns" "topic"', async function (this: SnsWorld) {
  try {
    this.result = await this.snsClient.send(
      new PublishCommand({ TopicArn: this.topicArn, Message: "lws-e2e-test-message" }),
    );
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

Then('the "sns" "topic" will exist', async function (this: SnsWorld) {
  const listResult = await this.snsClient.send(new ListTopicsCommand({}));
  const expectedTopicArn = this.topicArn;
  const actualTopics = listResult.Topics ?? [];
  const found = actualTopics.some((t) => t.TopicArn === expectedTopicArn);
  if (!found) {
    throw new Error(`Expected to find topic '${expectedTopicArn}' in ListTopics but it was absent`);
  }
});

Then('the "sns" "topic" will not exist', async function (this: SnsWorld) {
  const listResult = await this.snsClient.send(new ListTopicsCommand({}));
  const expectedAbsentArn = this.topicArn;
  const actualTopics = listResult.Topics ?? [];
  const found = actualTopics.some((t) => t.TopicArn === expectedAbsentArn);
  if (found) {
    throw new Error(`Expected topic '${expectedAbsentArn}' to be deleted but it still appears in ListTopics`);
  }
});

Then('the message will have a "sns" "MessageId"', function (this: SnsWorld) {
  const actualMessageId = (this.result as { MessageId?: string } | null)?.MessageId;
  if (!actualMessageId) {
    throw new Error("Expected a MessageId in the Publish response but got none");
  }
});
