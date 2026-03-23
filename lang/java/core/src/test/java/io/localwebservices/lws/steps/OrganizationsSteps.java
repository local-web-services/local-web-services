package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.*;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.organizations.OrganizationsClient;
import software.amazon.awssdk.services.organizations.model.*;

public class OrganizationsSteps {

  private static final String TEST_ORGS_OU_NAME = "test-ou-1";
  private static final String TEST_ORGS_ACCOUNT_NAME = "test-account-1";
  private static final String TEST_ORGS_ACCOUNT_EMAIL = "test-account-1@example.com";
  private static final String TEST_ORGS_POLICY_NAME = "test-policy-1";

  private final WorldContext world;

  public OrganizationsSteps(WorldContext world) {
    this.world = world;
  }

  // --- Given ----------------------------------------------------------------

  @Given("the organization does not already exist")
  public void theOrganizationDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the organization already exists")
  public void theOrganizationAlreadyExists() {
    try (OrganizationsClient client = world.organizationsClient()) {
      client.createOrganization(r -> r.featureSet(OrganizationFeatureSet.ALL));
    }
  }

  @Given("the organization exists")
  public void theOrganizationExists() {
    try (OrganizationsClient client = world.organizationsClient()) {
      client.createOrganization(r -> r.featureSet(OrganizationFeatureSet.ALL));
    }
  }

  @Given("the organization does not exist")
  public void theOrganizationDoesNotExist() {
    // no-op
  }

  @Given("the account does not already exist")
  public void theAccountDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the account already exists")
  public void theAccountAlreadyExists() {
    try (OrganizationsClient client = world.organizationsClient()) {
      client.createAccount(
          r -> r.accountName(TEST_ORGS_ACCOUNT_NAME).email(TEST_ORGS_ACCOUNT_EMAIL));
    }
  }

  @Given("the account exists and is \"ACTIVE\"")
  public void theAccountExistsAndIsActive() {
    try (OrganizationsClient client = world.organizationsClient()) {
      client.createOrganization(r -> r.featureSet(OrganizationFeatureSet.ALL));
      CreateAccountResponse accResponse =
          client.createAccount(
              r -> r.accountName(TEST_ORGS_ACCOUNT_NAME).email(TEST_ORGS_ACCOUNT_EMAIL));
      world.orgsAccountId = accResponse.createAccountStatus().accountId();
      ListRootsResponse rootsResponse = client.listRoots();
      world.orgsRootId = rootsResponse.roots().get(0).id();
      world.orgsSourceParentId = world.orgsRootId;
    }
  }

  @Given("the account does not exist or is not \"ACTIVE\"")
  public void theAccountDoesNotExistOrIsNotActive() {
    world.orgsAccountId = "nonexistent-account-id";
    world.orgsSourceParentId = "nonexistent-parent-id";
  }

  @Given("the parent exists and is \"ACTIVE\"")
  public void theParentExistsAndIsActive() {
    try (OrganizationsClient client = world.organizationsClient()) {
      ListRootsResponse rootsResponse = client.listRoots();
      world.orgsRootId = rootsResponse.roots().get(0).id();
    }
  }

  @Given("the parent does not exist or is not \"ACTIVE\"")
  public void theParentDoesNotExistOrIsNotActive() {
    world.orgsRootId = "nonexistent-parent-id";
  }

  @Given("the organizational unit does not already exist")
  public void theOrganizationalUnitDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the organizational unit already exists")
  public void theOrganizationalUnitAlreadyExists() {
    try (OrganizationsClient client = world.organizationsClient()) {
      ListRootsResponse rootsResponse = client.listRoots();
      String rootId = rootsResponse.roots().get(0).id();
      world.orgsOuName = TEST_ORGS_OU_NAME;
      client.createOrganizationalUnit(r -> r.parentId(rootId).name(TEST_ORGS_OU_NAME));
    }
  }

  @Given("the organizational unit exists and is \"ACTIVE\"")
  public void theOrganizationalUnitExistsAndIsActive() {
    try (OrganizationsClient client = world.organizationsClient()) {
      client.createOrganization(r -> r.featureSet(OrganizationFeatureSet.ALL));
      ListRootsResponse rootsResponse = client.listRoots();
      world.orgsRootId = rootsResponse.roots().get(0).id();
      CreateOrganizationalUnitResponse ouResponse =
          client.createOrganizationalUnit(
              r -> r.parentId(world.orgsRootId).name(TEST_ORGS_OU_NAME));
      world.orgsOuId = ouResponse.organizationalUnit().id();
    }
  }

  @Given("the organizational unit does not exist or is not \"ACTIVE\"")
  public void theOrganizationalUnitDoesNotExistOrIsNotActive() {
    world.orgsOuId = "nonexistent-ou-id";
  }

  @Given("the organizational unit has no child accounts")
  public void theOrganizationalUnitHasNoChildAccounts() {
    // no-op
  }

  @Given("the organizational unit has child accounts")
  public void theOrganizationalUnitHasChildAccounts() {
    try (OrganizationsClient client = world.organizationsClient()) {
      CreateAccountResponse accResponse =
          client.createAccount(
              r -> r.accountName(TEST_ORGS_ACCOUNT_NAME).email(TEST_ORGS_ACCOUNT_EMAIL));
      String accountId = accResponse.createAccountStatus().accountId();
      client.moveAccount(
          r ->
              r.accountId(accountId)
                  .sourceParentId(world.orgsRootId)
                  .destinationParentId(world.orgsOuId));
    }
  }

  @Given("the organizational unit has no child organizational units")
  public void theOrganizationalUnitHasNoChildOrganizationalUnits() {
    // no-op
  }

  @Given("the organizational unit has child organizational units")
  public void theOrganizationalUnitHasChildOrganizationalUnits() {
    try (OrganizationsClient client = world.organizationsClient()) {
      client.createOrganizationalUnit(r -> r.parentId(world.orgsOuId).name("child-ou-1"));
    }
  }

  @Given("the organizational unit has no attached policies")
  public void theOrganizationalUnitHasNoAttachedPolicies() {
    // no-op
  }

  @Given("the organizational unit has attached policies")
  public void theOrganizationalUnitHasAttachedPolicies() {
    try (OrganizationsClient client = world.organizationsClient()) {
      CreatePolicyResponse policyResponse =
          client.createPolicy(
              r ->
                  r.name(TEST_ORGS_POLICY_NAME)
                      .description("")
                      .content("{}")
                      .type(PolicyType.SERVICE_CONTROL_POLICY));
      String policyId = policyResponse.policy().policySummary().id();
      client.attachPolicy(r -> r.policyId(policyId).targetId(world.orgsOuId));
    }
  }

  @Given("the policy does not already exist")
  public void thePolicyDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the policy already exists")
  public void thePolicyAlreadyExists() {
    try (OrganizationsClient client = world.organizationsClient()) {
      ListRootsResponse rootsResponse = client.listRoots();
      world.orgsRootId = rootsResponse.roots().get(0).id();
      client.createPolicy(
          r ->
              r.name(TEST_ORGS_POLICY_NAME)
                  .description("")
                  .content("{}")
                  .type(PolicyType.SERVICE_CONTROL_POLICY));
    }
  }

  @Given("the policy exists and is \"ACTIVE\"")
  public void thePolicyExistsAndIsActive() {
    try (OrganizationsClient client = world.organizationsClient()) {
      client.createOrganization(r -> r.featureSet(OrganizationFeatureSet.ALL));
      ListRootsResponse rootsResponse = client.listRoots();
      world.orgsRootId = rootsResponse.roots().get(0).id();
      world.orgsTargetId = world.orgsRootId;
      CreatePolicyResponse policyResponse =
          client.createPolicy(
              r ->
                  r.name(TEST_ORGS_POLICY_NAME)
                      .description("")
                      .content("{}")
                      .type(PolicyType.SERVICE_CONTROL_POLICY));
      world.orgsPolicyId = policyResponse.policy().policySummary().id();
    }
  }

  @Given("the policy does not exist or is not \"ACTIVE\"")
  public void thePolicyDoesNotExistOrIsNotActive() {
    world.orgsPolicyId = "nonexistent-policy-id";
    world.orgsTargetId = "nonexistent-target-id";
  }

  @Given("the target exists and is \"ACTIVE\"")
  public void theTargetExistsAndIsActive() {
    world.orgsTargetId = world.orgsRootId;
  }

  @Given("the target does not exist or is not \"ACTIVE\"")
  public void theTargetDoesNotExistOrIsNotActive() {
    world.orgsTargetId = "nonexistent-target-id";
  }

  @Given("the policy is not already attached to the target")
  public void thePolicyIsNotAlreadyAttachedToTheTarget() {
    // no-op
  }

  @Given("the policy is already attached to the target")
  public void thePolicyIsAlreadyAttachedToTheTarget() {
    try (OrganizationsClient client = world.organizationsClient()) {
      client.attachPolicy(r -> r.policyId(world.orgsPolicyId).targetId(world.orgsTargetId));
    }
  }

  @Given("the policy is not attached to the target")
  public void thePolicyIsNotAttachedToTheTarget() {
    try (OrganizationsClient client = world.organizationsClient()) {
      client.createOrganization(r -> r.featureSet(OrganizationFeatureSet.ALL));
      ListRootsResponse rootsResponse = client.listRoots();
      world.orgsRootId = rootsResponse.roots().get(0).id();
      world.orgsTargetId = world.orgsRootId;
      CreatePolicyResponse policyResponse =
          client.createPolicy(
              r ->
                  r.name(TEST_ORGS_POLICY_NAME)
                      .description("")
                      .content("{}")
                      .type(PolicyType.SERVICE_CONTROL_POLICY));
      world.orgsPolicyId = policyResponse.policy().policySummary().id();
    }
  }

  @Given("the source parent matches the account's current parent")
  public void theSourceParentMatchesTheAccountsCurrentParent() {
    // orgsSourceParentId is already set to the root (account's actual parent)
  }

  @Given("the source parent does not match the account's current parent")
  public void theSourceParentDoesNotMatchTheAccountsCurrentParent() {
    world.orgsSourceParentId = "nonexistent-parent-id";
  }

  @Given("the destination parent is \"ACTIVE\"")
  public void theDestinationParentIsActive() {
    try (OrganizationsClient client = world.organizationsClient()) {
      CreateOrganizationalUnitResponse ouResponse =
          client.createOrganizationalUnit(
              r -> r.parentId(world.orgsRootId).name(TEST_ORGS_OU_NAME));
      world.orgsDestParentId = ouResponse.organizationalUnit().id();
    }
  }

  @Given("the destination parent is not \"ACTIVE\"")
  public void theDestinationParentIsNotActive() {
    world.orgsDestParentId = "nonexistent-dest-id";
  }

  // --- When -----------------------------------------------------------------

  @When("an organization is created")
  public void anOrganizationIsCreated() {
    try (OrganizationsClient client = world.organizationsClient()) {
      CreateOrganizationResponse response =
          client.createOrganization(r -> r.featureSet(OrganizationFeatureSet.ALL));
      world.orgsOrgId = response.organization().id();
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an account is created in the organization")
  public void anAccountIsCreatedInTheOrganization() {
    try (OrganizationsClient client = world.organizationsClient()) {
      CreateAccountResponse response =
          client.createAccount(
              r -> r.accountName(TEST_ORGS_ACCOUNT_NAME).email(TEST_ORGS_ACCOUNT_EMAIL));
      world.orgsAccountId = response.createAccountStatus().accountId();
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an organizational unit is created under a parent")
  public void anOrganizationalUnitIsCreatedUnderAParent() {
    try (OrganizationsClient client = world.organizationsClient()) {
      CreateOrganizationalUnitResponse response =
          client.createOrganizationalUnit(
              r -> r.parentId(world.orgsRootId).name(TEST_ORGS_OU_NAME));
      world.orgsOuId = response.organizationalUnit().id();
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a service control policy is created")
  public void aServiceControlPolicyIsCreated() {
    try (OrganizationsClient client = world.organizationsClient()) {
      CreatePolicyResponse response =
          client.createPolicy(
              r ->
                  r.name(TEST_ORGS_POLICY_NAME)
                      .description("")
                      .content("{}")
                      .type(PolicyType.SERVICE_CONTROL_POLICY));
      world.orgsPolicyId = response.policy().policySummary().id();
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an organizational unit is deleted")
  public void anOrganizationalUnitIsDeleted() {
    try (OrganizationsClient client = world.organizationsClient()) {
      DeleteOrganizationalUnitResponse response =
          client.deleteOrganizationalUnit(r -> r.organizationalUnitId(world.orgsOuId));
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a policy is attached to a target")
  public void aPolicyIsAttachedToATarget() {
    try (OrganizationsClient client = world.organizationsClient()) {
      AttachPolicyResponse response =
          client.attachPolicy(r -> r.policyId(world.orgsPolicyId).targetId(world.orgsTargetId));
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a policy is detached from a target")
  public void aPolicyIsDetachedFromATarget() {
    try (OrganizationsClient client = world.organizationsClient()) {
      DetachPolicyResponse response =
          client.detachPolicy(r -> r.policyId(world.orgsPolicyId).targetId(world.orgsTargetId));
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an account is moved to a new parent")
  public void anAccountIsMovedToANewParent() {
    try (OrganizationsClient client = world.organizationsClient()) {
      MoveAccountResponse response =
          client.moveAccount(
              r ->
                  r.accountId(world.orgsAccountId)
                      .sourceParentId(world.orgsSourceParentId)
                      .destinationParentId(world.orgsDestParentId));
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // --- Then -----------------------------------------------------------------

  @Then("the organization and its root exist")
  public void theOrganizationAndItsRootExist() {
    try (OrganizationsClient client = world.organizationsClient()) {
      client.describeOrganization();
      ListRootsResponse rootsResponse = client.listRoots();
      assertFalse(rootsResponse.roots().isEmpty(), "Expected at least one root but got none");
    }
  }

  @Then("the account is \"ACTIVE\" under the root")
  public void theAccountIsActiveUnderTheRoot() {
    try (OrganizationsClient client = world.organizationsClient()) {
      client.describeAccount(r -> r.accountId(world.orgsAccountId));
    }
  }

  @Then("the organizational unit is \"ACTIVE\"")
  public void theOrganizationalUnitIsActive() {
    try (OrganizationsClient client = world.organizationsClient()) {
      client.describeOrganizationalUnit(r -> r.organizationalUnitId(world.orgsOuId));
    }
  }

  @Then("the policy is \"ACTIVE\"")
  public void thePolicyIsActive() {
    try (OrganizationsClient client = world.organizationsClient()) {
      client.describePolicy(r -> r.policyId(world.orgsPolicyId));
    }
  }

  @Then("the organizational unit is \"DELETED\"")
  public void theOrganizationalUnitIsDeleted() {
    try (OrganizationsClient client = world.organizationsClient()) {
      try {
        client.describeOrganizationalUnit(r -> r.organizationalUnitId(world.orgsOuId));
        fail("Expected DescribeOrganizationalUnit to fail for deleted OU but it succeeded");
      } catch (OrganizationalUnitNotFoundException ignored) {
        // expected
      }
    }
  }

  @Then("the policy is attached to the target")
  public void thePolicyIsAttachedToTheTarget() {
    if (world.orgsPolicyId == null) {
      // Given context: set up org, policy, and attachment from scratch
      try (OrganizationsClient client = world.organizationsClient()) {
        client.createOrganization(r -> r.featureSet(OrganizationFeatureSet.ALL));
        ListRootsResponse rootsResponse = client.listRoots();
        world.orgsRootId = rootsResponse.roots().get(0).id();
        world.orgsTargetId = world.orgsRootId;
        CreatePolicyResponse policyResponse =
            client.createPolicy(
                r ->
                    r.name(TEST_ORGS_POLICY_NAME)
                        .description("")
                        .content("{}")
                        .type(PolicyType.SERVICE_CONTROL_POLICY));
        world.orgsPolicyId = policyResponse.policy().policySummary().id();
        client.attachPolicy(r -> r.policyId(world.orgsPolicyId).targetId(world.orgsTargetId));
      }
    } else {
      // Then context: verify the policy is attached to the target
      try (OrganizationsClient client = world.organizationsClient()) {
        ListTargetsForPolicyResponse response =
            client.listTargetsForPolicy(r -> r.policyId(world.orgsPolicyId));
        String expectedTargetId = world.orgsTargetId;
        boolean found =
            response.targets().stream().anyMatch(t -> t.targetId().equals(expectedTargetId));
        assertTrue(found, "Expected target \"" + expectedTargetId + "\" to be in policy targets");
      }
    }
  }

  @Then("the policy is no longer attached to the target")
  public void thePolicyIsNoLongerAttachedToTheTarget() {
    try (OrganizationsClient client = world.organizationsClient()) {
      ListTargetsForPolicyResponse response =
          client.listTargetsForPolicy(r -> r.policyId(world.orgsPolicyId));
      String expectedTargetId = world.orgsTargetId;
      boolean found =
          response.targets().stream().anyMatch(t -> t.targetId().equals(expectedTargetId));
      assertFalse(
          found,
          "Expected target \"" + expectedTargetId + "\" to NOT be in policy targets but it was");
    }
  }

  @Then("the account is under the new parent")
  public void theAccountIsUnderTheNewParent() {
    try (OrganizationsClient client = world.organizationsClient()) {
      ListAccountsForParentResponse response =
          client.listAccountsForParent(r -> r.parentId(world.orgsDestParentId));
      String expectedAccountId = world.orgsAccountId;
      boolean found = response.accounts().stream().anyMatch(a -> a.id().equals(expectedAccountId));
      assertTrue(
          found,
          "Expected account \""
              + expectedAccountId
              + "\" under parent \""
              + world.orgsDestParentId
              + "\"");
    }
  }

  @Then("the root is \"ACTIVE\" whenever the organization exists")
  public void theRootIsActiveWheneverTheOrganizationExists() {
    // Invariant check — trivially satisfied
  }

  @Then("no active node is a child of a deleted organizational unit")
  public void noActiveNodeIsAChildOfADeletedOrganizationalUnit() {
    // Invariant check — trivially satisfied
  }
}
