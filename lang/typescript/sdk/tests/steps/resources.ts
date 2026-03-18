/** Step definitions: resource_specification */

import { Given, Then } from "@cucumber/cucumber";
import assert from "assert";
import { LwsSession } from "../../src/session";
import type { SdkWorld } from "../support/world";

const PASS_DEFINITION = {
  Comment: "test",
  StartAt: "Pass",
  States: { Pass: { Type: "Pass", End: true } },
};

// ── Session creation with single resource ─────────────────────────────────────

Given(
  "a session with a DynamoDB table {string} with partition key {string}",
  async function (this: SdkWorld, tableName: string, partitionKey: string) {
    this._pendingSpec = {
      tables: [{ name: tableName, partitionKey }],
    };
    this.session = await LwsSession.create(this._pendingSpec);
  },
);

Given("a session with an SQS queue {string}", async function (this: SdkWorld, queueName: string) {
  this._pendingSpec = { queues: [queueName] };
  this.session = await LwsSession.create(this._pendingSpec);
});

Given("a session with an S3 bucket {string}", async function (this: SdkWorld, bucketName: string) {
  this._pendingSpec = { buckets: [bucketName] };
  this.session = await LwsSession.create(this._pendingSpec);
});

Given("a session with an SNS topic {string}", async function (this: SdkWorld, topicName: string) {
  this._pendingSpec = { topics: [topicName] };
  this.session = await LwsSession.create(this._pendingSpec);
});

Given(
  "a session with a state machine {string} using a Pass definition",
  async function (this: SdkWorld, smName: string) {
    this._pendingSpec = {
      stateMachines: [{ name: smName, definition: PASS_DEFINITION }],
    };
    this.session = await LwsSession.create(this._pendingSpec);
  },
);

// ── "also has" steps — add resources to an existing spec and re-create ─────────

Given(
  "the session also has an SQS queue {string}",
  async function (this: SdkWorld, queueName: string) {
    // Close existing session, update spec, re-create
    if (this.session) {
      await this.session.close();
      this.session = null;
    }
    this._pendingSpec = {
      ...this._pendingSpec,
      queues: [...(this._pendingSpec.queues ?? []), queueName],
    };
    this.session = await LwsSession.create(this._pendingSpec);
  },
);

Given(
  "the session also has an S3 bucket {string}",
  async function (this: SdkWorld, bucketName: string) {
    if (this.session) {
      await this.session.close();
      this.session = null;
    }
    this._pendingSpec = {
      ...this._pendingSpec,
      buckets: [...(this._pendingSpec.buckets ?? []), bucketName],
    };
    this.session = await LwsSession.create(this._pendingSpec);
  },
);

// ── Existence assertions ───────────────────────────────────────────────────────

Then("the table {string} exists", async function (this: SdkWorld, tableName: string) {
  assert.ok(this.session, "No session");
  const { DynamoDBClient, ListTablesCommand } = require("@aws-sdk/client-dynamodb");
  const client = this.session!.client<typeof DynamoDBClient>("dynamodb");
  const result = await client.send(new ListTablesCommand({}));
  const tableNames: string[] = result.TableNames ?? [];
  assert.ok(
    tableNames.includes(tableName),
    `Expected table "${tableName}" to exist but found: ${JSON.stringify(tableNames)}`,
  );
});

Then("the queue {string} exists", async function (this: SdkWorld, queueName: string) {
  assert.ok(this.session, "No session");
  const { SQSClient, ListQueuesCommand } = require("@aws-sdk/client-sqs");
  const client = this.session!.client<typeof SQSClient>("sqs");
  const result = await client.send(new ListQueuesCommand({}));
  const urls: string[] = result.QueueUrls ?? [];
  const exists = urls.some((u) => u.endsWith(`/${queueName}`));
  assert.ok(exists, `Expected queue "${queueName}" to exist but found: ${JSON.stringify(urls)}`);
});

Then("the bucket {string} exists", async function (this: SdkWorld, bucketName: string) {
  assert.ok(this.session, "No session");
  const { S3Client, ListBucketsCommand } = require("@aws-sdk/client-s3");
  const client = this.session!.client<typeof S3Client>("s3");
  const result = await client.send(new ListBucketsCommand({}));
  const buckets: Array<{ Name?: string }> = result.Buckets ?? [];
  const names = buckets.map((b) => b.Name ?? "");
  assert.ok(
    names.includes(bucketName),
    `Expected bucket "${bucketName}" to exist but found: ${JSON.stringify(names)}`,
  );
});

Then("the topic {string} exists", async function (this: SdkWorld, topicName: string) {
  assert.ok(this.session, "No session");
  const { SNSClient, ListTopicsCommand } = require("@aws-sdk/client-sns");
  const client = this.session!.client<typeof SNSClient>("sns");
  const result = await client.send(new ListTopicsCommand({}));
  const arns: string[] = (result.Topics ?? []).map((t: { TopicArn?: string }) => t.TopicArn ?? "");
  const exists = arns.some((arn) => arn.endsWith(`:${topicName}`));
  assert.ok(exists, `Expected topic "${topicName}" to exist but found: ${JSON.stringify(arns)}`);
});

Then("the state machine {string} exists", async function (this: SdkWorld, smName: string) {
  assert.ok(this.session, "No session");
  const { SFNClient, ListStateMachinesCommand } = require("@aws-sdk/client-sfn");
  const client = this.session!.client<typeof SFNClient>("stepfunctions");
  const result = await client.send(new ListStateMachinesCommand({}));
  const machines: Array<{ name: string }> = result.stateMachines ?? [];
  const names = machines.map((m) => m.name);
  assert.ok(
    names.includes(smName),
    `Expected state machine "${smName}" to exist but found: ${JSON.stringify(names)}`,
  );
});
