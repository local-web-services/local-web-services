import { Given, When, Then } from '@cucumber/cucumber';
import * as assert from 'assert';
import { processOrder } from '../../../src/orderProcessor';
import { OrderWorld } from '../support/world';

Given('log capture is active', async function (this: OrderWorld) {
  this.logCapture = await this.session!.captureLogsStart();
});

Then('the log capture will have recorded a {string} {string} call', function (this: OrderWorld, service: string, operation: string) {
  this.logCapture!.assertCalled(service, operation);
});

Then('no errors will appear in the log capture', function (this: OrderWorld) {
  this.logCapture!.assertNoErrors();
});

Then('recent logs will be non-empty', async function (this: OrderWorld) {
  const port = (this.session as any)._basePort;
  const resp = await fetch(`http://127.0.0.1:${port}/_ldk/logs`);
  const data = await resp.json() as { logs: unknown[] };
  assert.ok(data.logs.length > 0, 'Expected non-empty logs');
});

When('I start log capture and process order {string}', async function (this: OrderWorld, orderId: string) {
  this.logCapture = await this.session!.captureLogsStart();
  await processOrder(orderId, this.stateMachineArn, this.sfnClient!);
});

Then('filtering logs by service {string} will return entries', function (this: OrderWorld, service: string) {
  const entries = this.logCapture!.forService(service);
  assert.ok(entries.length > 0, `Expected log entries for service "${service}" but found none`);
});

Then('filtering logs by operation {string} will return entries', function (this: OrderWorld, operation: string) {
  const entries = this.logCapture!.forOperation(operation);
  assert.ok(entries.length > 0, `Expected log entries for operation "${operation}" but found none`);
});
