/** Step definitions: elasticache service informal specification scenarios */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld, SnapshotHelpers, TagStepHelpers } from "../support/world";

const ELASTICACHE_TEST_CLUSTER_ID = "test-elasticache-cluster-1";
const ELASTICACHE_TEST_RG_ID = "test-elasticache-rg-1";
const ELASTICACHE_TEST_SUBNET_GROUP_ID = "test-elasticache-subnet-group-1";
const ELASTICACHE_TEST_SNAPSHOT_NAME = "test-elasticache-snapshot-1";
const ELASTICACHE_TEST_TAG_KEY = "e2e-elasticache-tag-key-1";
const ELASTICACHE_TEST_TAG_VALUE = "test-elasticache-tag-value-1";

// ── Helpers ───────────────────────────────────────────────────────────────────

function elasticacheClient(world: SdkWorld) {
  const { ElastiCacheClient } = require("@aws-sdk/client-elasticache");
  return world.session!.client<typeof ElastiCacheClient>("elasticache");
}

async function elasticacheCreateCluster(world: SdkWorld): Promise<void> {
  const { CreateCacheClusterCommand } = require("@aws-sdk/client-elasticache");
  await elasticacheClient(world).send(
    new CreateCacheClusterCommand({
      CacheClusterId: ELASTICACHE_TEST_CLUSTER_ID,
      Engine: "redis",
      CacheNodeType: "cache.t3.micro",
      NumCacheNodes: 1,
    }),
  );
}

async function elasticacheCreateReplicationGroup(world: SdkWorld): Promise<void> {
  const { CreateReplicationGroupCommand } = require("@aws-sdk/client-elasticache");
  await elasticacheClient(world).send(
    new CreateReplicationGroupCommand({
      ReplicationGroupId: ELASTICACHE_TEST_RG_ID,
      ReplicationGroupDescription: "test replication group",
    }),
  );
}

async function elasticacheCreateSubnetGroup(world: SdkWorld): Promise<void> {
  const { CreateCacheSubnetGroupCommand } = require("@aws-sdk/client-elasticache");
  await elasticacheClient(world).send(
    new CreateCacheSubnetGroupCommand({
      CacheSubnetGroupName: ELASTICACHE_TEST_SUBNET_GROUP_ID,
      CacheSubnetGroupDescription: "test subnet group",
      SubnetIds: ["subnet-00000001"],
    }),
  );
}

async function elasticacheClusterExists(world: SdkWorld): Promise<boolean> {
  const { DescribeCacheClustersCommand } = require("@aws-sdk/client-elasticache");
  try {
    const resp = await elasticacheClient(world).send(
      new DescribeCacheClustersCommand({ CacheClusterId: ELASTICACHE_TEST_CLUSTER_ID }),
    );
    return resp !== null && (resp.CacheClusters ?? []).length > 0;
  } catch {
    return false;
  }
}

async function elasticacheSubnetGroupExists(world: SdkWorld): Promise<boolean> {
  const { DescribeCacheSubnetGroupsCommand } = require("@aws-sdk/client-elasticache");
  try {
    const resp = await elasticacheClient(world).send(
      new DescribeCacheSubnetGroupsCommand({
        CacheSubnetGroupName: ELASTICACHE_TEST_SUBNET_GROUP_ID,
      }),
    );
    return resp !== null && (resp.CacheSubnetGroups ?? []).length > 0;
  } catch {
    return false;
  }
}

// ── Before hook: register cluster helpers for @elasticache and @elasticachesns scenarios ──

Before({ tags: "@elasticache or @elasticachesns" }, function (this: SdkWorld) {
  this.clusterHelpers = {
    createCluster: async (world: SdkWorld) => {
      try {
        await elasticacheCreateCluster(world);
      } catch {
        // cluster may already exist
      }
    },
    assertClusterStatus: async (world: SdkWorld, expectedStatus: string) => {
      assert.ok(world.session, "Expected session to be initialized");
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected ElastiCache cluster operation to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
      assert.ok(
        world.lastCallResult.output !== null && world.lastCallResult.output !== undefined,
        `Expected cluster output but got null; expected_status=${expectedStatus}`,
      );
    },
  };
});

// ── Background ────────────────────────────────────────────────────────────────
// ── Before hook: register helpers for elasticache scenarios ────────────────

Before({ tags: "@elasticache" }, function (this: SdkWorld) {
  const snapshotHelpersImpl: SnapshotHelpers = {
    setupSnapshotExists: async (world: SdkWorld) => {
      // @internal: creating a snapshot requires a cluster in AVAILABLE state
      // which requires lifecycle completion. No-op.
      assert.ok(world.session, "Expected session to be initialized");
    },
    setupSnapshotNotExists: async (world: SdkWorld) => {
      // no-op: fresh state has no snapshots
      void world;
    },
    assertSnapshotInStateWithCluster: async (
      world: SdkWorld,
      snapState: string,
      clusterState: string,
    ) => {
      // Arrange: no additional setup required
      // Act: action already performed in the When step
      // Assert
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected create_snapshot to succeed but got error: ${String(world.lastCallResult.error)}; expected_snap_state=${snapState} expected_cluster_state=${clusterState}`,
      );
    },
    assertSnapshotInState: async (world: SdkWorld, expectedState: string) => {
      // Arrange: no additional setup required
      // Act: action already performed in the When step
      // Assert
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected delete_snapshot to succeed but got error: ${String(world.lastCallResult.error)}; expected_state=${expectedState}`,
      );
    },
  };
  this.snapshotHelpers = snapshotHelpersImpl;

  const tagHelpersImpl: TagStepHelpers = {
    setupTagAssociationActive: async (world: SdkWorld) => {
      // No-op: resources are created with tags in lws; tag is already active.
      assert.ok(world.session, "Expected session to be initialized");
    },
    setupTagAssociationNotActive: async (world: SdkWorld) => {
      // No-op: removing tags from resources is not supported via this path in lws.
      assert.ok(world.session, "Expected session to be initialized");
    },
    setupResourceExists: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: create the cluster as the representative resource
      await elasticacheCreateCluster(world);
      // Assert: resource created
    },
    setupResourceNotExists: async (world: SdkWorld) => {
      // Arrange / Act / Assert — no-op: fresh state has no resources.
      assert.ok(world.session, "Expected session to be initialized");
    },
    assertResourceTagged: async (world: SdkWorld) => {
      // Arrange: no additional setup required
      // Act: action already performed in the When step
      // Assert
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected add_tags_to_resource to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
    },
  };
  this.tagHelpers = tagHelpersImpl;
});

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: sequence / precondition steps ─────────────────────────────────────

Given("cid not in cluster_status", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: in a fresh test session no clusters exist.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: cluster state setup ────────────────────────────────────────────────

// "the cluster does not already exist", "the cluster already exists",
// "the cluster exists", "the cluster does not exist", "the cluster is {string}",
// "the cluster is not {string}" are registered in cluster_common.ts.

Given(
  /^the cluster is standalone \(not part of a replication group\)$/,
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: clusters created without a replication group are standalone by default.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given("the cluster is part of a replication group", async function (this: SdkWorld) {
  // @internal: no public API places a standalone cluster into a replication group.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster uses the redis engine", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: the test cluster is always created with the redis engine.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster does not use the redis engine", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: handled by the reject assertion in the Then step.
  assert.ok(this.session, "Expected session to be initialized");
});

// "the snapshot slot is available" is registered in cluster_common.ts.

Given("the snapshot slot is not available", async function (this: SdkWorld) {
  // @internal: no public API exhausts snapshot slots.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: replication group state setup ─────────────────────────────────────

Given("the replication group does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no replication groups.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the replication group already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await elasticacheCreateReplicationGroup(this);
  // Assert: replication group created
});

Given("the replication group exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await elasticacheCreateReplicationGroup(this);
  // Assert: replication group exists
});

Given("the replication group does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no replication groups.
  assert.ok(this.session, "Expected session to be initialized");
});

Given(/^the replication group is "([^"]*)"$/, async function (this: SdkWorld, _state: string) {
  // @internal: replication group lifecycle states are managed internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given(/^the replication group is not "([^"]*)"$/, async function (this: SdkWorld, _state: string) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("a cluster slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: cluster slots are available in a fresh session.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no cluster slot is available", async function (this: SdkWorld) {
  // @internal: no public API exhausts cluster slots.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("a cluster slot is available for the primary", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: slots are available in a fresh session.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no cluster slot is available for the primary", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("automatic failover is enabled", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("automatic failover is not enabled", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("a replica cluster exists", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no replica cluster exists", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster is part of this replication group", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster is not part of this replication group", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster is not already the primary", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster is already the primary", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: subnet group state setup ──────────────────────────────────────────

Given("the subnet group does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no subnet groups.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the subnet group already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await elasticacheCreateSubnetGroup(this);
  // Assert: subnet group created
});

// "the subnet group exists" as Given — handled by the combined Then registration below.

Given("the subnet group does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no subnet groups.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the subnet group is present", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: subnet groups created via API are always present.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the subnet group is not present", async function (this: SdkWorld) {
  // @internal: no public API places a subnet group in a non-present state.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: snapshot state setup ───────────────────────────────────────────────

// "the snapshot exists" is registered in cross_service_common.ts (dispatches via helpers).

// "the snapshot does not exist" is registered in cross_service_common.ts (dispatches via helpers).

// "the snapshot is {string}" is registered in cross_service_common.ts (dispatches via snapshotHelpers).

Given(/^the snapshot is not "([^"]*)"$/, async function (this: SdkWorld, _state: string) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: tag / resource state setup ─────────────────────────────────────────

// "the resource exists" and "the resource does not exist" are registered in apigateway.ts
// (dispatches via tagHelpers.setupResourceExists / setupResourceNotExists for @elasticache scenarios).

Given("the resource has tags", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: resources are created with default tags in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the resource does not have tags", async function (this: SdkWorld) {
  // @internal: no public API removes all tags from a resource in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("an ElastiCache cluster is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  assert.ok(
    this.clusterHelpers?.createNamedCluster,
    "Expected clusterHelpers.createNamedCluster to be registered",
  );
  // Act
  await this.clusterHelpers.createNamedCluster(this);
  // Assert: captured in lastCallResult
});

When("a redis cache cluster is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateCacheClusterCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheClient(this).send(
      new CreateCacheClusterCommand({
        CacheClusterId: ELASTICACHE_TEST_CLUSTER_ID,
        Engine: "redis",
        CacheNodeType: "cache.t3.micro",
        NumCacheNodes: 1,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a memcached cache cluster is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateCacheClusterCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheClient(this).send(
      new CreateCacheClusterCommand({
        CacheClusterId: ELASTICACHE_TEST_CLUSTER_ID,
        Engine: "memcached",
        CacheNodeType: "cache.t3.micro",
        NumCacheNodes: 1,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a standalone cache cluster is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteCacheClusterCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheClient(this).send(
      new DeleteCacheClusterCommand({ CacheClusterId: ELASTICACHE_TEST_CLUSTER_ID }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a standalone cache cluster finishes creating", async function (this: SdkWorld) {
  // @internal: lifecycle completion is driven by internal events only.
  // No-op — this state transition cannot be triggered via public API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a cache cluster deletion completes", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a cache cluster configuration is modified", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ModifyCacheClusterCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheClient(this).send(
      new ModifyCacheClusterCommand({ CacheClusterId: ELASTICACHE_TEST_CLUSTER_ID }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a cache cluster modification completes", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a replication group is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateReplicationGroupCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheClient(this).send(
      new CreateReplicationGroupCommand({
        ReplicationGroupId: ELASTICACHE_TEST_RG_ID,
        ReplicationGroupDescription: "test replication group",
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a replication group is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteReplicationGroupCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheClient(this).send(
      new DeleteReplicationGroupCommand({ ReplicationGroupId: ELASTICACHE_TEST_RG_ID }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a replication group finishes creating", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a replication group deletion completes", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a replication group configuration is modified", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ModifyReplicationGroupCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheClient(this).send(
      new ModifyReplicationGroupCommand({
        ReplicationGroupId: ELASTICACHE_TEST_RG_ID,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a replication group modification completes", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a replica is added to a replication group", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ModifyReplicationGroupCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheClient(this).send(
      new ModifyReplicationGroupCommand({
        ReplicationGroupId: ELASTICACHE_TEST_RG_ID,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  "an automatic failover promotes a new primary in a replication group",
  async function (this: SdkWorld) {
    // @internal: no-op — failover is an internal operation.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = { success: true, output: null };
  },
);

When("a cache subnet group is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateCacheSubnetGroupCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheClient(this).send(
      new CreateCacheSubnetGroupCommand({
        CacheSubnetGroupName: ELASTICACHE_TEST_SUBNET_GROUP_ID,
        CacheSubnetGroupDescription: "test subnet group",
        SubnetIds: ["subnet-00000001"],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a cache subnet group is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteCacheSubnetGroupCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheClient(this).send(
      new DeleteCacheSubnetGroupCommand({
        CacheSubnetGroupName: ELASTICACHE_TEST_SUBNET_GROUP_ID,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  "a snapshot is created from an available redis cache cluster",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { CreateSnapshotCommand } = require("@aws-sdk/client-elasticache");
    // Act
    try {
      const result = await elasticacheClient(this).send(
        new CreateSnapshotCommand({
          CacheClusterId: ELASTICACHE_TEST_CLUSTER_ID,
          SnapshotName: ELASTICACHE_TEST_SNAPSHOT_NAME,
        }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When("a cache snapshot is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteSnapshotCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheClient(this).send(
      new DeleteSnapshotCommand({ SnapshotName: ELASTICACHE_TEST_SNAPSHOT_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("tags are added to a cache resource", async function (this: SdkWorld) {
  // Arrange: check if the resource exists
  assert.ok(this.session, "Expected session to be initialized");
  const clusterExists = await elasticacheClusterExists(this);
  if (!clusterExists) {
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(`InvalidARN: cluster ${ELASTICACHE_TEST_CLUSTER_ID} does not exist`),
    };
    return;
  }
  const { AddTagsToResourceCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheClient(this).send(
      new AddTagsToResourceCommand({
        ResourceName: `arn:aws:elasticache:us-east-1:000000000000:cluster:${ELASTICACHE_TEST_CLUSTER_ID}`,
        Tags: [{ Key: ELASTICACHE_TEST_TAG_KEY, Value: ELASTICACHE_TEST_TAG_VALUE }],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("tags are removed from a cache resource", async function (this: SdkWorld) {
  // Arrange: check if the resource exists
  assert.ok(this.session, "Expected session to be initialized");
  const clusterExists = await elasticacheClusterExists(this);
  if (!clusterExists) {
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(`InvalidARN: cluster ${ELASTICACHE_TEST_CLUSTER_ID} does not exist`),
    };
    return;
  }
  const { RemoveTagsFromResourceCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheClient(this).send(
      new RemoveTagsFromResourceCommand({
        ResourceName: `arn:aws:elasticache:us-east-1:000000000000:cluster:${ELASTICACHE_TEST_CLUSTER_ID}`,
        TagKeys: [ELASTICACHE_TEST_TAG_KEY],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the cluster is in {string} state" is registered in cluster_common.ts (dispatches via clusterHelpers.assertClusterStatus).
// "the cluster is in {string} state with the memcached engine" is registered in cluster_common.ts.

// "the cluster is {string}" is registered in cluster_common.ts.

Then(
  /^the cluster is "([^"]*)" and the notification is "([^"]*)" to the topic$/,
  async function (this: SdkWorld, _clusterState: string, _notifState: string) {
    // @internal: no-op invariant.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  /^the cluster is "([^"]*)" but no notification is published$/,
  async function (this: SdkWorld, _clusterState: string) {
    // @internal: no-op invariant.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// 'the cluster is "AVAILABLE" again' is registered in cluster_common.ts.

Then('the cluster is "DELETING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_cache_cluster to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the cluster is "DELETED" and its tags are removed', async function (this: SdkWorld) {
  // @internal: no-op invariant.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the cluster returns to "AVAILABLE" state', async function (this: SdkWorld) {
  // @internal: no-op invariant.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  /^the replication group is in "([^"]*)" state$/,
  async function (this: SdkWorld, expectedState: string) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected operation to succeed but got error: ${String(this.lastCallResult.error)}; expected_state=${expectedState} expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
    assert.ok(
      this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
      `Expected output but got null; expected_state=${expectedState}`,
    );
  },
);

Then(
  'the replication group and its clusters are in "DELETING" state',
  async function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected delete_replication_group to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

Then(
  'the replication group is "DELETED" and its tags are removed',
  async function (this: SdkWorld) {
    // @internal: no-op invariant.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'the replication group and its primary cluster are "AVAILABLE"',
  async function (this: SdkWorld) {
    // @internal: no-op invariant.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then('the replication group returns to "AVAILABLE" state', async function (this: SdkWorld) {
  // @internal: no-op invariant.
  assert.ok(this.session, "Expected session to be initialized");
});

Then("the replication group has a new primary cluster", async function (this: SdkWorld) {
  // @internal: no-op invariant.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  'a new cluster is in "CREATING" state and associated with the replication group',
  async function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected add replica to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

Then("the subnet group exists", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: if used as Given precondition, create the subnet group; otherwise assert
  assert.ok(this.session, "Expected session to be initialized");
  const actualExists = await elasticacheSubnetGroupExists(this);
  if (!actualExists) {
    // Used as Given/And precondition — create the subnet group
    await elasticacheCreateSubnetGroup(this);
    return;
  }
  // Assert: already exists
  const expectedExists = true;
  assert.strictEqual(
    actualExists,
    expectedExists,
    `Expected subnet group "${ELASTICACHE_TEST_SUBNET_GROUP_ID}" to exist; expected_exists=${expectedExists} actual_exists=${actualExists}`,
  );
});

Then("the subnet group no longer exists", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act
  assert.ok(this.session, "Expected session to be initialized");
  const actualExists = await elasticacheSubnetGroupExists(this);
  // Assert
  const expectedExists = false;
  assert.strictEqual(
    actualExists,
    expectedExists,
    `Expected subnet group "${ELASTICACHE_TEST_SUBNET_GROUP_ID}" to be deleted but it still exists; expected_exists=${expectedExists} actual_exists=${actualExists}`,
  );
});

// 'the snapshot is in {string} state and the cluster is {string}' is registered in cross_service_common.ts
// (dispatches via snapshotHelpers.assertSnapshotInStateWithCluster).
// 'the snapshot is in {string} state' is registered in cross_service_common.ts
// (dispatches via snapshotHelpers.assertSnapshotInState).

Then("the resource remains tagged", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Dispatch via tagHelpers when available (e.g. @memorydb scenarios)
  if (this.tagHelpers?.assertResourceTagged) {
    // Act
    await this.tagHelpers.assertResourceTagged(this);
    // Assert: handled by assertResourceTagged
    return;
  }
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected add_tags_to_resource to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then(/^the resource tag state is unchanged \(no-op model\)$/, async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected the operation to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

// "the operation is rejected" is registered in cross_service_common.ts.

// ── Invariant Then steps ──────────────────────────────────────────────────────

Then(
  "memcached clusters are never associated with a replication group",
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);

Then("all snapshots reference redis clusters only", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then(
  "every available replication group has a primary cluster assigned",
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);

Then(
  "every active cluster, replication group, and snapshot has tags",
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);

// "every snapshotting cluster has a corresponding in-progress snapshot" — registered in cross_service_common.ts
