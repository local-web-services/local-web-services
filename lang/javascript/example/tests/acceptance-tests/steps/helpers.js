'use strict';

/**
 * Step definitions for DynamoDB and SQS helper scenarios.
 */

const { When, Then } = require('@cucumber/cucumber');
const assert = require('assert');
const { DynamoDBHelper } = require('local-web-services-javascript-sdk/src/resources/dynamodb');
const { SQSHelper } = require('local-web-services-javascript-sdk/src/resources/sqs');

// ── DynamoDB helper steps ──────────────────────────────────────────────────

When('I put item with orderId {string} and status {string} into {string}', async function (orderId, status, tableName) {
  const helper = this.ddbHelper || new DynamoDBHelper(tableName, this.createDynamoDBClient());
  await helper.put({ orderId: { S: orderId }, status: { S: status } });
});

Then('the table {string} will contain {int} item', async function (tableName, expectedCount) {
  const helper = this.ddbHelper || new DynamoDBHelper(tableName, this.createDynamoDBClient());
  await helper.assertItemCount(expectedCount);
});

Then('the table {string} will contain {int} items', async function (tableName, expectedCount) {
  const helper = this.ddbHelper || new DynamoDBHelper(tableName, this.createDynamoDBClient());
  await helper.assertItemCount(expectedCount);
});

Then('the table {string} will contain an item with orderId {string}', async function (tableName, orderId) {
  const helper = this.ddbHelper || new DynamoDBHelper(tableName, this.createDynamoDBClient());
  const item = await helper.get({ orderId: { S: orderId } });
  assert.ok(
    item,
    `Expected item with orderId "${orderId}" to exist in table "${tableName}", but it was not found.`
  );
});

// ── SQS helper steps ───────────────────────────────────────────────────────

When('I send message body {string} to {string}', async function (body, queueName) {
  const helper = this.sqsHelper || new SQSHelper(queueName, this.createSQSClient(), this.sqsPort());
  await helper.send(body);
});

Then('receiving {int} message from {string} will return body {string}', async function (maxMessages, queueName, expectedBody) {
  const helper = this.sqsHelper || new SQSHelper(queueName, this.createSQSClient(), this.sqsPort());
  const messages = await helper.receive(maxMessages);
  const bodies = messages.map((m) => m.Body);
  assert.ok(
    bodies.includes(expectedBody),
    `Expected body "${expectedBody}" in received messages but got: ${bodies.join(', ')}`
  );
});
