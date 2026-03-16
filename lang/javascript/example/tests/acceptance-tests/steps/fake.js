'use strict';

/**
 * Step definitions for fake response scenarios.
 */

const { Given } = require('@cucumber/cucumber');

Given('StartExecution is faked to return execution ARN {string}', async function (executionArn) {
  this.fakeExecutionArn = executionArn;
  const fake = this.fake('stepfunctions');
  await fake.operation('StartExecution').respond({
    status: 200,
    body: {
      executionArn,
      startDate: 1704067200.0,
    },
  });
});

Given('DescribeExecution is faked to return SUCCEEDED with output containing order ID {string}', async function (orderId) {
  const executionArn = this.fakeExecutionArn ||
    'arn:aws:states:us-east-1:000000000000:execution:OrderProcessor:fake-exec';
  const fake = this.fake('stepfunctions');
  await fake.operation('DescribeExecution').respond({
    status: 200,
    body: {
      executionArn,
      stateMachineArn: 'arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor',
      name: 'fake-exec',
      status: 'SUCCEEDED',
      startDate: 1704067200.0,
      output: JSON.stringify({ orderId }),
    },
  });
});

Given('StartExecution is faked to return error {string}', async function (errorCode) {
  const fake = this.fake('stepfunctions');
  await fake.operation('StartExecution').error(errorCode, `Simulated ${errorCode}`, 400);
});

Given('StartExecution is faked with a 10ms delay returning execution ARN {string}', async function (executionArn) {
  this.fakeExecutionArn = executionArn;
  const fake = this.fake('stepfunctions');
  await fake.operation('StartExecution').respond({
    status: 200,
    delayMs: 10,
    body: {
      executionArn,
      startDate: 1704067200.0,
    },
  });
});
