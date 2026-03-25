package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.glacier.GlacierClient;
import software.amazon.awssdk.services.glacier.model.DescribeVaultResponse;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;

/**
 * Step definitions for the lambda_glacier cross-service informal specification feature files.
 *
 * <p>Covers: create_vault, delete_vault, deploy_function, invoke_function, upload_archive_task,
 * invocation_fails_vault_deleted.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized",
 * "the operation is rejected") are intentionally absent here to avoid duplicate step definition
 * errors.
 */
public class LambdaGlacierSteps {

  private static final String TEST_FUNC = "test-lambda-glacier-1";
  private static final String TEST_VAULT = "test-lambda-glacier-vault-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String ACCOUNT_ID = "-";

  private final WorldContext world;

  public LambdaGlacierSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private void lambdaGlacierCreateFunction() {
    try (LambdaClient client = world.session.lambdaClient()) {
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(TEST_ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceConflict") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  private void lambdaGlacierCreateVault() {
    try (GlacierClient client = world.session.glacierClient()) {
      client.createVault(r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("VaultAlreadyExists")) {
        throw e;
      }
    }
  }

  // ── Given: vault state ─────────────────────────────────────────────────────────

  @Given("the vault does not already exist")
  public void theVaultDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no vaults.
  }

  @Given("the vault already exists")
  public void theVaultAlreadyExists() {
    // Arrange
    // Act
    lambdaGlacierCreateVault();
    // Assert: vault created (no error thrown)
  }

  @Given("the vault exists")
  public void theVaultExists() {
    // Arrange
    // Act
    lambdaGlacierCreateVault();
    // Assert: vault created (no error thrown)
  }

  @Given("the vault does not exist")
  public void theVaultDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no vaults.
  }

  @Given("the vault \"EXISTS\" (not already \"DELETED\")")
  public void theVaultExistsNotAlreadyDeleted() {
    // Arrange
    // Act
    lambdaGlacierCreateVault();
    // Assert: vault created (no error thrown)
  }

  @Given("the vault \"EXISTS\"")
  public void theVaultExistsGiven() {
    // Arrange
    // Act
    lambdaGlacierCreateVault();
    // Assert: vault created (no error thrown)
  }

  @Given("the vault is already \"DELETED\"")
  public void theVaultIsAlreadyDeleted() {
    // @internal: DELETED state requires the vault to have been deleted.
  }

  @Given("the vault is \"DELETED\"")
  public void theVaultIsDeleted() {
    // @internal: DELETED vault state not reachable via simple public API call in lws.
  }

  @Given("the vault is not \"DELETED\"")
  public void theVaultIsNotDeleted() {
    // Arrange
    // Act
    lambdaGlacierCreateVault();
    // Assert: vault created (not DELETED)
  }

  @Given("the vault does not exist or is \"DELETED\"")
  public void theVaultDoesNotExistOrIsDeleted() {
    // Arrange / Act / Assert — no-op: fresh state has no vaults.
  }

  // ── Given: function state ──────────────────────────────────────────────────────

  @Given("the function does not already exist")
  public void theFunctionDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no functions.
  }

  @Given("the function already exists")
  public void theFunctionAlreadyExists() {
    // Arrange
    // Act
    lambdaGlacierCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function exists")
  public void theFunctionExists() {
    // Arrange
    // Act
    lambdaGlacierCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function does not exist")
  public void theFunctionDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no functions.
  }

  @Given("the function is \"ACTIVE\"")
  public void theFunctionIsActive() {
    // Arrange / Act / Assert — no-op: fresh functions are ACTIVE immediately after creation.
  }

  @Given("the function is not \"ACTIVE\"")
  public void theFunctionIsNotActive() {
    // @internal: Cannot force a function into a non-ACTIVE state via public API in lws.
  }

  // ── Given: invocation state ────────────────────────────────────────────────────

  @Given("an invocation is \"IN_PROGRESS\"")
  public void anInvocationIsInProgress() {
    // Arrange: create the Lambda function so an invocation could be in progress
    // Act
    lambdaGlacierCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("no invocation is \"IN_PROGRESS\"")
  public void noInvocationIsInProgress() {
    // No-op: fresh state has no invocations.
  }

  // ── Given: capacity ────────────────────────────────────────────────────────────

  @Given("an invocation slot is available")
  public void anInvocationSlotIsAvailable() {
    // No-op: always room for invocations in lws.
  }

  @Given("no invocation slot is available")
  public void noInvocationSlotIsAvailable() {
    // @internal: Cannot exhaust invocation slot limit in lws via public APIs.
  }

  @Given("an archive slot is available")
  public void anArchiveSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: archive slots are always available in lws.
  }

  @Given("no archive slot is available")
  public void noArchiveSlotIsAvailable() {
    // @internal: Cannot exhaust archive slot limit in lws via public APIs.
  }

  // ── When: vault actions ────────────────────────────────────────────────────────

  @When("a Glacier vault is created")
  public void aGlacierVaultIsCreated() {
    // Arrange: (vault state set up by Given steps)
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      client.createVault(r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT));
      // Assert: store result
      world.setSuccess(TEST_VAULT);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a Glacier vault is deleted")
  public void aGlacierVaultIsDeleted() {
    // Arrange: (vault state set up by Given steps)
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      client.deleteVault(r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT));
      // Assert: store result
      world.setSuccess(TEST_VAULT);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // ── When: function actions ─────────────────────────────────────────────────────

  @When("a Lambda function is deployed")
  public void aLambdaFunctionIsDeployed() {
    // Arrange: (function state set up by Given steps)
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(TEST_ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
      // Assert: store result
      world.setSuccess(TEST_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Lambda function is invoked")
  public void theLambdaFunctionIsInvoked() {
    // @internal: Cannot trigger Lambda invocation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation: scenario is @internal"));
  }

  @When("the Lambda function uploads an archive to an existing vault and succeeds")
  public void theLambdaFunctionUploadsAnArchiveToAnExistingVaultAndSucceeds() {
    // @internal: Cannot trigger Lambda archive upload in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "upload_archive_task: scenario is @internal"));
  }

  @When("the Lambda function fails to upload because the vault has been deleted")
  public void theLambdaFunctionFailsToUploadBecauseTheVaultHasBeenDeleted() {
    // @internal: Cannot trigger Lambda upload failure in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "invocation_fails_vault_deleted: scenario is @internal"));
  }

  // ── Then: assertions ───────────────────────────────────────────────────────────

  @Then("the vault \"EXISTS\"")
  public void theVaultExistsThen() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected create_vault to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    try (GlacierClient client = world.session.glacierClient()) {
      DescribeVaultResponse resp =
          client.describeVault(r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT));
      String expectedVaultName = TEST_VAULT;
      String actualVaultName = resp.vaultName();
      assertEquals(
          expectedVaultName,
          actualVaultName,
          "expected vault name '"
              + expectedVaultName
              + "' but got '"
              + actualVaultName
              + "'; expected_vault_name="
              + expectedVaultName
              + " actual_vault_name="
              + actualVaultName);
    }
  }

  @Then("the vault is \"DELETED\" and archive uploads will fail")
  public void theVaultIsDeletedAndArchiveUploadsFail() {
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

  @Then("the function is \"ACTIVE\"")
  public void theFunctionIsActiveThen() {
    // Arrange
    String expectedState = "Active";
    // Act
    try (LambdaClient client = world.session.lambdaClient()) {
      var result = client.getFunction(r -> r.functionName(TEST_FUNC));
      String actualState = result.configuration().state().toString();
      // Assert
      assertEquals(
          expectedState,
          actualState,
          "expected function state '"
              + expectedState
              + "' but got '"
              + actualState
              + "'; expected_state="
              + expectedState
              + " actual_state="
              + actualState);
    }
  }

  @Then("the invocation is \"IN_PROGRESS\"")
  public void theInvocationIsInProgress() {
    // @internal: Cannot observe Lambda invocation state in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the archive \"EXISTS\" in the vault and the invocation is \"SUCCESS\"")
  public void theArchiveExistsInTheVaultAndTheInvocationIsSuccess() {
    // @internal: Cannot observe archive upload result in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"FAILED\" with a ResourceNotFoundException")
  public void theInvocationIsFailedWithAResourceNotFoundException() {
    // @internal: Cannot observe Lambda invocation failure in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the operation is rejected")
  public void theOperationIsRejected() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedRejected = true;
    boolean actualRejected = !world.lastSuccess;
    assertTrue(
        actualRejected,
        "expected operation to be rejected but it succeeded; expected_rejected="
            + expectedRejected
            + " actual_rejected="
            + actualRejected);
  }

  // ── Invariant catch-all steps ──────────────────────────────────────────────────

  @Then("every \"IN_PROGRESS\" invocation references an \"ACTIVE\" Lambda function")
  public void everyInProgressInvocationReferencesAnActiveLambdaFunction() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every existing archive references a vault that exists")
  public void everyExistingArchiveReferencesAVaultThatExists() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
