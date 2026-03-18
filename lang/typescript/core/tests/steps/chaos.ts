/** Chaos step definitions. */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import * as cli from "../../src/cli";
import type { LwsWorld } from "../support/world";

// --- Given -----------------------------------------------------------------

Given("chaos was enabled for {string}", async function (this: LwsWorld, service: string) {
  await cli.chaosEnable(this.managementPort, service);
});

Given(
  "chaos was configured for {string} with full error rate",
  async function (this: LwsWorld, service: string) {
    await cli.chaosSet(this.managementPort, service, { errorRate: 1.0 });
  },
);

Given(
  "chaos was configured for {string} with 200ms latency",
  async function (this: LwsWorld, service: string) {
    await cli.chaosSet(this.managementPort, service, { latencyMin: 200, latencyMax: 200 });
  },
);

Given("chaos was cleaned up for {string}", async function (this: LwsWorld, service: string) {
  await cli.chaosDisable(this.managementPort, service);
});

// --- When ------------------------------------------------------------------

When("I enable chaos for {string}", async function (this: LwsWorld, service: string) {
  try {
    await cli.chaosEnable(this.managementPort, service);
    this.lastResult = { success: true, output: { status: "enabled" } };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I disable chaos for {string}", async function (this: LwsWorld, service: string) {
  try {
    await cli.chaosDisable(this.managementPort, service);
    this.lastResult = { success: true, output: { status: "disabled" } };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "I set chaos for {string} with error rate {float}",
  async function (this: LwsWorld, service: string, errorRate: number) {
    try {
      await cli.chaosSet(this.managementPort, service, { errorRate });
      this.lastResult = { success: true, output: { status: "configured", errorRate } };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I set chaos for {string} with latency min {int} and max {int}",
  async function (this: LwsWorld, service: string, latencyMin: number, latencyMax: number) {
    try {
      await cli.chaosSet(this.managementPort, service, { latencyMin, latencyMax });
      this.lastResult = { success: true, output: { status: "configured", latencyMin, latencyMax } };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When("I request chaos status", async function (this: LwsWorld) {
  try {
    const result = await cli.chaosStatus(this.managementPort);
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// --- Then ------------------------------------------------------------------

Then("chaos for {string} will be enabled", async function (this: LwsWorld, service: string) {
  const status = (await cli.chaosStatus(this.managementPort)) as Record<
    string,
    { enabled: boolean }
  >;
  assert.ok(
    status[service]?.enabled === true,
    `Expected chaos to be enabled for ${service}, got: ${JSON.stringify(status[service])}`,
  );
});

Then("chaos for {string} will be disabled", async function (this: LwsWorld, service: string) {
  const status = (await cli.chaosStatus(this.managementPort)) as Record<
    string,
    { enabled: boolean }
  >;
  assert.ok(
    status[service]?.enabled === false,
    `Expected chaos to be disabled for ${service}, got: ${JSON.stringify(status[service])}`,
  );
});

Then(
  "chaos for {string} will have error rate {float}",
  async function (this: LwsWorld, service: string, expectedErrorRate: number) {
    const status = (await cli.chaosStatus(this.managementPort)) as Record<
      string,
      { error_rate: number }
    >;
    const actual = status[service]?.error_rate;
    assert.strictEqual(
      actual,
      expectedErrorRate,
      `Expected error_rate ${expectedErrorRate} for ${service}, got ${actual}`,
    );
  },
);

Then(
  "chaos for {string} will have latency min {int}",
  async function (this: LwsWorld, service: string, expectedMin: number) {
    const status = (await cli.chaosStatus(this.managementPort)) as Record<
      string,
      { latency_min_ms: number }
    >;
    const actual = status[service]?.latency_min_ms;
    assert.strictEqual(
      actual,
      expectedMin,
      `Expected latency_min_ms ${expectedMin} for ${service}, got ${actual}`,
    );
  },
);

Then(
  "chaos for {string} will have latency max {int}",
  async function (this: LwsWorld, service: string, expectedMax: number) {
    const status = (await cli.chaosStatus(this.managementPort)) as Record<
      string,
      { latency_max_ms: number }
    >;
    const actual = status[service]?.latency_max_ms;
    assert.strictEqual(
      actual,
      expectedMax,
      `Expected latency_max_ms ${expectedMax} for ${service}, got ${actual}`,
    );
  },
);

Then(
  "the chaos status will contain {string}",
  async function (this: LwsWorld, serviceName: string) {
    const status = (await cli.chaosStatus(this.managementPort)) as Record<string, unknown>;
    assert.ok(
      serviceName in status,
      `Expected chaos status to contain "${serviceName}", got keys: ${Object.keys(status).join(", ")}`,
    );
  },
);
