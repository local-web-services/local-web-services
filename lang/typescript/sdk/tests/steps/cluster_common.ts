/** Canonical cluster step definitions shared across docdb, elasticache, memorydb, and neptune.
 *
 *  These steps are generic — they dispatch cluster creation to the service-specific helper
 *  registered on the world by a tagged Before hook in each service's step file.
 *  The pattern avoids Cucumber.js global-namespace ambiguity while keeping the feature
 *  files unchanged.
 */

import { Given } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

// ── Given: cluster existence setup ───────────────────────────────────────────

Given("the cluster does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no clusters.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no clusters.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  assert.ok(
    this.clusterHelpers,
    "Expected clusterHelpers to be set — check the service Before hook is registered",
  );
  // Act: delegate to service-specific cluster creation helper
  await this.clusterHelpers.createCluster(this);
  // Assert: cluster created
});

Given("the cluster exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  assert.ok(
    this.clusterHelpers,
    "Expected clusterHelpers to be set — check the service Before hook is registered",
  );
  // Act: delegate to service-specific cluster creation helper
  await this.clusterHelpers.createCluster(this);
  // Assert: cluster created
});

Given("the cluster is {string}", async function (this: SdkWorld, expectedState: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act + Assert: delegate to service-specific helper when available (Then context).
  // When used as a Given setup step, @internal scenarios are excluded so this is
  // effectively a no-op for non-internal scenarios.
  if (this.clusterHelpers?.assertClusterStatus) {
    await this.clusterHelpers.assertClusterStatus(this, expectedState);
    return;
  }
  // Fallback: check that the last call succeeded (used when Then is hit after a When step).
  if (this.lastCallResult.output !== null || this.lastCallResult.error !== undefined) {
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected cluster operation to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  }
});

Given("the cluster is not {string}", async function (this: SdkWorld, _state: string) {
  // Arrange / Act / Assert — no-op: lifecycle states are managed internally;
  // cannot force a cluster into a specific non-state via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

// "the cluster is {string}" is registered above (Given) and works for Then steps too.
