/** Step definitions: capacity_management */

import { Given } from "@cucumber/cucumber";
import type { SdkWorld, FunctionStepHelpers } from "../support/world";

// ── Capacity setup steps ───────────────────────────────────────────────────────

Given("the execution slot is not available", async function (this: SdkWorld) {
  if (!this.session) throw new Error("No session running");
  await this.session.capacity("stepfunctions").exhaust().apply();
});

Given("no item slot is available", async function (this: SdkWorld) {
  if (!this.session) throw new Error("No session running");
  (this as any)._noItemSlot = true;
  await this.session.capacity("dynamodb").exhaust().apply();
});

Given("an invocation slot is available", async function (this: SdkWorld) {
  if (!this.session) throw new Error("No session running");
  await this.session.capacity("lambda").unlimited().apply();
});

Given("no invocation slot is available", async function (this: SdkWorld) {
  if (!this.session) throw new Error("No session running");
  await this.session.capacity("lambda").exhaust().apply();
});

Given('an invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange: create the function if functionHelpers is set (cross-service scenarios)
  if (!this.session) throw new Error("No session running");
  const helpers = this.functionHelpers as FunctionStepHelpers | null;
  if (helpers) {
    try {
      await helpers.deployFunction(this);
    } catch {
      // function may already exist; desired state is presence
    }
    // Clear lastCallResult so this Given step doesn't affect When/Then
    this.lastCallResult = { success: false, output: null };
  }
});

Given('no invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no in-progress invocations.
  if (!this.session) throw new Error("No session running");
});

Given("no request slot is available", async function (this: SdkWorld) {
  if (!this.session) throw new Error("No session running");
  await this.session.capacity("apigateway").exhaust().apply();
});

Given("a request slot is available", async function (this: SdkWorld) {
  if (!this.session) throw new Error("No session running");
  await this.session.capacity("apigateway").unlimited().apply();
});
