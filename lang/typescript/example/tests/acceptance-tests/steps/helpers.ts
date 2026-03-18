import { When, Then } from "@cucumber/cucumber";
import * as assert from "assert";
import { OrderWorld } from "../support/world";

When(
  "I put item with orderId {string} and status {string} into {string}",
  async function (this: OrderWorld, orderId: string, status: string, _tableName: string) {
    await this.ddbHelper!.put({
      orderId: { S: orderId },
      status: { S: status },
    });
  },
);

Then(
  "the table {string} will contain {int} item(s)",
  async function (this: OrderWorld, _tableName: string, expectedCount: number) {
    await this.ddbHelper!.assertItemCount(expectedCount);
  },
);

Then(
  "the table {string} will contain an item with orderId {string}",
  async function (this: OrderWorld, _tableName: string, orderId: string) {
    await this.ddbHelper!.assertItemExists({ orderId: { S: orderId } });
  },
);

When(
  "I send message body {string} to {string}",
  async function (this: OrderWorld, body: string, _queueName: string) {
    await this.sqsHelper!.send(body);
  },
);

Then(
  "receiving {int} message(s) from {string} will return body {string}",
  async function (this: OrderWorld, count: number, _queueName: string, expectedBody: string) {
    const messages = await this.sqsHelper!.receive(count);
    assert.ok(messages.length > 0, "Expected at least one message");
    assert.strictEqual(messages[0].Body, expectedBody);
  },
);
