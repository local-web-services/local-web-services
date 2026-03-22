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

Given("no invocation slot is available", async function (this: SdkWorld) {
  if (!this.session) throw new Error("No session running");
  await this.session.capacity("lambda").exhaust().apply();
});

Given("no request slot is available", async function (this: SdkWorld) {
  if (!this.session) throw new Error("No session running");
  await this.session.capacity("apigateway").exhaust().apply();
});

Given("a request slot is available", async function (this: SdkWorld) {
  if (!this.session) throw new Error("No session running");
  await this.session.capacity("apigateway").unlimited().apply();
});
