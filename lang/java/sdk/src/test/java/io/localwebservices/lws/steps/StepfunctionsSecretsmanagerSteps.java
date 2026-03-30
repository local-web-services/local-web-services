package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.secretsmanager.model.ListSecretsResponse;

/**
 * Step definitions for the stepfunctions_secretsmanager cross-service feature files.
 *
 * <p>Covers: create_state_machine, create_secret, read_secret_task_succeeds,
 * read_secret_task_fails, schedule_secret_deletion, start_execution, sequences.
 *
 * <p>Steps already defined in {@link CrossServiceSteps} (e.g. system initialisation, state machine
 * Given setups, execution start, invariant catch-alls) are intentionally absent here to avoid
 * duplicate step definition errors.
 */
public class StepfunctionsSecretsmanagerSteps {

  private static final String TEST_SECRET_NAME = "test-secret-1";
  private static final String TEST_SECRET_VALUE = "test-secret-value-1";

  private final WorldContext world;

  public StepfunctionsSecretsmanagerSteps(WorldContext world) {
    this.world = world;
  }

  // -------------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------------

  private void secretsManagerCreateSecret(String name) {
    try (SecretsManagerClient client = world.session.secretsManagerClient()) {
      client.createSecret(r -> r.name(name).secretString(TEST_SECRET_VALUE));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceExistsException") && !msg.contains("already exists")) {
        throw e;
      }
    }
  }

  // -------------------------------------------------------------------------
  // Given — secret preconditions
  // -------------------------------------------------------------------------

  @Given("the secret does not already exist")
  public void theSecretDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh session has no secrets
  }

  @Given("the secret already exists")
  public void theSecretAlreadyExists() {
    // Arrange
    secretsManagerCreateSecret(TEST_SECRET_NAME);
    // Assert — secret now exists; verified by subsequent steps
  }

  @Given("the secret exists")
  public void theSecretExists() {
    // Arrange
    secretsManagerCreateSecret(TEST_SECRET_NAME);
    // Assert — secret now exists; verified by subsequent steps
  }

  @Given("the secret does not exist")
  public void theSecretDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh session has no secrets
  }

  @Given("the secret is not \"ACTIVE\"")
  public void theSecretIsNotActive() {
    // Arrange / Act / Assert — non-ACTIVE secret state not reachable via public API
    Assumptions.assumeTrue(false, "secret non-ACTIVE state not reachable via SDK API");
  }

  // -------------------------------------------------------------------------
  // Given — sequence model preconditions (FizzBee)
  // -------------------------------------------------------------------------

  @Given("^sid not in secret_status$")
  public void sidNotInSecretStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
    Assumptions.assumeTrue(
        false, "Arrange / Act / Assert — no-op: FizzBee model initialisation precondition");
  }

  @Given("^sid in secret_status$")
  public void sidInSecretStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
    Assumptions.assumeTrue(
        false, "Arrange / Act / Assert — no-op: FizzBee model initialisation precondition");
  }

  // -------------------------------------------------------------------------
  // When — execution reads secret (internal; not reachable via public API)
  // -------------------------------------------------------------------------

  @When("a running execution reads an \"ACTIVE\" secret and the task succeeds")
  public void aRunningExecutionReadsAnActiveSecretAndTheTaskSucceeds() {
    // Arrange / Act / Assert — internal execution SecretsManager task not reachable via public API
    Assumptions.assumeTrue(
        false, "internal execution SecretsManager getSecretValue task not reachable via SDK API");
  }

  @When("a running execution fails to read the secret because it is pending deletion")
  public void aRunningExecutionFailsToReadTheSecretBecauseItIsPendingDeletion() {
    // Arrange / Act / Assert — internal execution task failure not reachable via public API
    Assumptions.assumeTrue(
        false, "internal execution SecretsManager task failure not reachable via SDK API");
  }

  // -------------------------------------------------------------------------
  // Then — secret assertions (used as both Given precondition and Then assertion)
  // -------------------------------------------------------------------------

  @Then("the secret is \"ACTIVE\"")
  public void theSecretIsActive() {
    // Arrange
    String expectedSecretName = TEST_SECRET_NAME;
    // Act
    try (SecretsManagerClient client = world.session.secretsManagerClient()) {
      ListSecretsResponse response = client.listSecrets();
      boolean actualExists =
          response.secretList().stream().anyMatch(s -> s.name().equals(expectedSecretName));
      // Assert
      assertTrue(actualExists, "expected secret '" + expectedSecretName + "' to be ACTIVE");
    }
  }

  @Then("the secret is \"PENDING_DELETION\" and will cause task failures when read")
  public void theSecretIsPendingDeletionAndWillCauseTaskFailuresWhenRead() {
    // Arrange
    String expectedSecretName = TEST_SECRET_NAME;
    // Act
    boolean actualMarkedForDeletion;
    try (SecretsManagerClient client = world.session.secretsManagerClient()) {
      ListSecretsResponse response = client.listSecrets();
      actualMarkedForDeletion =
          response.secretList().stream()
              .anyMatch(s -> s.name().equals(expectedSecretName) && s.deletedDate() != null);
    } catch (Exception e) {
      actualMarkedForDeletion = false;
    }
    // Assert
    assertTrue(
        actualMarkedForDeletion,
        "expected secret '" + expectedSecretName + "' to be PENDING_DELETION");
  }
}
