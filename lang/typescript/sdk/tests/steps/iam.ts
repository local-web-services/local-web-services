/** Step definitions: iam_enforce */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { LwsSession } from "../../src/session";
import type { SdkWorld } from "../support/world";

// ── Compound Given ─────────────────────────────────────────────────────────────

Given("a running session with IAM enforce mode active", async function (this: SdkWorld) {
  this.session = await LwsSession.create();
  await this.session.iam
    .mode("enforce")
    .defaultIdentity("test-user")
    .identity("test-user")
    .allow(["states:*"])
    .apply()
    .apply();
});

// ── IAM configuration ──────────────────────────────────────────────────────────

Given(
  "IAM is in enforce mode with identity {string} allowed all {string} actions",
  async function (this: SdkWorld, identityName: string, actionPattern: string) {
    assert.ok(this.session, "No session");
    await this.session!.iam.mode("enforce")
      .defaultIdentity(identityName)
      .identity(identityName)
      .allow([actionPattern])
      .apply()
      .apply();
  },
);

Given(
  "IAM is in enforce mode with identity {string} and no permissions",
  async function (this: SdkWorld, identityName: string) {
    assert.ok(this.session, "No session");
    await this.session!.iam.mode("enforce").defaultIdentity(identityName).apply();
  },
);

When("I set IAM mode to {string}", async function (this: SdkWorld, mode: string) {
  assert.ok(this.session, "No session");
  await this.session!.iam.mode(mode as "enforce" | "audit" | "disabled").apply();
});

// ── Assertions ─────────────────────────────────────────────────────────────────

Then("an IAM access denied error is returned", function (this: SdkWorld) {
  assert.strictEqual(
    this.lastCallResult.success,
    false,
    `Expected IAM access denied but the call succeeded with: ${JSON.stringify(
      this.lastCallResult.output,
    )}`,
  );
  const errStr = JSON.stringify(this.lastCallResult.error);
  const hasAccessDenied =
    errStr.includes("AccessDenied") ||
    errStr.includes("NotAuthorizedException") ||
    errStr.includes("403") ||
    errStr.includes("access denied");
  assert.ok(hasAccessDenied, `Expected an IAM access denied error but got: ${errStr}`);
});
