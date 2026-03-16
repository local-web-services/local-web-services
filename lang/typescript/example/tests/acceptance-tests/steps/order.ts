import { Given, When, Then } from '@cucumber/cucumber';
import * as assert from 'assert';
import { processOrder } from '../../../src/orderProcessor';
import { OrderWorld } from '../support/world';

When('I process order {string}', async function (this: OrderWorld, orderId: string) {
  this.lastError = null;
  this.lastOutput = null;
  try {
    this.lastOutput = await processOrder(orderId, this.stateMachineArn, this.sfnClient!);
  } catch (e) {
    this.lastError = e as Error;
  }
});

When('I process order {string} via ARN {string}', async function (this: OrderWorld, orderId: string, arn: string) {
  this.lastError = null;
  this.lastOutput = null;
  try {
    this.lastOutput = await processOrder(orderId, arn, this.sfnClient!);
  } catch (e) {
    this.lastError = e as Error;
  }
});

When('I process orders {string}, {string}, {string}', async function (this: OrderWorld, id1: string, id2: string, id3: string) {
  this.processedOutputs = [];
  this.processedIDs = [id1, id2, id3];
  for (const orderId of this.processedIDs) {
    const output = await processOrder(orderId, this.stateMachineArn, this.sfnClient!);
    this.processedOutputs.push(output);
  }
});

Given('order {string} has been processed', async function (this: OrderWorld, orderId: string) {
  await processOrder(orderId, this.stateMachineArn, this.sfnClient!);
});

Then('the output will contain order ID {string}', function (this: OrderWorld, expectedOrderId: string) {
  assert.ok(this.lastError == null, `Expected no error but got: ${this.lastError}`);
  assert.strictEqual(this.lastOutput!.orderId, expectedOrderId);
});

Then('each output will contain the corresponding order ID', function (this: OrderWorld) {
  assert.strictEqual(this.processedOutputs.length, this.processedIDs.length);
  for (let i = 0; i < this.processedIDs.length; i++) {
    assert.strictEqual(this.processedOutputs[i].orderId, this.processedIDs[i]);
  }
});

Then('an AWS error is returned', function (this: OrderWorld) {
  assert.ok(this.lastError != null, 'Expected an error but none was thrown');
});
