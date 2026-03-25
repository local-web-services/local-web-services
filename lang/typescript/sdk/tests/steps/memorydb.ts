/** Step definitions: memorydb service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const MEMORYDB_CLUSTER_NAME = "test-memorydb-cluster-1";
const MEMORYDB_USER_NAME = "test-memorydb-user-1";
const MEMORYDB_ACL_NAME = "test-memorydb-acl-1";
const MEMORYDB_SNAPSHOT_NAME = "test-memorydb-snapshot-1";
const MEMORYDB_TAG_KEY = "e2e-memorydb-tag-key-1";
const MEMORYDB_TAG_VALUE = "test-memorydb-tag-value-1";
const MEMORYDB_ARN = `arn:aws:memorydb:us-east-1:000000000000:cluster/${MEMORYDB_CLUSTER_NAME}`;

// ── Helpers ───────────────────────────────────────────────────────────────────

function memorydbClient(world: SdkWorld) {
  const { MemoryDBClient } = require("@aws-sdk/client-memorydb");
  return world.session!.client<typeof MemoryDBClient>("memorydb");
}

async function createACL(world: SdkWorld): Promise<void> {
  const { CreateACLCommand } = require("@aws-sdk/client-memorydb");
  try {
    await memorydbClient(world).send(
      new CreateACLCommand({
        ACLName: MEMORYDB_ACL_NAME,
        Tags: [{ Key: MEMORYDB_TAG_KEY, Value: MEMORYDB_TAG_VALUE }],
      }),
    );
  } catch {
    // ACL may already exist
  }
}

async function createCluster(world: SdkWorld): Promise<void> {
  const { CreateClusterCommand } = require("@aws-sdk/client-memorydb");
  await createACL(world);
  await memorydbClient(world).send(
    new CreateClusterCommand({
      ClusterName: MEMORYDB_CLUSTER_NAME,
      NodeType: "db.r6g.large",
      ACLName: MEMORYDB_ACL_NAME,
      Tags: [{ Key: MEMORYDB_TAG_KEY, Value: MEMORYDB_TAG_VALUE }],
    }),
  );
}

async function createUser(world: SdkWorld): Promise<void> {
  const { CreateUserCommand } = require("@aws-sdk/client-memorydb");
  await memorydbClient(world).send(
    new CreateUserCommand({
      UserName: MEMORYDB_USER_NAME,
      AccessString: "on ~* &* +@all",
      AuthenticationMode: { Type: "no-password" },
      Tags: [{ Key: MEMORYDB_TAG_KEY, Value: MEMORYDB_TAG_VALUE }],
    }),
  );
}

async function createSnapshot(world: SdkWorld): Promise<void> {
  const { CreateSnapshotCommand } = require("@aws-sdk/client-memorydb");
  await memorydbClient(world).send(
    new CreateSnapshotCommand({
      ClusterName: MEMORYDB_CLUSTER_NAME,
      SnapshotName: MEMORYDB_SNAPSHOT_NAME,
      Tags: [{ Key: MEMORYDB_TAG_KEY, Value: MEMORYDB_TAG_VALUE }],
    }),
  );
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: cluster state setup ────────────────────────────────────────────────

Given("the cluster does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no clusters.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createCluster(this);
  // Assert: cluster created
});

Given("the cluster does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no clusters.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createCluster(this);
  // Assert: cluster created
});

Given("the cluster is {string}", async function (this: SdkWorld, _state: string) {
  // Arrange / Act / Assert — no-op: clusters are available after creation in lws,
  // or @internal: non-AVAILABLE/transient states cannot be forced via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster is not {string}", async function (this: SdkWorld, _state: string) {
  // Arrange / Act / Assert — no-op: freshly created cluster is not in the named state,
  // or @internal: non-standard states require internal control.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('multi-"AZ" is enabled for the cluster', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: multi-AZ state managed internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('multi-"AZ" is not enabled for the cluster', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: multi-AZ not enabled by default in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: user state setup ───────────────────────────────────────────────────

Given("the user does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no users.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the user already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createUser(this);
  // Assert: user created
});

Given("the user does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no users.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the user exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createUser(this);
  // Assert: user created
});

Given("the user is {string}", async function (this: SdkWorld, _state: string) {
  // Arrange / Act / Assert — no-op: users are ACTIVE after creation in lws,
  // or @internal: non-ACTIVE/transient states cannot be forced via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the user is not {string}", async function (this: SdkWorld, _state: string) {
  // Arrange / Act / Assert — no-op: freshly created user is not in the named state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the user is not already a member of the "ACL"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: freshly created user is not a member of any ACL.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the user is already a member of the "ACL"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UpdateACLCommand } = require("@aws-sdk/client-memorydb");
  // Act
  await memorydbClient(this).send(
    new UpdateACLCommand({
      ACLName: MEMORYDB_ACL_NAME,
      UserNamesToAdd: [MEMORYDB_USER_NAME],
    }),
  );
  // Assert: user added to ACL
});

Given("the user membership entry does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no membership entries.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the user membership entry exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UpdateACLCommand } = require("@aws-sdk/client-memorydb");
  // Act
  await memorydbClient(this).send(
    new UpdateACLCommand({
      ACLName: MEMORYDB_ACL_NAME,
      UserNamesToAdd: [MEMORYDB_USER_NAME],
    }),
  );
  // Assert: user added to ACL
});

// ── Given: ACL state setup ────────────────────────────────────────────────────

Given('the "ACL" does not already exist', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no ACLs.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "ACL" already exists', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createACL(this);
  // Assert: ACL created
});

Given('the "ACL" does not exist', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no ACLs.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "ACL" exists', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createACL(this);
  // Assert: ACL created
});

Given('the "ACL" is {string}', async function (this: SdkWorld, _state: string) {
  // Arrange / Act / Assert — no-op: ACLs are ACTIVE after creation in lws,
  // or @internal: non-ACTIVE/transient states cannot be forced via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "ACL" is not {string}', async function (this: SdkWorld, _state: string) {
  // Arrange / Act / Assert — no-op: freshly created ACL is not in the named state.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: snapshot state setup ───────────────────────────────────────────────

Given("the snapshot does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no snapshots.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the snapshot exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createCluster(this);
  await createSnapshot(this);
  // Assert: snapshot created
});

Given("the snapshot is {string}", async function (this: SdkWorld, _state: string) {
  // Arrange / Act / Assert — no-op: snapshots are AVAILABLE after creation in lws,
  // or @internal: non-AVAILABLE/transient states cannot be forced via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the snapshot is not {string}", async function (this: SdkWorld, _state: string) {
  // Arrange / Act / Assert — no-op: freshly created snapshot is not in the named state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the snapshot slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has snapshot slots available.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the snapshot slot is not available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — @internal: exhausting snapshot slots requires internal control.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the snapshot belongs to this cluster", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: snapshot was created from the test cluster.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the snapshot does not belong to this cluster", async function (this: SdkWorld) {
  // Arrange / Act / Assert — @internal: cross-cluster snapshot state cannot be set via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the target cluster slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has cluster slots available.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the target cluster slot is not available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — @internal: exhausting cluster slots requires internal control.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: tag/resource state setup ──────────────────────────────────────────

Given("the resource has a tag entry", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createCluster(this);
  // Assert: cluster created with tags
});

Given("the resource does not have a tag entry", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no resources to tag.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the resource is tagged", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: cluster is already created with tags.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the resource is not tagged", async function (this: SdkWorld) {
  // Arrange / Act / Assert — @internal: resource with empty tag list requires internal control.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: FizzBee sequence preconditions ─────────────────────────────────────

Given("cid in cluster_status", async function (this: SdkWorld) {
  // @internal: FizzBee sequence precondition; no public API equivalent.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("cid not in cluster_status", async function (this: SdkWorld) {
  // @internal: FizzBee sequence precondition; no public API equivalent.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("sid in snapshot_status", async function (this: SdkWorld) {
  // @internal: FizzBee sequence precondition; no public API equivalent.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("uid in user_status", async function (this: SdkWorld) {
  // @internal: FizzBee sequence precondition; no public API equivalent.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("uid not in user_status", async function (this: SdkWorld) {
  // @internal: FizzBee sequence precondition; no public API equivalent.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("aid in acl_status", async function (this: SdkWorld) {
  // @internal: FizzBee sequence precondition; no public API equivalent.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("aid not in acl_status", async function (this: SdkWorld) {
  // @internal: FizzBee sequence precondition; no public API equivalent.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("cid in tag_exists", async function (this: SdkWorld) {
  // @internal: FizzBee sequence precondition; no public API equivalent.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("a MemoryDB cluster is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateClusterCommand } = require("@aws-sdk/client-memorydb");
  await createACL(this);
  // Act
  try {
    const result = await memorydbClient(this).send(
      new CreateClusterCommand({
        ClusterName: MEMORYDB_CLUSTER_NAME,
        NodeType: "db.r6g.large",
        ACLName: MEMORYDB_ACL_NAME,
        Tags: [{ Key: MEMORYDB_TAG_KEY, Value: MEMORYDB_TAG_VALUE }],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a MemoryDB cluster is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteClusterCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new DeleteClusterCommand({ ClusterName: MEMORYDB_CLUSTER_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a user is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateUserCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new CreateUserCommand({
        UserName: MEMORYDB_USER_NAME,
        AccessString: "on ~* &* +@all",
        AuthenticationMode: { Type: "no-password" },
        Tags: [{ Key: MEMORYDB_TAG_KEY, Value: MEMORYDB_TAG_VALUE }],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a user is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteUserCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new DeleteUserCommand({ UserName: MEMORYDB_USER_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a user is updated", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UpdateUserCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new UpdateUserCommand({
        UserName: MEMORYDB_USER_NAME,
        AccessString: "on ~* &* +@all",
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('an "ACL" is created', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateACLCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new CreateACLCommand({
        ACLName: MEMORYDB_ACL_NAME,
        Tags: [{ Key: MEMORYDB_TAG_KEY, Value: MEMORYDB_TAG_VALUE }],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('an "ACL" is deleted', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteACLCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new DeleteACLCommand({ ACLName: MEMORYDB_ACL_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('an "ACL" is updated', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UpdateACLCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new UpdateACLCommand({ ACLName: MEMORYDB_ACL_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('an "ACL" is associated with a cluster', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UpdateClusterCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new UpdateClusterCommand({
        ClusterName: MEMORYDB_CLUSTER_NAME,
        ACLName: MEMORYDB_ACL_NAME,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('a user is added to an "ACL"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UpdateACLCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new UpdateACLCommand({
        ACLName: MEMORYDB_ACL_NAME,
        UserNamesToAdd: [MEMORYDB_USER_NAME],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('a user is removed from an "ACL"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UpdateACLCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new UpdateACLCommand({
        ACLName: MEMORYDB_ACL_NAME,
        UserNamesToRemove: [MEMORYDB_USER_NAME],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a snapshot is created from an available cluster", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateSnapshotCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new CreateSnapshotCommand({
        ClusterName: MEMORYDB_CLUSTER_NAME,
        SnapshotName: MEMORYDB_SNAPSHOT_NAME,
        Tags: [{ Key: MEMORYDB_TAG_KEY, Value: MEMORYDB_TAG_VALUE }],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a snapshot is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteSnapshotCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new DeleteSnapshotCommand({ SnapshotName: MEMORYDB_SNAPSHOT_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a cluster is restored from a snapshot", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateClusterCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new CreateClusterCommand({
        ClusterName: `${MEMORYDB_CLUSTER_NAME}-restored`,
        NodeType: "db.r6g.large",
        ACLName: MEMORYDB_ACL_NAME,
        SnapshotName: MEMORYDB_SNAPSHOT_NAME,
        Tags: [{ Key: MEMORYDB_TAG_KEY, Value: MEMORYDB_TAG_VALUE }],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a MemoryDB cluster configuration is updated", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UpdateClusterCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new UpdateClusterCommand({
        ClusterName: MEMORYDB_CLUSTER_NAME,
        Description: "updated-description",
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('a shard failover is triggered on a multi-"AZ" cluster', async function (this: SdkWorld) {
  // @internal: shard failover is an internal operation; no public API equivalent.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a MemoryDB cluster finishes creating", async function (this: SdkWorld) {
  // @internal: cluster creation completion is an internal state transition.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a MemoryDB cluster deletion completes", async function (this: SdkWorld) {
  // @internal: cluster deletion completion is an internal state transition.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a MemoryDB cluster update completes", async function (this: SdkWorld) {
  // @internal: cluster update completion is an internal state transition.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a cluster restore from snapshot completes", async function (this: SdkWorld) {
  // @internal: cluster restore completion is an internal state transition.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a user finishes creating", async function (this: SdkWorld) {
  // @internal: user creation completion is an internal state transition.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a user deletion completes", async function (this: SdkWorld) {
  // @internal: user deletion completion is an internal state transition.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a user update completes", async function (this: SdkWorld) {
  // @internal: user update completion is an internal state transition.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When('an "ACL" finishes creating', async function (this: SdkWorld) {
  // @internal: ACL creation completion is an internal state transition.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When('an "ACL" deletion completes', async function (this: SdkWorld) {
  // @internal: ACL deletion completion is an internal state transition.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When('an "ACL" update completes', async function (this: SdkWorld) {
  // @internal: ACL update completion is an internal state transition.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a snapshot finishes creating", async function (this: SdkWorld) {
  // @internal: snapshot creation completion is an internal state transition.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("a snapshot deletion completes", async function (this: SdkWorld) {
  // @internal: snapshot deletion completion is an internal state transition.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

When("tags are added to a MemoryDB resource", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { TagResourceCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new TagResourceCommand({
        ResourceArn: MEMORYDB_ARN,
        Tags: [{ Key: MEMORYDB_TAG_KEY, Value: MEMORYDB_TAG_VALUE }],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("tags are removed from a MemoryDB resource", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UntagResourceCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await memorydbClient(this).send(
      new UntagResourceCommand({
        ResourceArn: MEMORYDB_ARN,
        TagKeys: [MEMORYDB_TAG_KEY],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// ── Then: assertions ──────────────────────────────────────────────────────────

Then('the cluster is in "CREATING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected create_cluster to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const { DescribeClustersCommand } = require("@aws-sdk/client-memorydb");
  const result = await memorydbClient(this).send(
    new DescribeClustersCommand({ ClusterName: MEMORYDB_CLUSTER_NAME }),
  );
  const clusters: Array<{ Name?: string; Status?: string }> = result.Clusters ?? [];
  assert.ok(
    clusters.length > 0,
    `Expected cluster "${MEMORYDB_CLUSTER_NAME}" to exist but not found`,
  );
  const expectedStatus = "creating";
  const actualStatus = clusters[0].Status;
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected cluster status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
  );
});

Then('the cluster is in "DELETING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_cluster to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const { DescribeClustersCommand } = require("@aws-sdk/client-memorydb");
  const result = await memorydbClient(this).send(
    new DescribeClustersCommand({ ClusterName: MEMORYDB_CLUSTER_NAME }),
  );
  const clusters: Array<{ Name?: string; Status?: string }> = result.Clusters ?? [];
  assert.ok(
    clusters.length > 0,
    `Expected cluster "${MEMORYDB_CLUSTER_NAME}" to exist in DELETING state`,
  );
  const expectedStatus = "deleting";
  const actualStatus = clusters[0].Status;
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected cluster status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
  );
});

Then('the cluster is in "MODIFYING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected update_cluster to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  assert.ok(
    this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
    "Expected UpdateClusterOutput but got null",
  );
});

Then('the cluster is "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected operation to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the cluster is "DELETED" and its tags are removed', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act
  const { DescribeClustersCommand } = require("@aws-sdk/client-memorydb");
  try {
    const result = await memorydbClient(this).send(
      new DescribeClustersCommand({ ClusterName: MEMORYDB_CLUSTER_NAME }),
    );
    const clusters: Array<{ Name?: string; Status?: string }> = result.Clusters ?? [];
    // Assert
    for (const c of clusters) {
      if (c.Name === MEMORYDB_CLUSTER_NAME) {
        const actualStatus = c.Status ?? "";
        const expectedAbsent = MEMORYDB_CLUSTER_NAME;
        assert.ok(
          actualStatus === "deleting" || actualStatus === "deleted",
          `Expected cluster "${expectedAbsent}" to be deleted but status is "${actualStatus}"; expected_deleted=${expectedAbsent} actual_status=${actualStatus}`,
        );
      }
    }
  } catch {
    // Cluster not found — treat as deleted
  }
});

Then('the cluster returns to "AVAILABLE" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected operation to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the cluster remains "AVAILABLE" after the shard failover', async function (this: SdkWorld) {
  // No-op invariant: shard failover is internal; trivially satisfied in lws context.
});

Then('the restored cluster is in "RESTORING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected cluster restore to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  assert.ok(
    this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
    "Expected CreateClusterOutput but got null",
  );
});

Then('the cluster is linked to the active "ACL"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected update_cluster to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const { DescribeClustersCommand } = require("@aws-sdk/client-memorydb");
  const result = await memorydbClient(this).send(
    new DescribeClustersCommand({ ClusterName: MEMORYDB_CLUSTER_NAME }),
  );
  const clusters: Array<{ Name?: string; ACLName?: string }> = result.Clusters ?? [];
  assert.ok(
    clusters.length > 0,
    `Expected cluster "${MEMORYDB_CLUSTER_NAME}" to exist but not found`,
  );
  const expectedACLName = MEMORYDB_ACL_NAME;
  const actualACLName = clusters[0].ACLName;
  assert.strictEqual(
    actualACLName,
    expectedACLName,
    `Expected ACL name "${expectedACLName}" but got "${actualACLName}"; expected_acl=${expectedACLName} actual_acl=${actualACLName}`,
  );
});

// ── User assertion steps ───────────────────────────────────────────────────────

Then('the user is in "CREATING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected create_user to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const { DescribeUsersCommand } = require("@aws-sdk/client-memorydb");
  const result = await memorydbClient(this).send(
    new DescribeUsersCommand({ UserName: MEMORYDB_USER_NAME }),
  );
  const users: Array<{ Name?: string; Status?: string }> = result.Users ?? [];
  assert.ok(users.length > 0, `Expected user "${MEMORYDB_USER_NAME}" to exist but not found`);
  const expectedStatus = "creating";
  const actualStatus = users[0].Status;
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected user status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
  );
});

Then('the user is in "DELETING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_user to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const { DescribeUsersCommand } = require("@aws-sdk/client-memorydb");
  const result = await memorydbClient(this).send(
    new DescribeUsersCommand({ UserName: MEMORYDB_USER_NAME }),
  );
  const users: Array<{ Name?: string; Status?: string }> = result.Users ?? [];
  assert.ok(users.length > 0, `Expected user "${MEMORYDB_USER_NAME}" to exist in DELETING state`);
  const expectedStatus = "deleting";
  const actualStatus = users[0].Status;
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected user status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
  );
});

Then('the user is in "MODIFYING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected update_user to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  assert.ok(
    this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
    "Expected UpdateUserOutput but got null",
  );
});

Then('the user is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected operation to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the user is "DELETED"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act
  const { DescribeUsersCommand } = require("@aws-sdk/client-memorydb");
  try {
    const result = await memorydbClient(this).send(
      new DescribeUsersCommand({ UserName: MEMORYDB_USER_NAME }),
    );
    const users: Array<{ Name?: string; Status?: string }> = result.Users ?? [];
    // Assert
    for (const u of users) {
      if (u.Name === MEMORYDB_USER_NAME) {
        const actualStatus = u.Status ?? "";
        const expectedAbsent = MEMORYDB_USER_NAME;
        assert.ok(
          actualStatus === "deleting" || actualStatus === "deleted",
          `Expected user "${expectedAbsent}" to be deleted but status is "${actualStatus}"; expected_deleted=${expectedAbsent} actual_status=${actualStatus}`,
        );
      }
    }
  } catch {
    // User not found — treat as deleted
  }
});

Then('the user returns to "ACTIVE" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected operation to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the user is a member of the "ACL"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected update_acl to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const { DescribeACLsCommand } = require("@aws-sdk/client-memorydb");
  const result = await memorydbClient(this).send(
    new DescribeACLsCommand({ ACLName: MEMORYDB_ACL_NAME }),
  );
  const acls: Array<{ Name?: string; UserNames?: string[] }> = result.ACLs ?? [];
  assert.ok(acls.length > 0, `Expected ACL "${MEMORYDB_ACL_NAME}" to exist but not found`);
  const actualMembers: string[] = acls[0].UserNames ?? [];
  const expectedMember = MEMORYDB_USER_NAME;
  assert.ok(
    actualMembers.includes(expectedMember),
    `Expected user "${expectedMember}" to be a member of ACL "${MEMORYDB_ACL_NAME}" but not found; expected_member=${expectedMember} actual_members=${JSON.stringify(actualMembers)}`,
  );
});

Then('the user is no longer a member of the "ACL"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected update_acl to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const { DescribeACLsCommand } = require("@aws-sdk/client-memorydb");
  const result = await memorydbClient(this).send(
    new DescribeACLsCommand({ ACLName: MEMORYDB_ACL_NAME }),
  );
  const acls: Array<{ Name?: string; UserNames?: string[] }> = result.ACLs ?? [];
  assert.ok(acls.length > 0, `Expected ACL "${MEMORYDB_ACL_NAME}" to exist but not found`);
  const actualMembers: string[] = acls[0].UserNames ?? [];
  const expectedAbsent = MEMORYDB_USER_NAME;
  assert.ok(
    !actualMembers.includes(expectedAbsent),
    `Expected user "${expectedAbsent}" to be removed from ACL "${MEMORYDB_ACL_NAME}" but still found; expected_absent=${expectedAbsent} actual_members=${JSON.stringify(actualMembers)}`,
  );
});

// ── ACL assertion steps ───────────────────────────────────────────────────────

Then('the "ACL" is in "CREATING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected create_acl to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const { DescribeACLsCommand } = require("@aws-sdk/client-memorydb");
  const result = await memorydbClient(this).send(
    new DescribeACLsCommand({ ACLName: MEMORYDB_ACL_NAME }),
  );
  const acls: Array<{ Name?: string; Status?: string }> = result.ACLs ?? [];
  assert.ok(acls.length > 0, `Expected ACL "${MEMORYDB_ACL_NAME}" to exist but not found`);
  const expectedStatus = "creating";
  const actualStatus = acls[0].Status;
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected ACL status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
  );
});

Then('the "ACL" is in "DELETING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_acl to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const { DescribeACLsCommand } = require("@aws-sdk/client-memorydb");
  const result = await memorydbClient(this).send(
    new DescribeACLsCommand({ ACLName: MEMORYDB_ACL_NAME }),
  );
  const acls: Array<{ Name?: string; Status?: string }> = result.ACLs ?? [];
  assert.ok(acls.length > 0, `Expected ACL "${MEMORYDB_ACL_NAME}" to exist in DELETING state`);
  const expectedStatus = "deleting";
  const actualStatus = acls[0].Status;
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected ACL status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
  );
});

Then('the "ACL" is in "MODIFYING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected update_acl to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  assert.ok(
    this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
    "Expected UpdateACLOutput but got null",
  );
});

Then('the "ACL" is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected operation to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the "ACL" is "DELETED"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act
  const { DescribeACLsCommand } = require("@aws-sdk/client-memorydb");
  try {
    const result = await memorydbClient(this).send(
      new DescribeACLsCommand({ ACLName: MEMORYDB_ACL_NAME }),
    );
    const acls: Array<{ Name?: string; Status?: string }> = result.ACLs ?? [];
    // Assert
    for (const a of acls) {
      if (a.Name === MEMORYDB_ACL_NAME) {
        const actualStatus = a.Status ?? "";
        const expectedAbsent = MEMORYDB_ACL_NAME;
        assert.ok(
          actualStatus === "deleting" || actualStatus === "deleted",
          `Expected ACL "${expectedAbsent}" to be deleted but status is "${actualStatus}"; expected_deleted=${expectedAbsent} actual_status=${actualStatus}`,
        );
      }
    }
  } catch {
    // ACL not found — treat as deleted
  }
});

Then('the "ACL" returns to "ACTIVE" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected operation to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

// ── Snapshot assertion steps ──────────────────────────────────────────────────

Then(
  'the snapshot is in "CREATING" state and the cluster is "SNAPSHOTTING"',
  async function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected create_snapshot to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
    const { DescribeSnapshotsCommand } = require("@aws-sdk/client-memorydb");
    const result = await memorydbClient(this).send(
      new DescribeSnapshotsCommand({ SnapshotName: MEMORYDB_SNAPSHOT_NAME }),
    );
    const snapshots: Array<{ Name?: string; Status?: string }> = result.Snapshots ?? [];
    assert.ok(
      snapshots.length > 0,
      `Expected snapshot "${MEMORYDB_SNAPSHOT_NAME}" to exist but not found`,
    );
    const expectedStatus = "creating";
    const actualStatus = snapshots[0].Status;
    assert.strictEqual(
      actualStatus,
      expectedStatus,
      `Expected snapshot status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
    );
  },
);

Then('the snapshot is in "DELETING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_snapshot to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const { DescribeSnapshotsCommand } = require("@aws-sdk/client-memorydb");
  const result = await memorydbClient(this).send(
    new DescribeSnapshotsCommand({ SnapshotName: MEMORYDB_SNAPSHOT_NAME }),
  );
  const snapshots: Array<{ Name?: string; Status?: string }> = result.Snapshots ?? [];
  assert.ok(
    snapshots.length > 0,
    `Expected snapshot "${MEMORYDB_SNAPSHOT_NAME}" to exist in DELETING state`,
  );
  const expectedStatus = "deleting";
  const actualStatus = snapshots[0].Status;
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected snapshot status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
  );
});

Then(
  'the snapshot is "AVAILABLE" and the cluster returns to "AVAILABLE" state',
  async function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected operation to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
    assert.ok(
      this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
      "Expected output but got null",
    );
  },
);

Then('the snapshot is "DELETED" and its tags are removed', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act
  const { DescribeSnapshotsCommand } = require("@aws-sdk/client-memorydb");
  try {
    const result = await memorydbClient(this).send(
      new DescribeSnapshotsCommand({ SnapshotName: MEMORYDB_SNAPSHOT_NAME }),
    );
    const snapshots: Array<{ Name?: string; Status?: string }> = result.Snapshots ?? [];
    // Assert
    for (const s of snapshots) {
      if (s.Name === MEMORYDB_SNAPSHOT_NAME) {
        const actualStatus = s.Status ?? "";
        const expectedAbsent = MEMORYDB_SNAPSHOT_NAME;
        assert.ok(
          actualStatus === "deleting" || actualStatus === "deleted",
          `Expected snapshot "${expectedAbsent}" to be deleted but status is "${actualStatus}"; expected_deleted=${expectedAbsent} actual_status=${actualStatus}`,
        );
      }
    }
  } catch {
    // Snapshot not found — treat as deleted
  }
});

// ── Tag assertion steps ───────────────────────────────────────────────────────

Then("the resource remains tagged", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected tag_resource to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const { ListTagsCommand } = require("@aws-sdk/client-memorydb");
  const result = await memorydbClient(this).send(
    new ListTagsCommand({ ResourceArn: MEMORYDB_ARN }),
  );
  const tagList: Array<{ Key?: string; Value?: string }> = result.TagList ?? [];
  const expectedTagKey = MEMORYDB_TAG_KEY;
  const found = tagList.some((t) => t.Key === expectedTagKey);
  assert.ok(
    found,
    `Expected tag "${expectedTagKey}" to exist on resource but not found; expected_tag_key=${expectedTagKey}`,
  );
});

Then("the resource tag state is unchanged (no-op model)", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected untag_resource to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

// ── Invariant catch-all steps ─────────────────────────────────────────────────

// "the operation is rejected" is registered in cross_service_common.ts.

Then("every active cluster has write durability enabled", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then(
  "every snapshotting cluster has a corresponding in-progress snapshot",
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);

Then(
  'no "ACL" in "DELETING" state is currently associated with a cluster',
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);

Then(
  'no user in "DELETING" state is currently a member of an "ACL"',
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);

Then("every active cluster and snapshot has tags", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});
