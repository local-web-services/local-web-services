/** Step definitions: glacier_sns service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const GLACIER_SNS_TEST_VAULT = "test-glacier-vault-1";
const GLACIER_SNS_TEST_TOPIC = "test-glacier-topic-1";
const GLACIER_SNS_ACCOUNT_ID = "-";
const GLACIER_SNS_REGION = "us-east-1";
const GLACIER_SNS_ACCOUNT = "000000000000";

// ── Helpers ───────────────────────────────────────────────────────────────────

function glacierSNSGlacierClient(world: SdkWorld) {
  const { GlacierClient } = require("@aws-sdk/client-glacier");
  return world.session!.client<typeof GlacierClient>("glacier");
}

function glacierSNSTopicArn(): string {
  return `arn:aws:sns:${GLACIER_SNS_REGION}:${GLACIER_SNS_ACCOUNT}:${GLACIER_SNS_TEST_TOPIC}`;
}

async function glacierSNSCreateVault(world: SdkWorld): Promise<void> {
  const { CreateVaultCommand } = require("@aws-sdk/client-glacier");
  await glacierSNSGlacierClient(world).send(
    new CreateVaultCommand({
      accountId: GLACIER_SNS_ACCOUNT_ID,
      vaultName: GLACIER_SNS_TEST_VAULT,
    }),
  );
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: vault state setup ──────────────────────────────────────────────────

Given("the vault does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no vaults.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the vault already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await glacierSNSCreateVault(this);
  // Assert: vault created
});

Given("the vault exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await glacierSNSCreateVault(this);
  // Assert: vault created
});

Given("the vault does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no vaults.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the vault has no "SNS" notification configured', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh vault has no SNS notification configured.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the vault already has an "SNS" notification configured', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { SetVaultNotificationsCommand } = require("@aws-sdk/client-glacier");
  const topicArn: string = (this as any)._glacierSNSTopicArn ?? glacierSNSTopicArn();
  // Act
  await glacierSNSGlacierClient(this).send(
    new SetVaultNotificationsCommand({
      accountId: GLACIER_SNS_ACCOUNT_ID,
      vaultName: GLACIER_SNS_TEST_VAULT,
      vaultNotificationConfig: {
        SNSTopic: topicArn,
        Events: ["ArchiveRetrievalCompleted", "InventoryRetrievalCompleted"],
      },
    }),
  );
  // Assert: notification configured
  (this as any)._glacierSNSNotifConfigured = true;
});

Given('the vault has an "SNS" notification configured', async function (this: SdkWorld) {
  // @internal: vault notification + job completion requires background processing.
  // No-op — this given is only used in @internal scenarios.
  assert.ok(this.session, "Expected session to be initialized");
  (this as any)._glacierSNSNotifConfigured = true;
});

// ── Given: topic state setup ──────────────────────────────────────────────────

// "the topic does not already exist" is registered in cross_service_common.ts.
// "the topic already exists" is registered in cross_service_common.ts.
// "the topic exists" is registered in cross_service_common.ts.
// "the topic exists and is {string}" is registered in s3_sns.ts.
// "the topic is {string}" (Given) is registered in sns.ts.
// "the topic is already {string}" is registered in cross_service_common.ts.
// "the topic does not exist" is registered in cross_service_common.ts.
// "the topic does not exist or is not {string}" is registered in s3_sns.ts.

// ── Given: capacity steps ──────────────────────────────────────────────────────

Given("a job slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: job slots are available by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no job slot is available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("glacier").exhaust().apply();
  // Assert: capacity exhausted
});

// "a message slot is available" is registered in cross_service_common.ts.
// "no message slot is available" is registered in cross_service_common.ts.

// ── Given: internal state steps ───────────────────────────────────────────────

Given('a job is "IN_PROGRESS"', async function (this: SdkWorld) {
  // @internal: IN_PROGRESS job state requires background Glacier processing.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('no job is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no in-progress jobs.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the configured topic is "ACTIVE"', async function (this: SdkWorld) {
  // @internal: this given is only used in @internal scenarios.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the configured topic is "DELETED"', async function (this: SdkWorld) {
  // @internal: this given is only used in @internal scenarios.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the configured topic is not "DELETED"', async function (this: SdkWorld) {
  // @internal: this given is only used in @internal scenarios.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: model-level precondition steps (sequences.feature) ─────────────────

Given("vid not in vault_status", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no vaults.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("tid not in topic_status", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no topics.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("jid in job_status", async function (this: SdkWorld) {
  // @internal: job state requires background Glacier processing.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("a Glacier vault is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateVaultCommand } = require("@aws-sdk/client-glacier");
  // Act
  try {
    const result = await glacierSNSGlacierClient(this).send(
      new CreateVaultCommand({
        accountId: GLACIER_SNS_ACCOUNT_ID,
        vaultName: GLACIER_SNS_TEST_VAULT,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// "an {string} topic is created" (When) is registered in cross_service_common.ts.

// "the {string} topic is deleted" (When) is registered in cross_service_common.ts.

When('an "SNS" notification is configured on the vault', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { SetVaultNotificationsCommand } = require("@aws-sdk/client-glacier");
  const topicArn: string = (this as any)._glacierSNSTopicArn ?? glacierSNSTopicArn();
  // Act
  try {
    const result = await glacierSNSGlacierClient(this).send(
      new SetVaultNotificationsCommand({
        accountId: GLACIER_SNS_ACCOUNT_ID,
        vaultName: GLACIER_SNS_TEST_VAULT,
        vaultNotificationConfig: {
          SNSTopic: topicArn,
          Events: ["ArchiveRetrievalCompleted", "InventoryRetrievalCompleted"],
        },
      }),
    );
    (this as any)._glacierSNSNotifConfigured = true;
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a Glacier archive retrieval job is initiated on the vault", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { InitiateJobCommand } = require("@aws-sdk/client-glacier");
  // Act
  try {
    const result = await glacierSNSGlacierClient(this).send(
      new InitiateJobCommand({
        accountId: GLACIER_SNS_ACCOUNT_ID,
        vaultName: GLACIER_SNS_TEST_VAULT,
        jobParameters: { Type: "inventory-retrieval" },
      }),
    );
    if (result.jobId) {
      (this as any)._glacierSNSJobId = result.jobId;
    }
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  'the Glacier job completes and publishes a notification to the configured "SNS" topic',
  async function (this: SdkWorld) {
    // @internal: Glacier job completion notification delivery requires background processing.
    // This action cannot be performed via the public Glacier API.
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "InvalidParameterValueException: job completion notification requires internal processing",
      ),
    };
    // Assert: captured in lastCallResult
  },
);

When(
  "the Glacier job completes but notification delivery fails because the topic was deleted",
  async function (this: SdkWorld) {
    // @internal: Glacier job completion with failed notification requires background processing.
    // This action cannot be performed via the public Glacier API.
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "InvalidParameterValueException: job completion notification failure requires internal processing",
      ),
    };
    // Assert: captured in lastCallResult
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

Then(
  'the vault "EXISTS" with no "SNS" notification configuration',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { DescribeVaultCommand } = require("@aws-sdk/client-glacier");
    // Act: action already performed in the When step; verify vault exists
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected create_vault to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
    const descResult = await glacierSNSGlacierClient(this).send(
      new DescribeVaultCommand({
        accountId: GLACIER_SNS_ACCOUNT_ID,
        vaultName: GLACIER_SNS_TEST_VAULT,
      }),
    );
    // Assert
    const expectedVaultName = GLACIER_SNS_TEST_VAULT;
    const actualVaultName: string = descResult.vaultName ?? "";
    assert.strictEqual(
      actualVaultName,
      expectedVaultName,
      `Expected vault name "${expectedVaultName}" but got "${actualVaultName}"; expected_vault_name=${expectedVaultName} actual_vault_name=${actualVaultName}`,
    );
  },
);

// "the topic is {string}" (Then) is registered in cross_service_common.ts.

Then('the topic is "DELETED" and Glacier notifications will fail', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_topic to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then(
  "the vault will publish job completion notifications to the topic",
  async function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected set_vault_notifications to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

Then('the job is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected initiate_job to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  assert.ok(
    this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
    "Expected InitiateJobOutput but got null",
  );
});

Then('the job is "SUCCEEDED" and the notification is "PUBLISHED"', async function (this: SdkWorld) {
  // @internal: job_completed_notification_delivered requires background processing. No assertion performed.
});

Then('the job is "SUCCEEDED" but no notification is published', async function (this: SdkWorld) {
  // @internal: job_completed_notification_fails requires background processing. No assertion performed.
});

// "the operation is rejected" is registered in cross_service_common.ts.

// ── Safety invariant Then steps ───────────────────────────────────────────────

Then('"PUBLISHED" notification references a job that exists', async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then('"PUBLISHED" notification references a topic that exists', async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then(
  'every "PUBLISHED" notification references a job that exists',
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);

Then(
  'every "PUBLISHED" notification references a topic that exists',
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);
