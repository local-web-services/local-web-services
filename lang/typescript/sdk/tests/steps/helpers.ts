/** Step definitions: dynamodb_helper + sqs_helper + session_reset data steps */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { LwsSession } from "../../src/session";
import type { SdkWorld } from "../support/world";

// ── Session creation with resources (for helpers + reset) ──────────────────────

Given(
  "a running session with a DynamoDB table {string} with partition key {string}",
  async function (this: SdkWorld, tableName: string, partitionKey: string) {
    this._pendingSpec = { tables: [{ name: tableName, partitionKey }] };
    this.session = await LwsSession.create(this._pendingSpec);
  }
);

Given(
  "a running session with an SQS queue {string}",
  async function (this: SdkWorld, queueName: string) {
    this._pendingSpec = { queues: [queueName] };
    this.session = await LwsSession.create(this._pendingSpec);
  }
);

// ── DynamoDB helper steps ──────────────────────────────────────────────────────

When(
  "I put item with orderId {string} and status {string} into {string}",
  async function (
    this: SdkWorld,
    orderId: string,
    status: string,
    tableName: string
  ) {
    assert.ok(this.session, "No session");
    await this.session!.dynamodb(tableName).put({
      orderId: { S: orderId },
      status: { S: status },
    });
  }
);

Then(
  "the table {string} will contain {int} item(s)",
  async function (this: SdkWorld, tableName: string, expectedCount: number) {
    assert.ok(this.session, "No session");
    await this.session!.dynamodb(tableName).assertItemCount(expectedCount);
  }
);

Then(
  "the table {string} will contain an item with orderId {string}",
  async function (this: SdkWorld, tableName: string, orderId: string) {
    assert.ok(this.session, "No session");
    await this.session!.dynamodb(tableName).assertItemExists({
      orderId: { S: orderId },
    });
  }
);

Then(
  "the table {string} will not contain an item with orderId {string}",
  async function (this: SdkWorld, tableName: string, orderId: string) {
    assert.ok(this.session, "No session");
    const item = await this.session!.dynamodb(tableName).get({
      orderId: { S: orderId },
    });
    assert.strictEqual(
      item,
      undefined,
      `Expected item with orderId "${orderId}" to not exist in table "${tableName}"`
    );
  }
);

// ── SQS helper steps ───────────────────────────────────────────────────────────

When(
  "I send message body {string} to {string}",
  async function (this: SdkWorld, body: string, queueName: string) {
    assert.ok(this.session, "No session");
    await this.session!.sqs(queueName).send(body);
  }
);

Then(
  "receiving {int} message from {string} returns body {string}",
  async function (
    this: SdkWorld,
    count: number,
    queueName: string,
    expectedBody: string
  ) {
    assert.ok(this.session, "No session");
    const messages = await this.session!.sqs(queueName).receive(count);
    assert.ok(
      messages.length > 0,
      `Expected at least 1 message from queue "${queueName}"`
    );
    const actualBody = messages[0].Body ?? "";
    assert.strictEqual(
      actualBody,
      expectedBody,
      `Expected message body "${expectedBody}" but got "${actualBody}"`
    );
  }
);

When(
  "I receive {int} message from {string}",
  async function (this: SdkWorld, count: number, queueName: string) {
    assert.ok(this.session, "No session");
    this.lastMessages = await this.session!.sqs(queueName).receive(count);
  }
);

Then(
  "exactly {int} message is returned",
  function (this: SdkWorld, expectedCount: number) {
    assert.strictEqual(
      this.lastMessages.length,
      expectedCount,
      `Expected exactly ${expectedCount} message(s) but got ${this.lastMessages.length}`
    );
  }
);

// ── session_reset data steps ───────────────────────────────────────────────────

Given(
  "an item with orderId {string} has been put into {string}",
  async function (this: SdkWorld, orderId: string, tableName: string) {
    assert.ok(this.session, "No session");
    await this.session!.dynamodb(tableName).put({
      orderId: { S: orderId },
      status: { S: "pending" },
    });
  }
);

Then(
  "the table {string} contains {int} items",
  async function (this: SdkWorld, tableName: string, expectedCount: number) {
    assert.ok(this.session, "No session");
    await this.session!.dynamodb(tableName).assertItemCount(expectedCount);
  }
);

Given(
  "a message has been sent to {string}",
  async function (this: SdkWorld, queueName: string) {
    assert.ok(this.session, "No session");
    await this.session!.sqs(queueName).send("test-message");
  }
);

Then(
  "{string} contains {int} messages",
  async function (this: SdkWorld, queueName: string, expectedCount: number) {
    assert.ok(this.session, "No session");
    await this.session!.sqs(queueName).assertMessageCount(expectedCount);
  }
);
