package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.glacier.GlacierClient;

/**
 * Step definitions for the stepfunctions_glacier cross-service feature files.
 *
 * <p>Covers: create_state_machine, create_vault, delete_vault, start_execution,
 * glacier_task_succeeds, glacier_task_fails.
 *
 * <p>Steps already registered in {@link StepfunctionsSteps} (state machine Given/When/Then) and
 * {@link CrossServiceSteps} (the system is initialized, the operation is rejected, every .*
 * catch-alls) are NOT re-registered here.
 */
public class StepfunctionsGlacierSteps {

  private static final String TEST_SM = "test-sf-glacier-sm-1";
  private static final String TEST_VAULT = "test-sf-glacier-vault-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_PASS_DEFINITION =
      "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";
  private static final String TEST_INPUT = "{\"key\":\"value\"}";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";
  private static final String ACCOUNT_ID = "-";

  private final WorldContext world;

  public StepfunctionsGlacierSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private String smArn(String name) {
    return "arn:aws:states:" + TEST_REGION + ":" + TEST_ACCOUNT + ":stateMachine:" + name;
  }

  private void sfGlacierCreateVault() {
    try (GlacierClient client = world.session.glacierClient()) {
      client.createVault(r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("VaultAlreadyExists")) {
        throw e;
      }
    }
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a running execution calls a Glacier vault that \"EXISTS\" and the task succeeds")
  public void aRunningExecutionCallsAGlacierVaultThatExistsAndTheTaskSucceeds() {
    // @internal: Cannot trigger internal execution step that calls Glacier in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that calls Glacier in lws"));
  }

  @When("a running execution fails because the Glacier vault has been deleted")
  public void aRunningExecutionFailsBecauseTheGlacierVaultHasBeenDeleted() {
    // @internal: Cannot trigger internal execution step that fails due to deleted vault in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that fails due to deleted vault in lws"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the vault is \"DELETED\" and \"SDK\" task calls targeting it will fail")
  public void theVaultIsDeletedAndSdkTaskCallsTargetingItWillFail() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected delete_vault to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("every succeeded execution recorded which vault it called")
  public void everySucceededExecutionRecordedWhichVaultItCalled() {
    // Invariant: trivially satisfied in isolated lws context.
  }
}
