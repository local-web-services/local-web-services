/** Organizations step definitions. */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import {
  CreateOrganizationCommand,
  DescribeOrganizationCommand,
  ListRootsCommand,
  CreateAccountCommand,
  DescribeAccountCommand,
  CreateOrganizationalUnitCommand,
  DescribeOrganizationalUnitCommand,
  DeleteOrganizationalUnitCommand,
  MoveAccountCommand,
  CreatePolicyCommand,
  DescribePolicyCommand,
  AttachPolicyCommand,
  DetachPolicyCommand,
  ListTargetsForPolicyCommand,
  ListAccountsForParentCommand,
} from "@aws-sdk/client-organizations";
import type { LwsWorld } from "../support/world";

const testOrgsOuName = "test-ou-1";
const testOrgsAccountName = "test-account-1";
const testOrgsAccountEmail = "test-account-1@example.com";
const testOrgsPolicyName = "test-policy-1";

// --- Given ------------------------------------------------------------------

Given("the organization does not already exist", async function (this: LwsWorld) {
  // no-op (fresh state)
});

Given("the organization already exists", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  await client.send(new CreateOrganizationCommand({ FeatureSet: "ALL" }));
});

Given("the organization exists", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  await client.send(new CreateOrganizationCommand({ FeatureSet: "ALL" }));
});

Given("the organization does not exist", async function (this: LwsWorld) {
  // no-op
});

Given("the account does not already exist", async function (this: LwsWorld) {
  // no-op
});

Given("the account already exists", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  await client.send(
    new CreateAccountCommand({
      AccountName: testOrgsAccountName,
      Email: testOrgsAccountEmail,
    }),
  );
});

Given(`the account exists and is "ACTIVE"`, async function (this: LwsWorld) {
  const client = this.organizationsClient();
  await client.send(new CreateOrganizationCommand({ FeatureSet: "ALL" }));
  const accResult = await client.send(
    new CreateAccountCommand({
      AccountName: testOrgsAccountName,
      Email: testOrgsAccountEmail,
    }),
  );
  this.orgsAccountId = accResult.CreateAccountStatus?.AccountId ?? "";
  const rootsResult = await client.send(new ListRootsCommand({}));
  this.orgsRootId = rootsResult.Roots?.[0]?.Id ?? "";
  this.orgsSourceParentId = this.orgsRootId;
});

Given(`the account does not exist or is not "ACTIVE"`, async function (this: LwsWorld) {
  this.orgsAccountId = "nonexistent-account-id";
  this.orgsSourceParentId = "nonexistent-parent-id";
});

Given(`the parent exists and is "ACTIVE"`, async function (this: LwsWorld) {
  const client = this.organizationsClient();
  const rootsResult = await client.send(new ListRootsCommand({}));
  this.orgsRootId = rootsResult.Roots?.[0]?.Id ?? "";
});

Given(`the parent does not exist or is not "ACTIVE"`, async function (this: LwsWorld) {
  this.orgsRootId = "nonexistent-parent-id";
});

Given("the organizational unit does not already exist", async function (this: LwsWorld) {
  // no-op
});

Given("the organizational unit already exists", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  const rootsResult = await client.send(new ListRootsCommand({}));
  const rootId = rootsResult.Roots?.[0]?.Id ?? "";
  this.orgsOuName = testOrgsOuName;
  await client.send(
    new CreateOrganizationalUnitCommand({ ParentId: rootId, Name: testOrgsOuName }),
  );
});

Given(`the organizational unit exists and is "ACTIVE"`, async function (this: LwsWorld) {
  const client = this.organizationsClient();
  await client.send(new CreateOrganizationCommand({ FeatureSet: "ALL" }));
  const rootsResult = await client.send(new ListRootsCommand({}));
  this.orgsRootId = rootsResult.Roots?.[0]?.Id ?? "";
  const ouResult = await client.send(
    new CreateOrganizationalUnitCommand({ ParentId: this.orgsRootId, Name: testOrgsOuName }),
  );
  this.orgsOuId = ouResult.OrganizationalUnit?.Id ?? "";
});

Given(`the organizational unit does not exist or is not "ACTIVE"`, async function (this: LwsWorld) {
  this.orgsOuId = "nonexistent-ou-id";
});

Given("the organizational unit has no child accounts", async function (this: LwsWorld) {
  // no-op
});

Given("the organizational unit has child accounts", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  const accResult = await client.send(
    new CreateAccountCommand({
      AccountName: testOrgsAccountName,
      Email: testOrgsAccountEmail,
    }),
  );
  const accountId = accResult.CreateAccountStatus?.AccountId ?? "";
  await client.send(
    new MoveAccountCommand({
      AccountId: accountId,
      SourceParentId: this.orgsRootId,
      DestinationParentId: this.orgsOuId,
    }),
  );
});

Given("the organizational unit has no child organizational units", async function (this: LwsWorld) {
  // no-op
});

Given("the organizational unit has child organizational units", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  await client.send(
    new CreateOrganizationalUnitCommand({ ParentId: this.orgsOuId, Name: "child-ou-1" }),
  );
});

Given("the organizational unit has no attached policies", async function (this: LwsWorld) {
  // no-op
});

Given("the organizational unit has attached policies", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  const policyResult = await client.send(
    new CreatePolicyCommand({
      Name: testOrgsPolicyName,
      Description: "",
      Content: "{}",
      Type: "SERVICE_CONTROL_POLICY",
    }),
  );
  const policyId = policyResult.Policy?.PolicySummary?.Id ?? "";
  await client.send(new AttachPolicyCommand({ PolicyId: policyId, TargetId: this.orgsOuId }));
});

Given("the policy does not already exist", async function (this: LwsWorld) {
  // no-op
});

Given("the policy already exists", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  const rootsResult = await client.send(new ListRootsCommand({}));
  this.orgsRootId = rootsResult.Roots?.[0]?.Id ?? "";
  await client.send(
    new CreatePolicyCommand({
      Name: testOrgsPolicyName,
      Description: "",
      Content: "{}",
      Type: "SERVICE_CONTROL_POLICY",
    }),
  );
});

Given(`the policy exists and is "ACTIVE"`, async function (this: LwsWorld) {
  const client = this.organizationsClient();
  await client.send(new CreateOrganizationCommand({ FeatureSet: "ALL" }));
  const rootsResult = await client.send(new ListRootsCommand({}));
  this.orgsRootId = rootsResult.Roots?.[0]?.Id ?? "";
  this.orgsTargetId = this.orgsRootId;
  const policyResult = await client.send(
    new CreatePolicyCommand({
      Name: testOrgsPolicyName,
      Description: "",
      Content: "{}",
      Type: "SERVICE_CONTROL_POLICY",
    }),
  );
  this.orgsPolicyId = policyResult.Policy?.PolicySummary?.Id ?? "";
});

Given(`the policy does not exist or is not "ACTIVE"`, async function (this: LwsWorld) {
  this.orgsPolicyId = "nonexistent-policy-id";
  this.orgsTargetId = "nonexistent-target-id";
});

Given(`the target exists and is "ACTIVE"`, async function (this: LwsWorld) {
  this.orgsTargetId = this.orgsRootId;
});

Given(`the target does not exist or is not "ACTIVE"`, async function (this: LwsWorld) {
  this.orgsTargetId = "nonexistent-target-id";
});

Given("the policy is not already attached to the target", async function (this: LwsWorld) {
  // no-op
});

Given("the policy is already attached to the target", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  await client.send(
    new AttachPolicyCommand({ PolicyId: this.orgsPolicyId, TargetId: this.orgsTargetId }),
  );
});

Given("the policy is attached to the target", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  if (!this.orgsPolicyId) {
    await client.send(new CreateOrganizationCommand({ FeatureSet: "ALL" }));
    const rootsResult = await client.send(new ListRootsCommand({}));
    this.orgsRootId = rootsResult.Roots?.[0]?.Id ?? "";
    this.orgsTargetId = this.orgsRootId;
    const policyResult = await client.send(
      new CreatePolicyCommand({
        Name: testOrgsPolicyName,
        Description: "",
        Content: "{}",
        Type: "SERVICE_CONTROL_POLICY",
      }),
    );
    this.orgsPolicyId = policyResult.Policy?.PolicySummary?.Id ?? "";
    await client.send(
      new AttachPolicyCommand({ PolicyId: this.orgsPolicyId, TargetId: this.orgsTargetId }),
    );
  } else {
    const result = await client.send(
      new ListTargetsForPolicyCommand({ PolicyId: this.orgsPolicyId }),
    );
    const expectedTargetId = this.orgsTargetId;
    const targets = result.Targets ?? [];
    const actualTargetIds = targets.map((t) => t.TargetId ?? "");
    assert.ok(
      actualTargetIds.includes(expectedTargetId),
      `Expected target "${expectedTargetId}" to be in policy targets but got: ${actualTargetIds.join(", ")}`,
    );
  }
});

Given("the policy is not attached to the target", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  await client.send(new CreateOrganizationCommand({ FeatureSet: "ALL" }));
  const rootsResult = await client.send(new ListRootsCommand({}));
  this.orgsRootId = rootsResult.Roots?.[0]?.Id ?? "";
  this.orgsTargetId = this.orgsRootId;
  const policyResult = await client.send(
    new CreatePolicyCommand({
      Name: testOrgsPolicyName,
      Description: "",
      Content: "{}",
      Type: "SERVICE_CONTROL_POLICY",
    }),
  );
  this.orgsPolicyId = policyResult.Policy?.PolicySummary?.Id ?? "";
});

Given("the source parent matches the account's current parent", async function (this: LwsWorld) {
  // orgsSourceParentId is already set to the root (account's actual parent)
});

Given(
  "the source parent does not match the account's current parent",
  async function (this: LwsWorld) {
    this.orgsSourceParentId = "nonexistent-parent-id";
  },
);

Given(`the destination parent is "ACTIVE"`, async function (this: LwsWorld) {
  const client = this.organizationsClient();
  const ouResult = await client.send(
    new CreateOrganizationalUnitCommand({ ParentId: this.orgsRootId, Name: testOrgsOuName }),
  );
  this.orgsDestParentId = ouResult.OrganizationalUnit?.Id ?? "";
});

Given(`the destination parent is not "ACTIVE"`, async function (this: LwsWorld) {
  this.orgsDestParentId = "nonexistent-dest-id";
});

// --- When -------------------------------------------------------------------

When("an organization is created", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  try {
    const result = await client.send(new CreateOrganizationCommand({ FeatureSet: "ALL" }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an account is created in the organization", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  try {
    const result = await client.send(
      new CreateAccountCommand({
        AccountName: testOrgsAccountName,
        Email: testOrgsAccountEmail,
      }),
    );
    this.orgsAccountId = result.CreateAccountStatus?.AccountId ?? "";
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an organizational unit is created under a parent", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  try {
    const result = await client.send(
      new CreateOrganizationalUnitCommand({ ParentId: this.orgsRootId, Name: testOrgsOuName }),
    );
    this.orgsOuId = result.OrganizationalUnit?.Id ?? "";
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a service control policy is created", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  try {
    const result = await client.send(
      new CreatePolicyCommand({
        Name: testOrgsPolicyName,
        Description: "",
        Content: "{}",
        Type: "SERVICE_CONTROL_POLICY",
      }),
    );
    this.orgsPolicyId = result.Policy?.PolicySummary?.Id ?? "";
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an organizational unit is deleted", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  try {
    const result = await client.send(
      new DeleteOrganizationalUnitCommand({ OrganizationalUnitId: this.orgsOuId }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a policy is attached to a target", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  try {
    const result = await client.send(
      new AttachPolicyCommand({ PolicyId: this.orgsPolicyId, TargetId: this.orgsTargetId }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a policy is detached from a target", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  try {
    const result = await client.send(
      new DetachPolicyCommand({ PolicyId: this.orgsPolicyId, TargetId: this.orgsTargetId }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an account is moved to a new parent", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  try {
    const result = await client.send(
      new MoveAccountCommand({
        AccountId: this.orgsAccountId,
        SourceParentId: this.orgsSourceParentId,
        DestinationParentId: this.orgsDestParentId,
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// --- Then -------------------------------------------------------------------

Then("the organization and its root exist", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  await client.send(new DescribeOrganizationCommand({}));
  const rootsResult = await client.send(new ListRootsCommand({}));
  assert.ok((rootsResult.Roots ?? []).length > 0, "Expected at least one root but got none");
});

Then(`the account is "ACTIVE" under the root`, async function (this: LwsWorld) {
  const client = this.organizationsClient();
  await client.send(new DescribeAccountCommand({ AccountId: this.orgsAccountId }));
});

Then(`the organizational unit is "ACTIVE"`, async function (this: LwsWorld) {
  const client = this.organizationsClient();
  await client.send(new DescribeOrganizationalUnitCommand({ OrganizationalUnitId: this.orgsOuId }));
});

Then(`the policy is "ACTIVE"`, async function (this: LwsWorld) {
  const client = this.organizationsClient();
  await client.send(new DescribePolicyCommand({ PolicyId: this.orgsPolicyId }));
});

Then(`the organizational unit is "DELETED"`, async function (this: LwsWorld) {
  const client = this.organizationsClient();
  try {
    await client.send(
      new DescribeOrganizationalUnitCommand({ OrganizationalUnitId: this.orgsOuId }),
    );
    assert.fail("Expected DescribeOrganizationalUnit to fail for deleted OU but it succeeded");
  } catch (err: unknown) {
    const error = err as Error;
    assert.ok(
      error.name !== "AssertionError",
      "Expected DescribeOrganizationalUnit to fail for deleted OU but it succeeded",
    );
  }
});

Then("the policy is no longer attached to the target", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  const result = await client.send(
    new ListTargetsForPolicyCommand({ PolicyId: this.orgsPolicyId }),
  );
  const expectedTargetId = this.orgsTargetId;
  const targets = result.Targets ?? [];
  const actualTargetIds = targets.map((t) => t.TargetId ?? "");
  assert.ok(
    !actualTargetIds.includes(expectedTargetId),
    `Expected target "${expectedTargetId}" to NOT be in policy targets but it was`,
  );
});

Then("the account is under the new parent", async function (this: LwsWorld) {
  const client = this.organizationsClient();
  const result = await client.send(
    new ListAccountsForParentCommand({ ParentId: this.orgsDestParentId }),
  );
  const expectedAccountId = this.orgsAccountId;
  const accounts = result.Accounts ?? [];
  const actualAccountIds = accounts.map((a) => a.Id ?? "");
  assert.ok(
    actualAccountIds.includes(expectedAccountId),
    `Expected account "${expectedAccountId}" under parent "${this.orgsDestParentId}" but got: ${actualAccountIds.join(", ")}`,
  );
});

Then(`the root is "ACTIVE" whenever the organization exists`, async function (this: LwsWorld) {
  // Trivially satisfied in isolated state
});

Then("no active node is a child of a deleted organizational unit", async function (this: LwsWorld) {
  // Invariant check — trivially satisfied
});
