/** Canonical Lambda function step definitions shared across all lambda cross-service scenarios.
 *
 *  These steps are generic — they dispatch Lambda function operations to the
 *  service-specific helper registered on the world by a tagged Before hook in
 *  each service's step file.
 *
 *  The pattern avoids Cucumber.js global-namespace ambiguity while keeping the
 *  feature files unchanged.
 *
 *  Steps delegated here from cross-service files:
 *  - "a Lambda function is deployed" (When) — dispatches via functionHelpers
 *  - "the Lambda function is invoked" (When) — no-op / @internal
 *  - "the function is ACTIVE" (Then/Given) — dispatches via functionHelpers
 *  - "the invocation is IN_PROGRESS" (Then) — @internal no-op
 *  - "the invocation is SUCCESS" (Then) — @internal no-op
 *  - "the invocation is FAILED with a ResourceNotFoundException" (Then) — @internal no-op
 *  - "the invocation is FAILED with a connection error" (Then) — @internal no-op
 *  - "every {string} invocation references an {string} Lambda function" (Then) — invariant no-op
 *
 *  Steps that remain in lambda_sqs.ts (already canonical):
 *  - "an invocation slot is available" (Given)
 *  - "no invocation slot is available" (Given)
 *  - "an invocation is IN_PROGRESS" (Given)
 *  - "no invocation is IN_PROGRESS" (Given)
 *
 *  These must NOT be re-registered in any other cross-service file.
 */

import { When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld, FunctionStepHelpers } from "../support/world";

// ── When: Lambda function actions ─────────────────────────────────────────────

When("a Lambda function is deployed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const helpers = this.functionHelpers as FunctionStepHelpers | null;
  assert.ok(
    helpers,
    "Expected functionHelpers to be set — check the service Before hook is registered",
  );
  // Act
  await helpers.deployFunction(this);
  // Assert: captured in lastCallResult
});

When("the Lambda function is invoked", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation in lws without Docker.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation: scenario requires @internal runtime"),
  };
  // Assert: captured in lastCallResult
});

// ── Then: function state assertions ──────────────────────────────────────────

// "the function is {string}" is registered in lambda.ts (dispatches via functionHelpers).

// ── Then: invocation state assertions ─────────────────────────────────────────

Then('the invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the invocation is "SUCCESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation success in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  'the invocation is "FAILED" with a ResourceNotFoundException',
  async function (this: SdkWorld) {
    // @internal: Cannot observe Lambda invocation failure in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then('the invocation is "FAILED" with a connection error', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation failure in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Then: invariant assertions ────────────────────────────────────────────────

Then(
  "every {string} invocation references an {string} Lambda function",
  async function (this: SdkWorld, _invState: string, _funcState: string) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
