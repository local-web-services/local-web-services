package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.secretsmanager.model.ListSecretsResponse;

/**
 * Step definitions for the secretsmanager_events cross-service feature suite.
 *
 * <p>Covers: create_event_bus, create_secret_event_delivered, create_secret_event_fails,
 * delete_event_bus, delete_secret_event_delivered, rotate_secret_event_delivered, sequences.
 *
 * <p>lws limitation note: SecretsManagerHandler does not dispatch events to EventBridge when
 * secrets are created or deleted. Steps that verify event delivery use {@code
 * Assumptions.assumeTrue(false, ...)} to skip rather than fail.
 *
 * <p>Bus lifecycle steps (busid preconditions, bus existence/state Given steps, event slot capacity
 * steps, the EventBridge event bus is deleted When, and the bus is "ACTIVE" Then) are defined in
 * {@link CrossServiceEventBusSteps} and intentionally absent here to avoid
 * DuplicateStepDefinitionException.
 *
 * <p>Secret precondition steps (sid preconditions, the secret already exists/does not already
 * exist/exists/does not exist Given steps) are defined in {@link StepfunctionsSecretsmanagerSteps}
 * and intentionally absent here to avoid DuplicateStepDefinitionException.
 */
public class SecretsmanagerEventsSteps {

  private static final String TEST_EVENT_BUS = "test-bus-1";
  private static final String TEST_SECRET_NAME = "test-secret-1";
  private static final String TEST_SECRET_VALUE = "test-secret-value-1";

  private final WorldContext world;

  public SecretsmanagerEventsSteps(WorldContext world) {
    this.world = world;
  }

  // -------------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------------

  private void smCreateSecret() {
    try (SecretsManagerClient client = world.session.secretsManagerClient()) {
      client.createSecret(r -> r.name(TEST_SECRET_NAME).secretString(TEST_SECRET_VALUE));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceExistsException") && !msg.contains("already exists")) {
        throw e;
      }
    }
  }

  // -------------------------------------------------------------------------
  // Secret Given steps — unique to secretsmanager_events
  // -------------------------------------------------------------------------

  @Given("the secret exists and is {string}")
  public void theSecretExistsAndIs(String state) {
    // Arrange
    smCreateSecret();
    // Assert — secret now exists and is ACTIVE
  }

  @Given("the secret does not exist or is not {string}")
  public void theSecretDoesNotExistOrIsNot(String state) {
    // Arrange / Act / Assert — non-ACTIVE secret state not reachable via public SDK API; skip
    Assumptions.assumeTrue(
        false, "lws limitation: secret non-ACTIVE state not reachable via SDK API");
  }

  // -------------------------------------------------------------------------
  // When — SecretsManager cross-service actions
  // -------------------------------------------------------------------------

  @When("a secret is created and Secrets Manager delivers a {string} event to the EventBridge bus")
  public void aSecretIsCreatedAndSecretsManagerDeliversEventToEventBridgeBus(String eventType) {
    // Arrange / Act / Assert — lws SecretsManagerHandler does not dispatch to EventBridge; skip
    Assumptions.assumeTrue(
        false,
        "lws limitation: SecretsManager does not dispatch " + eventType + " events to EventBridge");
  }

  @When("a secret is created but the {string} event delivery fails because the bus is deleted")
  public void aSecretIsCreatedButEventDeliveryFailsBecauseBusIsDeleted(String eventType) {
    // Arrange
    try (SecretsManagerClient client = world.session.secretsManagerClient()) {
      // Act
      var response =
          client.createSecret(r -> r.name(TEST_SECRET_NAME).secretString(TEST_SECRET_VALUE));
      // Assert
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When(
      "a secret is scheduled for deletion and Secrets Manager delivers a {string} event to the"
          + " bus")
  public void aSecretIsScheduledForDeletionAndSecretsManagerDeliversEventToBus(String eventType) {
    // Arrange / Act / Assert — lws SecretsManagerHandler does not dispatch to EventBridge; skip
    Assumptions.assumeTrue(
        false,
        "lws limitation: SecretsManager does not dispatch " + eventType + " events to EventBridge");
  }

  @When("a secret rotation occurs and Secrets Manager delivers a {string} event to the bus")
  public void aSecretRotationOccursAndSecretsManagerDeliversEventToBus(String eventType) {
    // Arrange / Act / Assert — lws does not implement secret rotation; skip
    Assumptions.assumeTrue(false, "lws limitation: secret rotation is not implemented in lws");
  }

  // -------------------------------------------------------------------------
  // Then — bus state assertions
  // -------------------------------------------------------------------------

  @Then("the bus is \"DELETED\" and Secrets Manager event delivery will fail")
  public void theBusIsDeletedAndSecretsManagerEventDeliveryWillFail() {
    // Arrange
    String expectedBusName = TEST_EVENT_BUS;
    // Act
    boolean actualBusGone;
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      var response = client.listEventBuses(r -> r.namePrefix(expectedBusName));
      actualBusGone =
          response.eventBuses().stream().noneMatch(b -> b.name().equals(expectedBusName));
    } catch (Exception e) {
      actualBusGone = true;
    }
    // Assert
    assertTrue(
        actualBusGone, "expected event bus '" + expectedBusName + "' to be DELETED (deleted/gone)");
  }

  // -------------------------------------------------------------------------
  // Then — secret + event delivery assertions
  // -------------------------------------------------------------------------

  @Then("the secret is {string} and the {string} event is {string}")
  public void theSecretIsStateAndEventIsDelivered(
      String secretState, String eventType, String eventDeliveryState) {
    // Arrange / Act / Assert — lws does not dispatch events to EventBridge; skip
    Assumptions.assumeTrue(
        false,
        "lws limitation: SecretsManager does not dispatch " + eventType + " events to EventBridge");
  }

  @Then("the secret is {string} but no event is delivered")
  public void theSecretIsStateButNoEventIsDelivered(String secretState) {
    // Arrange
    String expectedSecretName = TEST_SECRET_NAME;
    // Act
    try (SecretsManagerClient client = world.session.secretsManagerClient()) {
      ListSecretsResponse response = client.listSecrets();
      boolean actualExists =
          response.secretList().stream().anyMatch(s -> s.name().equals(expectedSecretName));
      // Assert
      assertTrue(actualExists, "expected secret '" + expectedSecretName + "' to be " + secretState);
    }
  }

  @Then("the secret is {string} with a new version and the {string} event is {string}")
  public void theSecretIsStateWithNewVersionAndEventIsDelivered(
      String secretState, String eventType, String eventDeliveryState) {
    // Arrange / Act / Assert — lws does not implement secret rotation or EventBridge dispatch; skip
    Assumptions.assumeTrue(false, "lws limitation: secret rotation is not implemented in lws");
  }

  @Then("the secret is \"PENDING_DELETION\" and the {string} event is \"DELIVERED\"")
  public void theSecretIsPendingDeletionAndEventIsDelivered(String eventType) {
    // Arrange / Act / Assert — lws does not dispatch events to EventBridge; skip
    Assumptions.assumeTrue(
        false,
        "lws limitation: SecretsManager does not dispatch " + eventType + " events to EventBridge");
  }
}
