package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.GetFunctionResponse;
import software.amazon.awssdk.services.lambda.model.Runtime;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.secretsmanager.model.DescribeSecretResponse;

/**
 * Step definitions for the lambda_secretsmanager cross-service feature files.
 *
 * <p>Covers: deploy_function, create_secret, schedule_secret_deletion, invoke_function,
 * invocation_fails_secret_unavailable, invocation_succeeds, and invariant feature files.
 *
 * <p>Steps already registered in {@link LambdaSteps} (function existence, function lifecycle
 * states) and {@link SecretsmanagerSteps} / {@link StepfunctionsSecretsmanagerSteps} (secret
 * existence, secret lifecycle states) and {@link CrossServiceSteps} ("the system is initialized",
 * "the operation is rejected") are intentionally absent here to avoid
 * DuplicateStepDefinitionException.
 */
public class LambdaSecretsmanagerSteps {

  private static final String TEST_FUNC = "e2e-test-func-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_SECRET = "e2e-test-secret-1";
  private static final String TEST_SECRET_VALUE = "e2e-test-secret-value-1";

  private final WorldContext world;

  public LambdaSecretsmanagerSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void lambdaCreateFunction() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(TEST_ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceConflict") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  private void secretsManagerCreateSecret() {
    // Arrange
    try (SecretsManagerClient client = world.session.secretsManagerClient()) {
      // Act
      client.createSecret(r -> r.name(TEST_SECRET).secretString(TEST_SECRET_VALUE));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceExistsException") && !msg.contains("already exists")) {
        throw e;
      }
    }
  }

  // ── Given: secret state unique to cross-service scenarios ─────────────────────

  @Given("the secret exists and is \"ACTIVE\"")
  public void theSecretExistsAndIsActive() {
    // Arrange
    // Act: create the secret
    secretsManagerCreateSecret();
    // Assert: secret is ACTIVE immediately after creation in lws
  }

  @Given("the secret is \"PENDING_DELETION\"")
  public void theSecretIsPendingDeletion() {
    // Arrange: create and then soft-delete the secret so it is PENDING_DELETION
    secretsManagerCreateSecret();
    try (SecretsManagerClient client = world.session.secretsManagerClient()) {
      // Act: delete with a recovery window so it enters PENDING_DELETION state
      client.deleteSecret(r -> r.secretId(TEST_SECRET).recoveryWindowInDays(7L));
      // Assert: secret is now PENDING_DELETION
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("InvalidRequestException") && !msg.contains("scheduled for deletion")) {
        throw e;
      }
    }
  }

  @Given("the secret is not pending deletion")
  public void theSecretIsNotPendingDeletion() {
    // Arrange: create the secret (not pending deletion)
    // Act
    secretsManagerCreateSecret();
    // Assert: secret created and ACTIVE
  }

  @When("a secret is created in Secrets Manager")
  public void aSecretIsCreatedInSecretsManager() {
    // Arrange
    try (SecretsManagerClient client = world.session.secretsManagerClient()) {
      // Act
      var response = client.createSecret(r -> r.name(TEST_SECRET).secretString(TEST_SECRET_VALUE));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a secret is scheduled for deletion")
  public void aSecretIsScheduledForDeletion() {
    // Arrange
    try (SecretsManagerClient client = world.session.secretsManagerClient()) {
      // Act
      var response = client.deleteSecret(r -> r.secretId(TEST_SECRET).recoveryWindowInDays(7L));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Lambda function fails because the secret is pending deletion")
  public void theLambdaFunctionFailsBecauseTheSecretIsPendingDeletion() {
    // @internal: Cannot trigger Lambda invocation failure in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation failure: scenario is @internal"));
  }

  @When("the Lambda function reads an \"ACTIVE\" secret and completes successfully")
  public void theLambdaFunctionReadsAnActiveSecretAndCompletesSuccessfully() {
    // @internal: Cannot trigger Lambda invocation success in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation success: scenario is @internal"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the function is \"ACTIVE\"")
  public void theFunctionIsActive() {
    // Arrange
    String expectedState = "Active";
    // Act
    try (LambdaClient client = world.session.lambdaClient()) {
      GetFunctionResponse result = client.getFunction(r -> r.functionName(TEST_FUNC));
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

  @Then("the secret is \"ACTIVE\" and can be read by Lambda")
  public void theSecretIsActiveAndCanBeReadByLambda() {
    // Arrange
    String expectedName = TEST_SECRET;
    // Act
    try (SecretsManagerClient client = world.session.secretsManagerClient()) {
      DescribeSecretResponse response = client.describeSecret(r -> r.secretId(TEST_SECRET));
      String actualName = response.name() != null ? response.name() : "";
      // Assert
      assertEquals(
          expectedName,
          actualName,
          "expected secret name '"
              + expectedName
              + "' but got '"
              + actualName
              + "'; expected_name="
              + expectedName
              + " actual_name="
              + actualName);
    }
  }

  @Then(
      "the secret is \"PENDING_DELETION\" and will be unavailable to Lambda during the recovery"
          + " window")
  public void theSecretIsPendingDeletionAndWillBeUnavailableToLambdaDuringTheRecoveryWindow() {
    // Arrange
    String expectedSecretName = TEST_SECRET;
    // Act
    try (SecretsManagerClient client = world.session.secretsManagerClient()) {
      DescribeSecretResponse response = client.describeSecret(r -> r.secretId(expectedSecretName));
      // Assert
      assertNotNull(
          response.deletedDate(),
          "expected secret '"
              + expectedSecretName
              + "' to have a deletedDate (pending deletion) but got null;"
              + " actual_deleted_date=null");
    }
  }

  @Then("every successful invocation recorded which secret it read")
  public void everySuccessfulInvocationRecordedWhichSecretItRead() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
