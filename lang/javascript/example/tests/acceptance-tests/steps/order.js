'use strict';

/**
 * Step definitions for processOrder scenarios.
 */

const { When, Then, Given } = require('@cucumber/cucumber');
const assert = require('assert');
const { processOrder } = require('../../../src/orderProcessor');

When('I process order {string}', { timeout: 30000 }, async function (orderId) {
  const arn = this.stateMachineArn;
  const client = this.sfnClient || this.createSFNClient();
  this.lastOutput = null;
  this.lastError = null;
  try {
    this.lastOutput = await processOrder(orderId, arn, client);
  } catch (err) {
    this.lastError = err;
  }
});

When('I process order {string} via ARN {string}', { timeout: 30000 }, async function (orderId, arn) {
  const client = this.sfnClient || this.createSFNClient();
  this.lastOutput = null;
  this.lastError = null;
  try {
    this.lastOutput = await processOrder(orderId, arn, client);
  } catch (err) {
    this.lastError = err;
  }
});

When('I process orders {string}, {string}, {string}', { timeout: 60000 }, async function (id1, id2, id3) {
  const ids = [id1, id2, id3];
  const client = this.sfnClient || this.createSFNClient();
  const arn = this.stateMachineArn;
  this.processedOutputs = [];
  this.processedIDs = ids;
  this.lastError = null;
  for (const id of ids) {
    try {
      const output = await processOrder(id, arn, client);
      this.processedOutputs.push(output);
    } catch (err) {
      this.lastError = err;
      this.processedOutputs.push(null);
    }
  }
});

Given('order {string} has been processed', { timeout: 30000 }, async function (orderId) {
  const arn = this.stateMachineArn;
  const client = this.sfnClient || this.createSFNClient();
  try {
    await processOrder(orderId, arn, client);
  } catch (_) {
    // Ignore errors; step is a setup step.
  }
});

Then('the output will contain order ID {string}', function (orderId) {
  assert.ok(
    this.lastOutput,
    `Expected output to contain orderId "${orderId}" but lastOutput is null/undefined. lastError: ${this.lastError ? this.lastError.message : 'none'}`
  );
  assert.strictEqual(
    this.lastOutput.orderId,
    orderId,
    `Expected output.orderId to be "${orderId}" but got "${this.lastOutput.orderId}"`
  );
});

Then('each output will contain the corresponding order ID', function () {
  assert.ok(
    this.processedOutputs.length > 0,
    'Expected processedOutputs to be non-empty'
  );
  for (let i = 0; i < this.processedIDs.length; i++) {
    const expectedId = this.processedIDs[i];
    const output = this.processedOutputs[i];
    assert.ok(
      output,
      `Expected output for order "${expectedId}" to be non-null`
    );
    assert.strictEqual(
      output.orderId,
      expectedId,
      `Expected output.orderId to be "${expectedId}" but got "${output ? output.orderId : null}"`
    );
  }
});

Then('an AWS error is returned', function () {
  assert.ok(
    this.lastError,
    `Expected an AWS error to be returned but the call succeeded with output: ${JSON.stringify(this.lastOutput)}`
  );
});
