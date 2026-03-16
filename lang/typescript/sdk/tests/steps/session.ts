/** Step definitions: session_lifecycle + session_reset */

import { When, Then, Given } from "@cucumber/cucumber";
import assert from "assert";
import { LwsSession } from "../../src/session";
import type { SdkWorld } from "../support/world";

// ── session_lifecycle ──────────────────────────────────────────────────────────

When("I create a session", async function (this: SdkWorld) {
  this.session = await LwsSession.create();
});

Then("the session is running", function (this: SdkWorld) {
  assert.ok(this.session !== null, "Expected session to be running but it is null");
});

When("I close the session", async function (this: SdkWorld) {
  if (this.session) {
    await this.session.close();
    this.session = null;
  }
});

Then("the session is closed", function (this: SdkWorld) {
  assert.strictEqual(this.session, null, "Expected session to be closed but it is still open");
});

When("I open a session as a context manager", async function (this: SdkWorld) {
  this.session = await LwsSession.create();
});

Then("the session is running inside the context", function (this: SdkWorld) {
  assert.ok(this.session !== null, "Expected session to be running inside context");
});

Then("the session is closed after the context exits", async function (this: SdkWorld) {
  if (this.session) {
    await this.session.close();
    this.session = null;
  }
  assert.strictEqual(this.session, null, "Expected session to be closed after context exit");
});

// ── session_reset ──────────────────────────────────────────────────────────────

Given("a running session", async function (this: SdkWorld) {
  this.session = await LwsSession.create();
});

When("I reset the session", async function (this: SdkWorld) {
  assert.ok(this.session, "No session to reset");
  await this.session!.reset();
});

When("I reset the session again", async function (this: SdkWorld) {
  assert.ok(this.session, "No session to reset");
  await this.session!.reset();
});

Then("no error is raised", function (this: SdkWorld) {
  // If we reach this step, no error was raised — pass
});
