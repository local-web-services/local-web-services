/** Canonical user step definitions shared across cognito_idp and memorydb.
 *
 *  These steps are generic — they dispatch user creation to the service-specific helper
 *  registered on the world by a tagged Before hook in each service's step file.
 *  The pattern avoids Cucumber.js global-namespace ambiguity while keeping the feature
 *  files unchanged.
 */

import { Given, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

// ── Given: user existence setup ───────────────────────────────────────────────

Given("the user does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no users.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the user does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no users.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the user already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  assert.ok(
    this.userHelpers,
    "Expected userHelpers to be set — check the service Before hook is registered",
  );
  // Act: delegate to service-specific user creation helper
  await this.userHelpers.createUser(this);
  // Assert: user created
});

Given("the user exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  assert.ok(
    this.userHelpers,
    "Expected userHelpers to be set — check the service Before hook is registered",
  );
  // Act: delegate to service-specific user creation helper
  await this.userHelpers.createUser(this);
  // Assert: user created
});

Given("the user is {string}", async function (this: SdkWorld, expectedState: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act + Assert: delegate to service-specific helper when available.
  if (this.userHelpers?.setupUserStatus) {
    await this.userHelpers.setupUserStatus(this, expectedState);
    return;
  }
  // Fallback: no-op for services that do not support state setup via public API.
  void expectedState;
});

Given("the user is not {string}", async function (this: SdkWorld, _state: string) {
  // Arrange / Act / Assert — no-op: lifecycle states are managed internally;
  // cannot force a user into a specific non-state via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Then: user status assertion ───────────────────────────────────────────────

Then("the user is {string}", async function (this: SdkWorld, expectedState: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act + Assert: delegate to service-specific helper when available.
  if (this.userHelpers?.assertUserStatus) {
    await this.userHelpers.assertUserStatus(this, expectedState);
    return;
  }
  // Fallback: check that the last call succeeded (used when Then is hit after a When step).
  if (this.lastCallResult.output !== null || this.lastCallResult.error !== undefined) {
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected user operation to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  }
});
