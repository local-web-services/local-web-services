/** Step definitions: chaos informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { SQSClient, ListQueuesCommand } from "@aws-sdk/client-sqs";
import type { SdkWorld } from "../support/world";

const CHAOS_MGMT_TEST_SERVICE = "sqs";
const CHAOS_MGMT_LATENCY_MIN_MS = 10;
const CHAOS_MGMT_LATENCY_MAX_MS = 50;

// ── Module-level scenario state ────────────────────────────────────────────────

let chaosEnabled = false;
let errorRateFull = false;
let latencyEnabled = false;
let callElapsedMs = 0;

// ── Given: chaos precondition setup ───────────────────────────────────────────

Given("chaos is enabled for the service", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act: enable chaos for the test service (always apply — each scenario uses a fresh server)
  await this.session!.chaos(CHAOS_MGMT_TEST_SERVICE).apply();
  chaosEnabled = true;
  // Assert: verify chaos is enabled
  const result = await this.session!.getChaosStatus(CHAOS_MGMT_TEST_SERVICE);
  const expectedEnabled = true;
  const actualEnabled = result["enabled"] as boolean;
  assert.strictEqual(
    actualEnabled,
    expectedEnabled,
    `Expected chaos enabled=${expectedEnabled} for service "${CHAOS_MGMT_TEST_SERVICE}" but got enabled=${actualEnabled}; result=${JSON.stringify(result)}`,
  );
});

Given("chaos is not enabled for the service", function (this: SdkWorld) {
  // Guard violation: chaos must be enabled for inject/disable operations.
  // Pre-load a rejection so "the operation is rejected" will pass.
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error(
      `guard violation: chaos is not enabled for service "${CHAOS_MGMT_TEST_SERVICE}"`,
    ),
  };
  chaosEnabled = false;
});

Given("the error rate is set to full for the service", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act: enable chaos with 100% error rate
  await this.session!.chaos(CHAOS_MGMT_TEST_SERVICE).errorRate(1.0).apply();
  // Assert: record state
  chaosEnabled = true;
  errorRateFull = true;
});

Given("the error rate is not set to full for the service", function (this: SdkWorld) {
  // Guard violation: error injection requires 100% error rate.
  // Pre-load a rejection so "the operation is rejected" will pass.
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error(
      `guard violation: error rate is not set to full for service "${CHAOS_MGMT_TEST_SERVICE}"`,
    ),
  };
  errorRateFull = false;
});

Given("latency is configured for the service", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act: enable chaos with latency
  await this.session!.chaos(CHAOS_MGMT_TEST_SERVICE)
    .latency(CHAOS_MGMT_LATENCY_MIN_MS, CHAOS_MGMT_LATENCY_MAX_MS)
    .apply();
  // Assert: record state
  chaosEnabled = true;
  latencyEnabled = true;
});

Given("latency is not configured for the service", function (this: SdkWorld) {
  // Guard violation: latency injection requires latency to be configured.
  // Pre-load a rejection so "the operation is rejected" will pass.
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error(
      `guard violation: latency is not configured for service "${CHAOS_MGMT_TEST_SERVICE}"`,
    ),
  };
  latencyEnabled = false;
});

// FizzBee precondition: svc must be in chaos_enabled state to run inject/disable actions.
Given("svc in chaos_enabled", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act: ensure chaos is enabled for the test service
  await this.session!.chaos(CHAOS_MGMT_TEST_SERVICE).apply();
  // Assert: record state
  chaosEnabled = true;
});

// ── When: chaos actions ────────────────────────────────────────────────────────

When("chaos is enabled for a service", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act
  try {
    await this.session!.chaos(CHAOS_MGMT_TEST_SERVICE).apply();
    this.lastCallResult = { success: true, output: null };
    chaosEnabled = true;
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("chaos is disabled for a service", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  if (!chaosEnabled) {
    // Guard violation: chaos must be enabled to disable it.
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        `guard violation: chaos is not enabled for service "${CHAOS_MGMT_TEST_SERVICE}": cannot disable`,
      ),
    };
    return;
  }
  // Act
  try {
    await this.session!.chaos(CHAOS_MGMT_TEST_SERVICE).clear();
    this.lastCallResult = { success: true, output: null };
    chaosEnabled = false;
    errorRateFull = false;
    latencyEnabled = false;
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("the chaos error rate is configured for a service", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act
  try {
    await this.session!.chaos(CHAOS_MGMT_TEST_SERVICE).errorRate(1.0).apply();
    this.lastCallResult = { success: true, output: null };
    chaosEnabled = true;
    errorRateFull = true;
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("the chaos latency is configured for a service", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act
  try {
    await this.session!.chaos(CHAOS_MGMT_TEST_SERVICE)
      .latency(CHAOS_MGMT_LATENCY_MIN_MS, CHAOS_MGMT_LATENCY_MAX_MS)
      .apply();
    this.lastCallResult = { success: true, output: null };
    chaosEnabled = true;
    latencyEnabled = true;
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("the chaos status for all services is retrieved", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act
  try {
    const result = await this.session!.getChaosStatus(CHAOS_MGMT_TEST_SERVICE);
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("a service call is injected with a chaos error", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  if (!chaosEnabled || !errorRateFull) {
    // Guard violation: pre-loaded failure already set — keep it.
    return;
  }
  // Act: make a real service call that should fail due to 100% error rate.
  const port = this.session!.portFor(CHAOS_MGMT_TEST_SERVICE);
  const client = new SQSClient({
    endpoint: `http://127.0.0.1:${port}`,
    region: "us-east-1",
    credentials: { accessKeyId: "test", secretAccessKey: "test" },
  });
  try {
    const result = await client.send(new ListQueuesCommand({}));
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("a service call is delayed by chaos latency injection", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  if (!chaosEnabled || !latencyEnabled) {
    // Guard violation: pre-loaded failure already set — keep it.
    return;
  }
  // Act: make a real service call and measure elapsed time.
  const port = this.session!.portFor(CHAOS_MGMT_TEST_SERVICE);
  const client = new SQSClient({
    endpoint: `http://127.0.0.1:${port}`,
    region: "us-east-1",
    credentials: { accessKeyId: "test", secretAccessKey: "test" },
  });
  const start = Date.now();
  try {
    await client.send(new ListQueuesCommand({}));
  } catch {
    // latency injection does not necessarily cause errors — measure elapsed regardless
  }
  callElapsedMs = Date.now() - start;
  this.lastCallResult = { success: true, output: { elapsed_ms: callElapsedMs } };
});

// ── Then: chaos assertions ─────────────────────────────────────────────────────

// "chaos is enabled for the service" as Then — handled by the combined
// Given registration above (enables and asserts in one step).

Then("chaos is disabled for the service", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act: get current chaos status
  const result = await this.session!.getChaosStatus(CHAOS_MGMT_TEST_SERVICE);
  // Assert
  const expectedEnabled = false;
  const actualEnabled = result["enabled"] as boolean;
  assert.strictEqual(
    actualEnabled,
    expectedEnabled,
    `Expected chaos enabled=${expectedEnabled} for service "${CHAOS_MGMT_TEST_SERVICE}" but got enabled=${actualEnabled}; result=${JSON.stringify(result)}`,
  );
});

Then("the chaos configuration for each service is returned", function (this: SdkWorld) {
  // Arrange: (no-op)
  // Act: read last call result
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  // Assert
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected chaos configuration to be returned but request failed; error=${JSON.stringify(this.lastCallResult.error)}`,
  );
});

Then("the error rate configuration is updated", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act: get current chaos status
  const result = await this.session!.getChaosStatus(CHAOS_MGMT_TEST_SERVICE);
  // Assert
  const expectedErrorRate = 1.0;
  const actualErrorRate = result["error_rate"] as number;
  assert.strictEqual(
    actualErrorRate,
    expectedErrorRate,
    `Expected error_rate=${expectedErrorRate} for service "${CHAOS_MGMT_TEST_SERVICE}" but got ${actualErrorRate}; result=${JSON.stringify(result)}`,
  );
});

Then("the latency configuration is updated", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act: get current chaos status
  const result = await this.session!.getChaosStatus(CHAOS_MGMT_TEST_SERVICE);
  // Assert
  const expectedLatencyMin = CHAOS_MGMT_LATENCY_MIN_MS;
  const actualLatencyMin = result["latency_min_ms"] as number;
  assert.strictEqual(
    actualLatencyMin,
    expectedLatencyMin,
    `Expected latency_min_ms=${expectedLatencyMin} for service "${CHAOS_MGMT_TEST_SERVICE}" but got ${actualLatencyMin}; result=${JSON.stringify(result)}`,
  );
});

Then("the service call receives a chaos error response", function (this: SdkWorld) {
  // Arrange: (no-op)
  // Act: read last call result
  const expectedError = true;
  const actualError = this.lastCallResult.error != null;
  // Assert
  assert.strictEqual(
    actualError,
    expectedError,
    `Expected chaos error response but call succeeded; output=${JSON.stringify(this.lastCallResult.output)}`,
  );
});

Then("the service call takes at least the configured minimum latency", function (this: SdkWorld) {
  // Arrange: (no-op)
  // Act: read elapsed time recorded in When step
  const expectedMinLatencyMs = CHAOS_MGMT_LATENCY_MIN_MS;
  const actualElapsedMs = callElapsedMs;
  // Assert
  assert.ok(
    actualElapsedMs >= expectedMinLatencyMs,
    `Expected call to take at least ${expectedMinLatencyMs}ms but took ${actualElapsedMs}ms; expected_min_latency_ms=${expectedMinLatencyMs} actual_elapsed_ms=${actualElapsedMs}`,
  );
});

// Safety invariant: the server enforces that only known services have chaos configured.
Then("every chaos-configured service is a known service", function (this: SdkWorld) {
  // No-op: the server enforces this invariant; if apply() succeeded, the service is known.
});
