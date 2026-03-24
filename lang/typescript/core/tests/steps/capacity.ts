/** Capacity step definitions. */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import * as cli from "../../src/cli";
import type { LwsWorld } from "../support/world";

// --- Given -----------------------------------------------------------------

Given("capacity was exhausted for {string}", async function (this: LwsWorld, service: string) {
  await cli.capacityExhaust(this.managementPort, service);
});

Given("capacity was restored for {string}", async function (this: LwsWorld, service: string) {
  await cli.capacityUnlimited(this.managementPort, service);
});

// --- When ------------------------------------------------------------------

When("I exhaust capacity for {string}", async function (this: LwsWorld, service: string) {
  try {
    await cli.capacityExhaust(this.managementPort, service);
    this.lastResult = { success: true, output: { status: "exhausted" } };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I restore capacity for {string}", async function (this: LwsWorld, service: string) {
  try {
    await cli.capacityUnlimited(this.managementPort, service);
    this.lastResult = { success: true, output: { status: "unlimited" } };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I request capacity status", async function (this: LwsWorld) {
  try {
    const result = await cli.capacityStatus(this.managementPort);
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// --- Then ------------------------------------------------------------------

Then("capacity for {string} will be exhausted", async function (this: LwsWorld, service: string) {
  const status = (await cli.capacityStatus(this.managementPort)) as Record<
    string,
    { slots: number | null }
  >;
  const actualSlots = status[service]?.slots;
  assert.strictEqual(
    actualSlots,
    0,
    `Expected capacity slots to be 0 (exhausted) for ${service}, got: ${actualSlots}`,
  );
});

Then("capacity for {string} will be unlimited", async function (this: LwsWorld, service: string) {
  const status = (await cli.capacityStatus(this.managementPort)) as Record<
    string,
    { slots: number | null }
  >;
  const actualSlots = status[service]?.slots;
  assert.strictEqual(
    actualSlots,
    null,
    `Expected capacity slots to be null (unlimited) for ${service}, got: ${actualSlots}`,
  );
});

Then(
  "the capacity status will contain {string}",
  async function (this: LwsWorld, serviceName: string) {
    const status = (await cli.capacityStatus(this.managementPort)) as Record<string, unknown>;
    assert.ok(
      serviceName in status,
      `Expected capacity status to contain "${serviceName}", got keys: ${Object.keys(status).join(", ")}`,
    );
  },
);
