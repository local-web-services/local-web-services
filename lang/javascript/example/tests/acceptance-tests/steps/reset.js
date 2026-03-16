'use strict';

/**
 * Step definitions for session reset scenarios.
 */

const { When, Then } = require('@cucumber/cucumber');

When('I reset the session', async function () {
  const res = await this.managementFetch('/_ldk/reset', { method: 'POST' });
  if (!res.ok) {
    // Some implementations may return 204 or 200; accept both.
    const text = await res.text().catch(() => '');
    if (res.status !== 204 && res.status !== 200) {
      throw new Error(`/_ldk/reset returned status ${res.status}: ${text}`);
    }
  }
});

Then('the session accepts a second reset without error', async function () {
  const res = await this.managementFetch('/_ldk/reset', { method: 'POST' });
  // Accept any 2xx status as success.
  if (res.status >= 300) {
    const text = await res.text().catch(() => '');
    throw new Error(`Second /_ldk/reset returned status ${res.status}: ${text}`);
  }
});
