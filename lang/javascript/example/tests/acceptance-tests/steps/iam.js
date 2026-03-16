'use strict';

/**
 * Step definitions for IAM enforce mode scenarios.
 */

const { Given } = require('@cucumber/cucumber');

Given('IAM is in enforce mode with identity {string} allowed all actions on all resources', async function (identityName) {
  const iam = this.iam;
  iam.mode('enforce').defaultIdentity(identityName);
  iam.identity(identityName).allow('*', '*').apply();
  await iam.apply();
});
