/** Step definitions: capacity_management */

import { Given } from "@cucumber/cucumber";
import type { SdkWorld } from "../support/world";

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
  // @internal: Cannot observe in-progress invocation state via public API in lws.
  if (!this.session) throw new Error("No session running");
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
