'use strict';

/**
 * Step definitions for chaos injection scenarios.
 */

const { Given } = require('@cucumber/cucumber');

Given('stepfunctions chaos is set to 100% error rate', async function () {
  const chaos = this.chaos('stepfunctions');
  chaos.errorRate(1.0);
  await chaos.apply();
});
