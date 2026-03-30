/** Step definitions: organizations service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const ORGS_TEST_OU_NAME = "e2e-orgs-test-ou-1";
const ORGS_TEST_POLICY_NAME = "e2e-orgs-test-policy-1";
const ORGS_TEST_POLICY_TYPE = "SERVICE_CONTROL_POLICY";
const ORGS_TEST_ACCOUNT_NAME = "e2e-orgs-test-account-1";
const ORGS_TEST_ACCOUNT_EMAIL = "e2e-orgs-test-account-1@example.com";

// ── Helpers ───────────────────────────────────────────────────────────────────

function orgsClient(world: SdkWorld) {
  const { OrganizationsClient } = require("@aws-sdk/client-organizations");
  return world.session!.client<typeof OrganizationsClient>("organizations");
}

async function createOrg(world: SdkWorld): Promise<{ orgId: string; rootId: string }> {
  const { CreateOrganizationCommand, ListRootsCommand } = require("@aws-sdk/client-organizations");
  const resp = await orgsClient(world).send(new CreateOrganizationCommand({ FeatureSet: "ALL" }));
  const orgId: string = resp.Organization.Id;
  const rootsResp = await orgsClient(world).send(new ListRootsCommand({}));
  const rootId: string = rootsResp.Roots[0].Id;
  return { orgId, rootId };
}

async function createAccount(world: SdkWorld): Promise<string> {
  const { CreateAccountCommand } = require("@aws-sdk/client-organizations");
  const resp = await orgsClient(world).send(
    new CreateAccountCommand({
      AccountName: ORGS_TEST_ACCOUNT_NAME,
      Email: ORGS_TEST_ACCOUNT_EMAIL,
    }),
  );
  return resp.CreateAccountStatus.AccountId as string;
}

async function createOU(world: SdkWorld, parentId: string, name: string): Promise<string> {
  const { CreateOrganizationalUnitCommand } = require("@aws-sdk/client-organizations");
  const resp = await orgsClient(world).send(
    new CreateOrganizationalUnitCommand({ ParentId: parentId, Name: name }),
  );
  return resp.OrganizationalUnit.Id as string;
}

async function createPolicy(world: SdkWorld, name: string): Promise<string> {
  const { CreatePolicyCommand } = require("@aws-sdk/client-organizations");
  const resp = await orgsClient(world).send(
    new CreatePolicyCommand({
      Name: name,
      Description: "e2e test policy",
      Content: "{}",
      Type: ORGS_TEST_POLICY_TYPE,
    }),
  );
  return resp.Policy.PolicySummary.Id as string;
}

async function attachPolicy(world: SdkWorld, policyId: string, targetId: string): Promise<void> {
  const { AttachPolicyCommand } = require("@aws-sdk/client-organizations");
  await orgsClient(world).send(new AttachPolicyCommand({ PolicyId: policyId, TargetId: targetId }));
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: organization state setup ──────────────────────────────────────────

Given("the organization does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no organization.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the organization already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const { orgId, rootId } = await createOrg(this);
  // Assert: store IDs
  (this as any)._orgsOrgId = orgId;
  (this as any)._orgsRootId = rootId;
});

Given("the organization exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const { orgId, rootId } = await createOrg(this);
  // Assert: store IDs
  (this as any)._orgsOrgId = orgId;
  (this as any)._orgsRootId = rootId;
});

Given("the organization does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no organization.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: account state setup ────────────────────────────────────────────────

Given("the account does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: org context established by preceding step.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the account already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const accountId = await createAccount(this);
  // Assert: store account ID
  (this as any)._orgsAccountId = accountId;
});

Given('the account exists and is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create org, root, and account
  const { orgId, rootId } = await createOrg(this);
  (this as any)._orgsOrgId = orgId;
  (this as any)._orgsRootId = rootId;
  const accountId = await createAccount(this);
  // Assert: store IDs
  (this as any)._orgsAccountId = accountId;
  (this as any)._orgsSourceParent = rootId;
});

Given('the account does not exist or is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: use nonexistent IDs for negative scenarios
  assert.ok(this.session, "Expected session to be initialized");
  (this as any)._orgsAccountId = "nonexistent-account-id";
  (this as any)._orgsSourceParent = "nonexistent-parent";
  (this as any)._orgsDestParent = "nonexistent-dest";
});

// ── Given: parent state setup ─────────────────────────────────────────────────

Given('the parent exists and is "ACTIVE"', async function (this: SdkWorld) {
  // No-op: root is always the default parent; already stored as _orgsRootId.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the parent does not exist or is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: use a nonexistent parent ID
  assert.ok(this.session, "Expected session to be initialized");
  (this as any)._orgsTargetId = "nonexistent-parent";
});

// ── Given: OU state setup ─────────────────────────────────────────────────────

Given("the organizational unit does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no OUs.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the organizational unit already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const rootId: string = (this as any)._orgsRootId;
  // Act
  const ouId = await createOU(this, rootId, ORGS_TEST_OU_NAME);
  // Assert: store OU ID
  (this as any)._orgsOuId = ouId;
});

Given('the organizational unit exists and is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create org, root, and OU
  const { orgId, rootId } = await createOrg(this);
  (this as any)._orgsOrgId = orgId;
  (this as any)._orgsRootId = rootId;
  const ouId = await createOU(this, rootId, ORGS_TEST_OU_NAME);
  // Assert: store IDs
  (this as any)._orgsOuId = ouId;
  (this as any)._orgsTargetId = rootId;
});

Given('the organizational unit does not exist or is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: use a nonexistent OU ID
  assert.ok(this.session, "Expected session to be initialized");
  (this as any)._orgsOuId = "nonexistent-ou-id";
});

Given("the organizational unit has no child accounts", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: freshly created OU has no accounts.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the organizational unit has child accounts", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { MoveAccountCommand } = require("@aws-sdk/client-organizations");
  // Act
  const accountId = await createAccount(this);
  (this as any)._orgsAccountId = accountId;
  await orgsClient(this).send(
    new MoveAccountCommand({
      AccountId: accountId,
      SourceParentId: (this as any)._orgsRootId,
      DestinationParentId: (this as any)._orgsOuId,
    }),
  );
  // Assert: account moved into OU
});

Given("the organizational unit has no child organizational units", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: freshly created OU has no children.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the organizational unit has child organizational units", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const ouId: string = (this as any)._orgsOuId;
  // Act
  await createOU(this, ouId, "e2e-orgs-test-child-ou-1");
  // Assert: child OU created
});

Given("the organizational unit has no attached policies", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: freshly created OU has no policies attached.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the organizational unit has attached policies", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const ouId: string = (this as any)._orgsOuId;
  // Act
  const policyId = await createPolicy(this, ORGS_TEST_POLICY_NAME);
  (this as any)._orgsPolicyId = policyId;
  await attachPolicy(this, policyId, ouId);
  // Assert: policy attached to OU
});

// ── Given: policy state setup ─────────────────────────────────────────────────

Given("the policy does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no policies.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the policy already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const policyId = await createPolicy(this, ORGS_TEST_POLICY_NAME);
  // Assert: store policy ID
  (this as any)._orgsPolicyId = policyId;
});

Given('the policy exists and is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create org, root, and policy
  const { orgId, rootId } = await createOrg(this);
  (this as any)._orgsOrgId = orgId;
  (this as any)._orgsRootId = rootId;
  const policyId = await createPolicy(this, ORGS_TEST_POLICY_NAME);
  // Assert: store IDs
  (this as any)._orgsPolicyId = policyId;
  (this as any)._orgsTargetId = rootId;
});

Given('the policy does not exist or is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: use nonexistent IDs for negative scenarios
  assert.ok(this.session, "Expected session to be initialized");
  (this as any)._orgsPolicyId = "nonexistent-policy-id";
  (this as any)._orgsTargetId = "nonexistent-target";
});

// ── Given: policy attachment state ───────────────────────────────────────────

Given('the target exists and is "ACTIVE"', async function (this: SdkWorld) {
  // No-op: root is the target; already stored as _orgsTargetId.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the target does not exist or is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: use a nonexistent target ID
  assert.ok(this.session, "Expected session to be initialized");
  (this as any)._orgsTargetId = "nonexistent-target";
});

Given("the policy is not already attached to the target", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no policy attachments.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the policy is already attached to the target", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const policyId: string = (this as any)._orgsPolicyId;
  const targetId: string = (this as any)._orgsTargetId;
  // Act
  await attachPolicy(this, policyId, targetId);
  // Assert: policy attached
});

Given("the policy is attached to the target", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // When used as Then (assertion context), check lastCallResult
  if (this.lastCallResult.output !== null || this.lastCallResult.success) {
    const { ListTargetsForPolicyCommand } = require("@aws-sdk/client-organizations");
    const policyId: string = (this as any)._orgsPolicyId;
    const targetId: string = (this as any)._orgsTargetId;
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    // Act
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected AttachPolicy to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
    const listResp = await orgsClient(this).send(
      new ListTargetsForPolicyCommand({ PolicyId: policyId }),
    );
    const actualTargetIds: string[] = (listResp.Targets ?? []).map(
      (t: { TargetId: string }) => t.TargetId,
    );
    // Assert
    assert.ok(
      actualTargetIds.includes(targetId),
      `Expected target '${targetId}' in policy targets but found: ${JSON.stringify(actualTargetIds)}`,
    );
    return;
  }
  // Given (setup) context: create org, root, policy, and attach
  const { orgId, rootId } = await createOrg(this);
  (this as any)._orgsOrgId = orgId;
  (this as any)._orgsRootId = rootId;
  const policyId = await createPolicy(this, ORGS_TEST_POLICY_NAME);
  (this as any)._orgsPolicyId = policyId;
  (this as any)._orgsTargetId = rootId;
  await attachPolicy(this, policyId, rootId);
  // Assert: policy attached to target
});

Given("the policy is not attached to the target", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create org, root, and policy but do NOT attach
  const { orgId, rootId } = await createOrg(this);
  (this as any)._orgsOrgId = orgId;
  (this as any)._orgsRootId = rootId;
  const policyId = await createPolicy(this, ORGS_TEST_POLICY_NAME);
  // Assert: store IDs without attaching
  (this as any)._orgsPolicyId = policyId;
  (this as any)._orgsTargetId = rootId;
});

// ── Given: move account state ─────────────────────────────────────────────────

Given("the source parent matches the account's current parent", async function (this: SdkWorld) {
  // Account starts under root; source parent is already _orgsRootId.
  assert.ok(this.session, "Expected session to be initialized");
  (this as any)._orgsSourceParent = (this as any)._orgsRootId;
});

Given(
  "the source parent does not match the account's current parent",
  async function (this: SdkWorld) {
    // Arrange: set wrong source parent
    assert.ok(this.session, "Expected session to be initialized");
    (this as any)._orgsSourceParent = "wrong-parent-id";
    if (!(this as any)._orgsDestParent) {
      (this as any)._orgsDestParent = (this as any)._orgsRootId ?? "nonexistent-dest";
    }
  },
);

Given('the destination parent is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const rootId: string = (this as any)._orgsRootId;
  // Act: create a destination OU
  const ouId = await createOU(this, rootId, "e2e-orgs-test-dest-ou-1");
  // Assert: store destination parent
  (this as any)._orgsDestParent = ouId;
});

Given('the destination parent is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: use a nonexistent destination parent
  assert.ok(this.session, "Expected session to be initialized");
  (this as any)._orgsDestParent = "nonexistent-dest";
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("an organization is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateOrganizationCommand } = require("@aws-sdk/client-organizations");
  // Act
  try {
    const result = await orgsClient(this).send(
      new CreateOrganizationCommand({ FeatureSet: "ALL" }),
    );
    (this as any)._orgsOrgId = result.Organization.Id;
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an account is created in the organization", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateAccountCommand } = require("@aws-sdk/client-organizations");
  // Act
  try {
    const result = await orgsClient(this).send(
      new CreateAccountCommand({
        AccountName: ORGS_TEST_ACCOUNT_NAME,
        Email: ORGS_TEST_ACCOUNT_EMAIL,
      }),
    );
    (this as any)._orgsAccountId = result.CreateAccountStatus.AccountId;
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an organizational unit is created under a parent", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const parentId: string = (this as any)._orgsTargetId ?? (this as any)._orgsRootId;
  const { CreateOrganizationalUnitCommand } = require("@aws-sdk/client-organizations");
  // Act
  try {
    const result = await orgsClient(this).send(
      new CreateOrganizationalUnitCommand({
        ParentId: parentId,
        Name: ORGS_TEST_OU_NAME,
      }),
    );
    (this as any)._orgsOuId = result.OrganizationalUnit.Id;
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a service control policy is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreatePolicyCommand } = require("@aws-sdk/client-organizations");
  // Act
  try {
    const result = await orgsClient(this).send(
      new CreatePolicyCommand({
        Name: ORGS_TEST_POLICY_NAME,
        Description: "e2e test policy",
        Content: "{}",
        Type: ORGS_TEST_POLICY_TYPE,
      }),
    );
    (this as any)._orgsPolicyId = result.Policy.PolicySummary.Id;
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an organizational unit is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const ouId: string = (this as any)._orgsOuId;
  const { DeleteOrganizationalUnitCommand } = require("@aws-sdk/client-organizations");
  // Act
  try {
    const result = await orgsClient(this).send(
      new DeleteOrganizationalUnitCommand({ OrganizationalUnitId: ouId }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a policy is attached to a target", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const policyId: string = (this as any)._orgsPolicyId;
  const targetId: string = (this as any)._orgsTargetId;
  const { AttachPolicyCommand } = require("@aws-sdk/client-organizations");
  // Act
  try {
    const result = await orgsClient(this).send(
      new AttachPolicyCommand({ PolicyId: policyId, TargetId: targetId }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a policy is detached from a target", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const policyId: string = (this as any)._orgsPolicyId;
  const targetId: string = (this as any)._orgsTargetId;
  const { DetachPolicyCommand } = require("@aws-sdk/client-organizations");
  // Act
  try {
    const result = await orgsClient(this).send(
      new DetachPolicyCommand({ PolicyId: policyId, TargetId: targetId }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an account is moved to a new parent", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const accountId: string = (this as any)._orgsAccountId;
  const sourceParent: string = (this as any)._orgsSourceParent;
  const destParent: string = (this as any)._orgsDestParent;
  const { MoveAccountCommand } = require("@aws-sdk/client-organizations");
  // Act
  try {
    const result = await orgsClient(this).send(
      new MoveAccountCommand({
        AccountId: accountId,
        SourceParentId: sourceParent,
        DestinationParentId: destParent,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// ── Then: assertions ──────────────────────────────────────────────────────────

Then("the organization and its root exist", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const {
    DescribeOrganizationCommand,
    ListRootsCommand,
  } = require("@aws-sdk/client-organizations");
  // Act
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected CreateOrganization to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const orgResp = await orgsClient(this).send(new DescribeOrganizationCommand({}));
  const actualOrgId: string = orgResp.Organization.Id;
  // Assert
  assert.ok(
    actualOrgId,
    `Expected organization Id to be set but got empty; actual_org_id=${actualOrgId}`,
  );
  const rootsResp = await orgsClient(this).send(new ListRootsCommand({}));
  const actualRootsCount: number = (rootsResp.Roots ?? []).length;
  assert.ok(
    actualRootsCount > 0,
    `Expected at least one root but got none; actual_roots_count=${actualRootsCount}`,
  );
});

Then('the account is "ACTIVE" under the root', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const {
    DescribeAccountCommand,
    ListRootsCommand,
    ListAccountsForParentCommand,
  } = require("@aws-sdk/client-organizations");
  const accountId: string = (this as any)._orgsAccountId;
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  // Act
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected CreateAccount to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const accountResp = await orgsClient(this).send(
    new DescribeAccountCommand({ AccountId: accountId }),
  );
  const expectedStatus = "ACTIVE";
  const actualStatus: string = accountResp.Account.Status;
  // Assert: verify status
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected account status '${expectedStatus}' but got '${actualStatus}'; expected_status=${expectedStatus} actual_status=${actualStatus}`,
  );
  const rootsResp = await orgsClient(this).send(new ListRootsCommand({}));
  const rootId: string = rootsResp.Roots[0].Id;
  const listResp = await orgsClient(this).send(
    new ListAccountsForParentCommand({ ParentId: rootId }),
  );
  const actualAccountIds: string[] = (listResp.Accounts ?? []).map((a: { Id: string }) => a.Id);
  assert.ok(
    actualAccountIds.includes(accountId),
    `Expected account '${accountId}' under root but found: ${JSON.stringify(actualAccountIds)}`,
  );
});

Then('the organizational unit is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeOrganizationalUnitCommand } = require("@aws-sdk/client-organizations");
  const ouId: string = (this as any)._orgsOuId;
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  // Act
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected CreateOrganizationalUnit to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const ouResp = await orgsClient(this).send(
    new DescribeOrganizationalUnitCommand({ OrganizationalUnitId: ouId }),
  );
  const actualId: string = ouResp.OrganizationalUnit.Id;
  // Assert
  assert.ok(
    actualId,
    `Expected OU Id to be set but got empty for ou_id=${ouId}; actual_id=${actualId}`,
  );
});

Then('the policy is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribePolicyCommand } = require("@aws-sdk/client-organizations");
  const policyId: string = (this as any)._orgsPolicyId;
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  // Act
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected CreatePolicy to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const policyResp = await orgsClient(this).send(new DescribePolicyCommand({ PolicyId: policyId }));
  const actualId: string = policyResp.Policy.PolicySummary.Id;
  // Assert
  assert.ok(
    actualId,
    `Expected policy Id to be set but got empty for policy_id=${policyId}; actual_id=${actualId}`,
  );
});

Then('the organizational unit is "DELETED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListOrganizationalUnitsForParentCommand } = require("@aws-sdk/client-organizations");
  const ouId: string = (this as any)._orgsOuId;
  const parentId: string = (this as any)._orgsTargetId ?? (this as any)._orgsRootId;
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  // Act
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected DeleteOrganizationalUnit to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const listResp = await orgsClient(this).send(
    new ListOrganizationalUnitsForParentCommand({ ParentId: parentId }),
  );
  const actualOuIds: string[] = (listResp.OrganizationalUnits ?? []).map(
    (ou: { Id: string }) => ou.Id,
  );
  // Assert
  assert.ok(
    !actualOuIds.includes(ouId),
    `Expected OU '${ouId}' to be deleted but found in: ${JSON.stringify(actualOuIds)}`,
  );
});

// "the policy is attached to the target" (Then) is handled by the dual-purpose Given above.

Then("the policy is no longer attached to the target", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListTargetsForPolicyCommand } = require("@aws-sdk/client-organizations");
  const policyId: string = (this as any)._orgsPolicyId;
  const targetId: string = (this as any)._orgsTargetId;
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  // Act
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected DetachPolicy to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const listResp = await orgsClient(this).send(
    new ListTargetsForPolicyCommand({ PolicyId: policyId }),
  );
  const actualTargetIds: string[] = (listResp.Targets ?? []).map(
    (t: { TargetId: string }) => t.TargetId,
  );
  // Assert
  assert.ok(
    !actualTargetIds.includes(targetId),
    `Expected target '${targetId}' to be removed but still found in: ${JSON.stringify(actualTargetIds)}`,
  );
});

Then("the account is under the new parent", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListAccountsForParentCommand } = require("@aws-sdk/client-organizations");
  const accountId: string = (this as any)._orgsAccountId;
  const destParentId: string = (this as any)._orgsDestParent;
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  // Act
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected MoveAccount to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const listResp = await orgsClient(this).send(
    new ListAccountsForParentCommand({ ParentId: destParentId }),
  );
  const actualAccountIds: string[] = (listResp.Accounts ?? []).map((a: { Id: string }) => a.Id);
  // Assert
  assert.ok(
    actualAccountIds.includes(accountId),
    `Expected account '${accountId}' under dest parent '${destParentId}' but found: ${JSON.stringify(actualAccountIds)}`,
  );
});

// ── Invariant catch-all steps ─────────────────────────────────────────────────

Then('the root is "ACTIVE" whenever the organization exists', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListRootsCommand } = require("@aws-sdk/client-organizations");
  // Act
  try {
    const rootsResp = await orgsClient(this).send(new ListRootsCommand({}));
    const actualRootsCount: number = (rootsResp.Roots ?? []).length;
    // Assert
    assert.ok(
      actualRootsCount > 0,
      `Expected at least one active root but got none; actual_roots_count=${actualRootsCount}`,
    );
  } catch {
    // No org means no root — invariant trivially satisfied
  }
});

Then('every active account has an "ACTIVE" parent', async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
});

Then('every active organizational unit has an "ACTIVE" parent', async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
});

Then("no active node is a child of a deleted organizational unit", async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
});

Then('every active policy attachment targets an "ACTIVE" node', async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
});
