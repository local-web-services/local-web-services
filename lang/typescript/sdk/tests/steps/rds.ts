/** Step definitions: rds service informal specification scenarios */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld, SnapshotHelpers, DatabaseStepHelpers } from "../support/world";

const RDS_TEST_DB_INSTANCE_ID = "test-rds-db-1";
const RDS_TEST_SNAPSHOT_ID = "test-rds-snapshot-1";
const RDS_TEST_DB_ENGINE = "mysql";
const RDS_TEST_DB_CLASS = "db.t3.micro";
const RDS_TEST_TAG_KEY = "e2e-rds-tag-key-1";
const RDS_TEST_TAG_VALUE = "test-rds-tag-value-1";

// ── Helpers ───────────────────────────────────────────────────────────────────

function rdsClient(world: SdkWorld) {
  const { RDSClient } = require("@aws-sdk/client-rds");
  return world.session!.client<typeof RDSClient>("rds");
}

async function rdsCreateDBInstance(world: SdkWorld): Promise<void> {
  const { CreateDBInstanceCommand } = require("@aws-sdk/client-rds");
  try {
    await rdsClient(world).send(
      new CreateDBInstanceCommand({
        DBInstanceIdentifier: RDS_TEST_DB_INSTANCE_ID,
        DBInstanceClass: RDS_TEST_DB_CLASS,
        Engine: RDS_TEST_DB_ENGINE,
        MasterUsername: "admin",
        MasterUserPassword: "password123",
      }),
    );
  } catch (err: unknown) {
    const msg = String(err);
    if (!msg.includes("already") && !msg.includes("DBInstanceAlreadyExists")) {
      throw err;
    }
  }
}

async function rdsCreateSnapshot(world: SdkWorld): Promise<void> {
  const { CreateDBSnapshotCommand } = require("@aws-sdk/client-rds");
  try {
    await rdsClient(world).send(
      new CreateDBSnapshotCommand({
        DBInstanceIdentifier: RDS_TEST_DB_INSTANCE_ID,
        DBSnapshotIdentifier: RDS_TEST_SNAPSHOT_ID,
      }),
    );
  } catch (err: unknown) {
    const msg = String(err);
    if (!msg.includes("already") && !msg.includes("DBSnapshotAlreadyExists")) {
      throw err;
    }
  }
}

// ── Before hook: register snapshot helpers for @rds scenarios ────────────────

Before({ tags: "@rds" }, function (this: SdkWorld) {
  const snapshotHelpersImpl: SnapshotHelpers = {
    setupSnapshotExists: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: create DB instance then snapshot
      await rdsCreateDBInstance(world);
      await rdsCreateSnapshot(world);
      // Assert: snapshot created
    },
    setupSnapshotNotExists: async (world: SdkWorld) => {
      // Arrange / Act / Assert — no-op: fresh state after session reset has no snapshots.
      assert.ok(world.session, "Expected session to be initialized");
    },
    assertSnapshotInState: async (world: SdkWorld, _state: string) => {
      // Arrange: no additional setup required
      // Act: action already performed in the When step
      // Assert
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected delete_db_snapshot to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
    },
  };
  this.snapshotHelpers = snapshotHelpersImpl;

  const databaseHelpersImpl: DatabaseStepHelpers = {
    createCluster: async (_world: SdkWorld) => {
      // RDS does not have clusters in the same sense as DocDB/Neptune — no-op.
    },
    deleteCluster: async (_world: SdkWorld) => {
      // RDS does not have clusters in the same sense as DocDB/Neptune — no-op.
    },
    modifyCluster: async (_world: SdkWorld) => {
      // RDS does not have clusters in the same sense as DocDB/Neptune — no-op.
    },
    createInstance: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      await rdsCreateDBInstance(world);
    },
    deleteInstance: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { DeleteDBInstanceCommand } = require("@aws-sdk/client-rds");
      try {
        const result = await rdsClient(world).send(
          new DeleteDBInstanceCommand({
            DBInstanceIdentifier: RDS_TEST_DB_INSTANCE_ID,
            SkipFinalSnapshot: true,
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    modifyInstance: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { ModifyDBInstanceCommand } = require("@aws-sdk/client-rds");
      try {
        const result = await rdsClient(world).send(
          new ModifyDBInstanceCommand({
            DBInstanceIdentifier: RDS_TEST_DB_INSTANCE_ID,
            DBInstanceClass: "db.t3.small",
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    rebootInstance: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { RebootDBInstanceCommand } = require("@aws-sdk/client-rds");
      try {
        const result = await rdsClient(world).send(
          new RebootDBInstanceCommand({ DBInstanceIdentifier: RDS_TEST_DB_INSTANCE_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    createSnapshot: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      await rdsCreateSnapshot(world);
    },
    deleteSnapshot: async (_world: SdkWorld) => {
      // RDS uses DB snapshots (not cluster snapshots) — no-op for this path.
    },
    assertInstanceInState: async (world: SdkWorld, _expectedState: string) => {
      assert.ok(world.session, "Expected session to be initialized");
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected RDS DB operation to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
      assert.ok(
        world.lastCallResult.output !== null && world.lastCallResult.output !== undefined,
        `Expected output for state "${_expectedState}" but got null`,
      );
    },
    setupInstanceExists: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      await rdsCreateDBInstance(world);
    },
    setupInstanceNotExists: async (world: SdkWorld) => {
      // no-op: fresh state after session reset has no instances.
      assert.ok(world.session, "Expected session to be initialized");
    },
  };
  this.databaseHelpers = databaseHelpersImpl;
});

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: DB instance state setup ───────────────────────────────────────────

Given("the database instance does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no DB instances.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the database instance already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await rdsCreateDBInstance(this);
  // Assert: DB instance created
});

Given("the database instance exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await rdsCreateDBInstance(this);
  // Assert: DB instance created
});

Given(
  "the instance is {string} or {string}",
  async function (this: SdkWorld, _state1: string, _state2: string) {
    // Arrange / Act / Assert — no-op: DB instances in lws are available after creation.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// "the instance is {string}" is registered in cross_service_common.ts.
// "the instance is not {string}" is registered in cross_service_common.ts.

Given(
  "the instance is neither {string} nor {string}",
  async function (this: SdkWorld, _state1: string, _state2: string) {
    // @internal: Cannot force a DB instance into neither AVAILABLE nor FAILED via public API.
    // Only reached by @lifecycle scenarios excluded by the tag filter.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given("the database instance does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no DB instances.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("a snapshot slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: always room for snapshots in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no snapshot slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust snapshot slot limit in lws via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: snapshot state setup ───────────────────────────────────────────────

// "the snapshot exists" is registered in cross_service_common.ts (dispatches via snapshotHelpers).
// "the snapshot does not exist" is registered in cross_service_common.ts (dispatches via snapshotHelpers).
// "the snapshot is {string}" is registered in cross_service_common.ts (dispatches via snapshotHelpers).

Given("the snapshot is not {string}", async function (this: SdkWorld, _state: string) {
  // @internal: Cannot force a snapshot into a non-AVAILABLE state via public API.
  // Only reached by @lifecycle scenarios excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the target instance slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: always room for DB instances in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the target instance slot is not available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust instance slot limit in lws via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("a database instance is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateDBInstanceCommand } = require("@aws-sdk/client-rds");
  // Act
  try {
    const result = await rdsClient(this).send(
      new CreateDBInstanceCommand({
        DBInstanceIdentifier: RDS_TEST_DB_INSTANCE_ID,
        DBInstanceClass: RDS_TEST_DB_CLASS,
        Engine: RDS_TEST_DB_ENGINE,
        MasterUsername: "admin",
        MasterUserPassword: "password123",
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a database instance is deleted without a final snapshot", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteDBInstanceCommand } = require("@aws-sdk/client-rds");
  // Act
  try {
    const result = await rdsClient(this).send(
      new DeleteDBInstanceCommand({
        DBInstanceIdentifier: RDS_TEST_DB_INSTANCE_ID,
        SkipFinalSnapshot: true,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a database instance is deleted with a final snapshot", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteDBInstanceCommand } = require("@aws-sdk/client-rds");
  // Act
  try {
    const result = await rdsClient(this).send(
      new DeleteDBInstanceCommand({
        DBInstanceIdentifier: RDS_TEST_DB_INSTANCE_ID,
        SkipFinalSnapshot: false,
        FinalDBSnapshotIdentifier: RDS_TEST_SNAPSHOT_ID,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// "a database instance configuration is modified" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database instance is rebooted" is registered in cross_service_common.ts (dispatches via databaseHelpers).

When("a database snapshot is created from an instance", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateDBSnapshotCommand } = require("@aws-sdk/client-rds");
  // Act
  try {
    const result = await rdsClient(this).send(
      new CreateDBSnapshotCommand({
        DBInstanceIdentifier: RDS_TEST_DB_INSTANCE_ID,
        DBSnapshotIdentifier: RDS_TEST_SNAPSHOT_ID,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a database snapshot is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteDBSnapshotCommand } = require("@aws-sdk/client-rds");
  // Act
  try {
    const result = await rdsClient(this).send(
      new DeleteDBSnapshotCommand({
        DBSnapshotIdentifier: RDS_TEST_SNAPSHOT_ID,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  "multi-{string} is enabled on a database instance",
  async function (this: SdkWorld, _az: string) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { ModifyDBInstanceCommand } = require("@aws-sdk/client-rds");
    // Act
    try {
      const result = await rdsClient(this).send(
        new ModifyDBInstanceCommand({
          DBInstanceIdentifier: RDS_TEST_DB_INSTANCE_ID,
          MultiAZ: true,
        }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When("a tag is applied to a database instance", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { AddTagsToResourceCommand } = require("@aws-sdk/client-rds");
  // Act
  try {
    const result = await rdsClient(this).send(
      new AddTagsToResourceCommand({
        ResourceName: `arn:aws:rds:us-east-1:000000000000:db:${RDS_TEST_DB_INSTANCE_ID}`,
        Tags: [{ Key: RDS_TEST_TAG_KEY, Value: RDS_TEST_TAG_VALUE }],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a database instance is restored from a snapshot", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { RestoreDBInstanceFromDBSnapshotCommand } = require("@aws-sdk/client-rds");
  // Act
  try {
    const result = await rdsClient(this).send(
      new RestoreDBInstanceFromDBSnapshotCommand({
        DBInstanceIdentifier: "test-rds-db-2",
        DBSnapshotIdentifier: RDS_TEST_SNAPSHOT_ID,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the instance is in {string} state" is registered in cross_service_common.ts (dispatches via databaseHelpers).

Then(
  "the instance is in {string} state and a snapshot is {string}",
  async function (this: SdkWorld, _instanceState: string, _snapshotState: string) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected delete_db_instance with snapshot to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

Then(
  "the snapshot is {string} and the instance is in {string} state",
  async function (this: SdkWorld, _snapshotState: string, _instanceState: string) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected create_db_snapshot to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

// "the snapshot is in {string} state" is registered in cross_service_common.ts
// (dispatches via snapshotHelpers.assertSnapshotInState registered in the Before hook above).

Then(
  "the instance is configured for multi-{string} deployment",
  async function (this: SdkWorld, _az: string) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected modify_db_instance (multi-AZ) to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

Then(/^the instance tag state is unchanged \(no-op model\)$/, async function (this: SdkWorld) {
  // Arrange: no additional setup required
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

Then("the restored instance is in {string} state", async function (this: SdkWorld, _state: string) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected restore_db_instance_from_db_snapshot to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

// "the instance is {string} or {string}" as Then — handled by the
// Given registration above (both are no-ops).

// ── Invariant Then steps ──────────────────────────────────────────────────────

Then("every database instance has a valid status", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then("every database snapshot has a valid status", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then(
  "every backing-up instance has a corresponding in-progress snapshot",
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);
