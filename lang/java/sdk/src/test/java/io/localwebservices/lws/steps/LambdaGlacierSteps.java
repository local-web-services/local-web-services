package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.glacier.GlacierClient;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;

/**
 * Step definitions for the lambda_glacier cross-service informal specification feature files.
 *
 * <p>Covers: create_vault, delete_vault, deploy_function, invoke_function, upload_archive_task,
 * invocation_fails_vault_deleted.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized", "the
 * operation is rejected") are intentionally absent here to avoid duplicate step definition errors.
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

  @Given("an archive slot is available")
  public void anArchiveSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: archive slots are always available in lws.
  }

  @Given("no archive slot is available")
  public void noArchiveSlotIsAvailable() {
    // @internal: Cannot exhaust archive slot limit in lws via public APIs.
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

  @When("the Lambda function uploads an archive to an existing vault and succeeds")
  public void theLambdaFunctionUploadsAnArchiveToAnExistingVaultAndSucceeds() {
    // @internal: Cannot trigger Lambda archive upload in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException("upload_archive_task: scenario is @internal"));
  }

  @When("the Lambda function fails to upload because the vault has been deleted")
  public void theLambdaFunctionFailsToUploadBecauseTheVaultHasBeenDeleted() {
    // @internal: Cannot trigger Lambda upload failure in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException("invocation_fails_vault_deleted: scenario is @internal"));
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

  @Then("the archive \"EXISTS\" in the vault and the invocation is \"SUCCESS\"")
  public void theArchiveExistsInTheVaultAndTheInvocationIsSuccess() {
    // @internal: Cannot observe archive upload result in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  // "every existing archive references a vault that exists" → CrossServiceSteps (catch-all @And("^every .*$"))
}
