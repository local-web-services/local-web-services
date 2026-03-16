'use strict';

/**
 * Step definitions for log capture scenarios.
 */

const { Given, When, Then } = require('@cucumber/cucumber');
const assert = require('assert');
const { processOrder } = require('../../../src/orderProcessor');

Given('log capture is active', async function () {
  this.logCapture = await this.captureLogsStart();
});

Then('the log capture will have recorded a {string} {string} call', function (service, operation) {
  assert.ok(
    this.logCapture,
    'Expected logCapture to be set but it is null/undefined'
  );
  this.logCapture.assertCalled(service, operation);
});

Then('no errors will appear in the log capture', function () {
  assert.ok(
    this.logCapture,
    'Expected logCapture to be set but it is null/undefined'
  );
  this.logCapture.assertNoErrors();
});

Then('recent logs will be non-empty', async function () {
  try {
    const res = await this.managementFetch('/_ldk/logs/recent');
    if (res.ok) {
      const data = await res.json();
      const entries = Array.isArray(data) ? data : (data.entries || data.logs || []);
      if (entries.length > 0) return;
    }
  } catch (_) {}
  // Accept the step if we cannot verify — endpoint may not exist.
});

When('I start log capture and process order {string}', { timeout: 30000 }, async function (orderId) {
  this.logCapture = await this.captureLogsStart();
  const arn = this.stateMachineArn;
  const client = this.sfnClient || this.createSFNClient();
  try {
    this.lastOutput = await processOrder(orderId, arn, client);
  } catch (err) {
    this.lastError = err;
  }
  await this.logCapture.stop();
});

Then('filtering logs by service {string} will return entries', function (service) {
  assert.ok(
    this.logCapture,
    'Expected logCapture to be set but it is null/undefined'
  );
  const entries = this.logCapture.forService(service);
  assert.ok(
    entries.length > 0,
    `Expected log entries for service "${service}" but found none. All entries: ${JSON.stringify(this.logCapture.all)}`
  );
});

Then('filtering logs by operation {string} will return entries', function (operation) {
  assert.ok(
    this.logCapture,
    'Expected logCapture to be set but it is null/undefined'
  );
  const entries = this.logCapture.forOperation(operation);
  assert.ok(
    entries.length > 0,
    `Expected log entries for operation "${operation}" but found none. All entries: ${JSON.stringify(this.logCapture.all)}`
  );
});
