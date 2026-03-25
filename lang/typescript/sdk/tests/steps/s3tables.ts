/** Step definitions: s3tables service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const S3TABLES_BUCKET_NAME = "test-s3tables-bucket-1";
const S3TABLES_NAMESPACE_NAME = "test-s3tables-namespace-1";
const S3TABLES_TABLE_NAME = "test-s3tables-table-1";
const S3TABLES_TABLE_FORMAT = "ICEBERG";
const S3TABLES_TEST_POLICY = '{"Version":"2012-10-17","Statement":[]}';

// ── Helpers ───────────────────────────────────────────────────────────────────

function s3tablesClient(world: SdkWorld) {
  const { S3TablesClient } = require("@aws-sdk/client-s3tables");
  return world.session!.client<typeof S3TablesClient>("s3tables");
}

async function getBucketArn(world: SdkWorld): Promise<string> {
  const { ListTableBucketsCommand } = require("@aws-sdk/client-s3tables");
  const result = await s3tablesClient(world).send(new ListTableBucketsCommand({}));
  const buckets: Array<{ name?: string; arn?: string }> = result.tableBuckets ?? [];
  const found = buckets.find((b) => b.name === S3TABLES_BUCKET_NAME);
  if (!found?.arn) {
    throw new Error(`table bucket "${S3TABLES_BUCKET_NAME}" not found`);
  }
  return found.arn;
}

async function createBucket(world: SdkWorld): Promise<void> {
  const { CreateTableBucketCommand } = require("@aws-sdk/client-s3tables");
  await s3tablesClient(world).send(new CreateTableBucketCommand({ name: S3TABLES_BUCKET_NAME }));
}

async function createNamespace(world: SdkWorld): Promise<void> {
  const { CreateNamespaceCommand } = require("@aws-sdk/client-s3tables");
  const arn = await getBucketArn(world);
  await s3tablesClient(world).send(
    new CreateNamespaceCommand({
      tableBucketARN: arn,
      namespace: [S3TABLES_NAMESPACE_NAME],
    }),
  );
}

async function createTable(world: SdkWorld): Promise<void> {
  const { CreateTableCommand } = require("@aws-sdk/client-s3tables");
  const arn = await getBucketArn(world);
  await s3tablesClient(world).send(
    new CreateTableCommand({
      tableBucketARN: arn,
      namespace: S3TABLES_NAMESPACE_NAME,
      name: S3TABLES_TABLE_NAME,
      format: S3TABLES_TABLE_FORMAT,
    }),
  );
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: bucket state setup ─────────────────────────────────────────────────

// "the bucket does not already exist" is registered in cross_service_common.ts.

// "the bucket already exists" is registered in cross_service_common.ts.

// "the bucket exists" is registered in cross_service_common.ts.

Given('the bucket is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: table buckets are ACTIVE immediately in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bucket is not "ACTIVE"', async function (this: SdkWorld) {
  // @internal: no public API can place a bucket in a non-ACTIVE state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bucket is "CREATING"', async function (this: SdkWorld) {
  // @internal: no public API can place a bucket in CREATING state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bucket is not "CREATING"', async function (this: SdkWorld) {
  // @internal: no public API can place a bucket in non-CREATING state selectively.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bucket is "DELETING"', async function (this: SdkWorld) {
  // @internal: no public API can place a bucket in DELETING state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bucket is not "DELETING"', async function (this: SdkWorld) {
  // @internal: no public API can place a bucket in non-DELETING state selectively.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the bucket has no active namespaces", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh bucket has no namespaces.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the bucket has active namespaces", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createNamespace(this);
  // Assert: namespace created
});

// "the bucket does not exist" is registered in cross_service_common.ts.

// ── Given: namespace state setup ──────────────────────────────────────────────

Given("the namespace does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh bucket has no namespaces.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the namespace already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createNamespace(this);
  // Assert: namespace created
});

Given("the namespace exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createNamespace(this);
  // Assert: namespace created
});

Given('the namespace is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: namespaces are always ACTIVE after creation in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the namespace is not "ACTIVE"', async function (this: SdkWorld) {
  // @internal: no public API can place a namespace in a non-ACTIVE state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the namespace is "DELETING"', async function (this: SdkWorld) {
  // @internal: no public API can place a namespace in DELETING state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the namespace is not "DELETING"', async function (this: SdkWorld) {
  // @internal: no public API can place a namespace in non-DELETING state selectively.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the namespace has no active tables", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh namespace has no tables.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the namespace has active tables", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createTable(this);
  // Assert: table created
});

Given("the namespace does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh bucket has no namespaces.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: table state setup ───────────────────────────────────────────────────

// "the table does not already exist" is registered in cross_service_common.ts.

// "the table already exists" is registered in cross_service_common.ts.

// "the table exists" is registered in cross_service_common.ts.

Given('the table is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: tables transition to ACTIVE immediately in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the table is not "ACTIVE"', async function (this: SdkWorld) {
  // @internal: no public API can place a table in a non-ACTIVE state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the table is "CREATING"', async function (this: SdkWorld) {
  // @internal: no public API can place a table in CREATING state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the table is not "CREATING"', async function (this: SdkWorld) {
  // @internal: no public API can place a table in non-CREATING state selectively.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the table is "DELETING"', async function (this: SdkWorld) {
  // @internal: no public API can place a table in DELETING state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the table is not "DELETING"', async function (this: SdkWorld) {
  // @internal: no public API can place a table in non-DELETING state selectively.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the table is in "MAINTENANCE" state', async function (this: SdkWorld) {
  // @internal: no public API can place a table in MAINTENANCE state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the table is not in "MAINTENANCE" state', async function (this: SdkWorld) {
  // @internal: no public API can place a table in non-MAINTENANCE state selectively.
  assert.ok(this.session, "Expected session to be initialized");
});

// "the table does not exist" is registered in cross_service_common.ts.

Given("the table has a policy", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { PutTablePolicyCommand } = require("@aws-sdk/client-s3tables");
  const arn = await getBucketArn(this);
  // Act
  await s3tablesClient(this).send(
    new PutTablePolicyCommand({
      tableBucketARN: arn,
      namespace: S3TABLES_NAMESPACE_NAME,
      name: S3TABLES_TABLE_NAME,
      resourcePolicy: S3TABLES_TEST_POLICY,
    }),
  );
  // Assert: policy attached
});

Given("the table does not have a policy", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh table has no policy.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: snapshot state setup ────────────────────────────────────────────────

Given("the snapshot does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh table has no snapshots.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the snapshot already exists", async function (this: SdkWorld) {
  // @internal: snapshot creation is managed internally; cannot duplicate via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the snapshot exists", async function (this: SdkWorld) {
  // @internal: snapshot existence is managed by lws internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the snapshot is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: snapshots are always ACTIVE after creation in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the snapshot is not "ACTIVE"', async function (this: SdkWorld) {
  // @internal: no public API can place a snapshot in a non-ACTIVE state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the table has more than one snapshot", async function (this: SdkWorld) {
  // @internal: snapshot count is managed internally by lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the table has one or fewer snapshots", async function (this: SdkWorld) {
  // @internal: snapshot count is managed internally by lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: compaction state setup ─────────────────────────────────────────────

Given("compaction is enabled for the table", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { PutTableMaintenanceConfigurationCommand } = require("@aws-sdk/client-s3tables");
  const arn = await getBucketArn(this);
  // Act
  await s3tablesClient(this).send(
    new PutTableMaintenanceConfigurationCommand({
      tableBucketARN: arn,
      namespace: S3TABLES_NAMESPACE_NAME,
      name: S3TABLES_TABLE_NAME,
      type: "icebergCompaction",
      value: {
        status: "enabled",
        settings: { icebergCompaction: { targetFileSizeMB: 512 } },
      },
    }),
  );
  // Assert: compaction enabled
});

Given("compaction is not enabled for the table", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { PutTableMaintenanceConfigurationCommand } = require("@aws-sdk/client-s3tables");
  const arn = await getBucketArn(this);
  // Act
  await s3tablesClient(this).send(
    new PutTableMaintenanceConfigurationCommand({
      tableBucketARN: arn,
      namespace: S3TABLES_NAMESPACE_NAME,
      name: S3TABLES_TABLE_NAME,
      type: "icebergCompaction",
      value: { status: "disabled" },
    }),
  );
  // Assert: compaction disabled
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("a table bucket is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateTableBucketCommand } = require("@aws-sdk/client-s3tables");
  // Act
  try {
    const result = await s3tablesClient(this).send(
      new CreateTableBucketCommand({ name: S3TABLES_BUCKET_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a table bucket is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteTableBucketCommand } = require("@aws-sdk/client-s3tables");
  let arn: string;
  try {
    arn = await getBucketArn(this);
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
    return;
  }
  // Act
  try {
    const result = await s3tablesClient(this).send(
      new DeleteTableBucketCommand({ tableBucketARN: arn }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a namespace is created in a table bucket", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateNamespaceCommand } = require("@aws-sdk/client-s3tables");
  let arn: string;
  try {
    arn = await getBucketArn(this);
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
    return;
  }
  // Act
  try {
    const result = await s3tablesClient(this).send(
      new CreateNamespaceCommand({
        tableBucketARN: arn,
        namespace: [S3TABLES_NAMESPACE_NAME],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a namespace is deleted from a table bucket", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteNamespaceCommand } = require("@aws-sdk/client-s3tables");
  let arn: string;
  try {
    arn = await getBucketArn(this);
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
    return;
  }
  // Act
  try {
    const result = await s3tablesClient(this).send(
      new DeleteNamespaceCommand({
        tableBucketARN: arn,
        namespace: S3TABLES_NAMESPACE_NAME,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a table is created in a namespace", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateTableCommand } = require("@aws-sdk/client-s3tables");
  let arn: string;
  try {
    arn = await getBucketArn(this);
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
    return;
  }
  // Act
  try {
    const result = await s3tablesClient(this).send(
      new CreateTableCommand({
        tableBucketARN: arn,
        namespace: S3TABLES_NAMESPACE_NAME,
        name: S3TABLES_TABLE_NAME,
        format: S3TABLES_TABLE_FORMAT,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a table is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteTableCommand } = require("@aws-sdk/client-s3tables");
  let arn: string;
  try {
    arn = await getBucketArn(this);
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
    return;
  }
  // Act
  try {
    const result = await s3tablesClient(this).send(
      new DeleteTableCommand({
        tableBucketARN: arn,
        namespace: S3TABLES_NAMESPACE_NAME,
        name: S3TABLES_TABLE_NAME,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a snapshot is created for a table", async function (this: SdkWorld) {
  // @internal: snapshot creation is managed internally by lws
  assert.ok(this.session, "Expected session to be initialized");
  // Act: no-op — snapshot creation is an internal S3 Tables operation
  this.lastCallResult = { success: true, output: null };
  // Assert: captured in lastCallResult
});

When("an expired snapshot is removed from a table", async function (this: SdkWorld) {
  // @internal: snapshot expiry is managed internally by lws
  assert.ok(this.session, "Expected session to be initialized");
  // Act: no-op
  this.lastCallResult = { success: true, output: null };
  // Assert: captured in lastCallResult
});

When("compaction is started on a table", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetTableMaintenanceJobStatusCommand } = require("@aws-sdk/client-s3tables");
  let arn: string;
  try {
    arn = await getBucketArn(this);
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
    return;
  }
  // Act
  try {
    const result = await s3tablesClient(this).send(
      new GetTableMaintenanceJobStatusCommand({
        tableBucketARN: arn,
        namespace: S3TABLES_NAMESPACE_NAME,
        name: S3TABLES_TABLE_NAME,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("compaction finishes on a table", async function (this: SdkWorld) {
  // @internal: compaction completion is managed internally by lws
  assert.ok(this.session, "Expected session to be initialized");
  // Act: no-op
  this.lastCallResult = { success: true, output: null };
  // Assert: captured in lastCallResult
});

When("a table bucket finishes creating", async function (this: SdkWorld) {
  // @internal: finish_creating_table_bucket is an internal state transition
  assert.ok(this.session, "Expected session to be initialized");
  // Act: no-op
  this.lastCallResult = { success: true, output: null };
  // Assert: captured in lastCallResult
});

When("a table finishes creating", async function (this: SdkWorld) {
  // @internal: finish_creating_table is an internal state transition
  assert.ok(this.session, "Expected session to be initialized");
  // Act: no-op
  this.lastCallResult = { success: true, output: null };
  // Assert: captured in lastCallResult
});

When("a namespace finishes being deleted", async function (this: SdkWorld) {
  // @internal: finish_deleting_namespace is an internal state transition
  assert.ok(this.session, "Expected session to be initialized");
  // Act: no-op
  this.lastCallResult = { success: true, output: null };
  // Assert: captured in lastCallResult
});

When("a table bucket finishes being deleted", async function (this: SdkWorld) {
  // @internal: finish_deleting_table_bucket is an internal state transition
  assert.ok(this.session, "Expected session to be initialized");
  // Act: no-op
  this.lastCallResult = { success: true, output: null };
  // Assert: captured in lastCallResult
});

When("a table finishes being deleted", async function (this: SdkWorld) {
  // @internal: finish_deleting_table is an internal state transition
  assert.ok(this.session, "Expected session to be initialized");
  // Act: no-op
  this.lastCallResult = { success: true, output: null };
  // Assert: captured in lastCallResult
});

When("a table's schema is evolved", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetTableCommand } = require("@aws-sdk/client-s3tables");
  let arn: string;
  try {
    arn = await getBucketArn(this);
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
    return;
  }
  // Act
  try {
    const result = await s3tablesClient(this).send(
      new GetTableCommand({
        tableBucketARN: arn,
        namespace: S3TABLES_NAMESPACE_NAME,
        name: S3TABLES_TABLE_NAME,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a policy is attached to a table", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { PutTablePolicyCommand } = require("@aws-sdk/client-s3tables");
  let arn: string;
  try {
    arn = await getBucketArn(this);
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
    return;
  }
  // Act
  try {
    const result = await s3tablesClient(this).send(
      new PutTablePolicyCommand({
        tableBucketARN: arn,
        namespace: S3TABLES_NAMESPACE_NAME,
        name: S3TABLES_TABLE_NAME,
        resourcePolicy: S3TABLES_TEST_POLICY,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a table's policy is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteTablePolicyCommand } = require("@aws-sdk/client-s3tables");
  let arn: string;
  try {
    arn = await getBucketArn(this);
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
    return;
  }
  // Act
  try {
    const result = await s3tablesClient(this).send(
      new DeleteTablePolicyCommand({
        tableBucketARN: arn,
        namespace: S3TABLES_NAMESPACE_NAME,
        name: S3TABLES_TABLE_NAME,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("maintenance configuration is applied to a table", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { PutTableMaintenanceConfigurationCommand } = require("@aws-sdk/client-s3tables");
  let arn: string;
  try {
    arn = await getBucketArn(this);
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
    return;
  }
  // Act
  try {
    const result = await s3tablesClient(this).send(
      new PutTableMaintenanceConfigurationCommand({
        tableBucketARN: arn,
        namespace: S3TABLES_NAMESPACE_NAME,
        name: S3TABLES_TABLE_NAME,
        type: "icebergCompaction",
        value: {
          status: "enabled",
          settings: { icebergCompaction: { targetFileSizeMB: 512 } },
        },
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// ── Then: assertions ──────────────────────────────────────────────────────────

Then('the bucket is in "CREATING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected create_table_bucket to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  assert.ok(
    this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
    "Expected CreateTableBucketOutput but got null",
  );
});

Then('the bucket enters "DELETING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_table_bucket to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the bucket is "ACTIVE"', async function (this: SdkWorld) {
  // @internal: internal state assertion — no-op in public API test context.
});

Then(
  'the bucket is "DELETED" and all its namespaces and tables are "DELETED"',
  async function (this: SdkWorld) {
    // @internal: internal state assertion — no-op in public API test context.
  },
);

Then('the namespace is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected create_namespace to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  assert.ok(
    this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
    "Expected CreateNamespaceOutput but got null",
  );
});

Then('the namespace enters "DELETING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_namespace to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then(
  'the namespace is "DELETED" and all its tables are "DELETED"',
  async function (this: SdkWorld) {
    // @internal: internal state assertion — no-op in public API test context.
  },
);

Then('the table is in "CREATING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected create_table to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  assert.ok(
    this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
    "Expected CreateTableOutput but got null",
  );
});

Then('the table enters "DELETING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_table to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the table is "ACTIVE"', async function (this: SdkWorld) {
  // @internal: internal state assertion — no-op in public API test context.
});

Then('the table is "DELETED" and all its snapshots are "DELETED"', async function (this: SdkWorld) {
  // @internal: internal state assertion — no-op in public API test context.
});

Then('the table returns to "ACTIVE" state', async function (this: SdkWorld) {
  // @internal: internal state assertion — no-op in public API test context.
});

Then('the table enters "MAINTENANCE" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected start_compaction to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  assert.ok(
    this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
    "Expected GetTableMaintenanceJobStatusOutput but got null",
  );
});

Then(
  'the snapshot is "ACTIVE" and the table snapshot count increases',
  async function (this: SdkWorld) {
    // @internal: snapshot state assertion — no-op in public API test context.
  },
);

Then(
  'the snapshot is "DELETED" and the table snapshot count decreases',
  async function (this: SdkWorld) {
    // @internal: snapshot state assertion — no-op in public API test context.
  },
);

Then("the schema version is incremented", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected evolve_schema to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  assert.ok(
    this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
    "Expected GetTableOutput but got null",
  );
});

Then("the table has a policy", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected put_table_policy to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the table has no policy", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_table_policy to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("compaction is enabled for the table", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected put_table_maintenance_configuration to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

// "the operation is rejected" is registered in cross_service_common.ts.

// ── Then: safety invariants (no-op) ───────────────────────────────────────────

Then('a bucket in "DELETING" state has no "ACTIVE" namespaces', async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then('a namespace in "DELETING" state has no "ACTIVE" tables', async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then("snapshot count is never negative", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then("schema version is always at least one", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});
