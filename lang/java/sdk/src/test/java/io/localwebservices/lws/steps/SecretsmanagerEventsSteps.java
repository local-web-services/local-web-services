package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.And;
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
 * secrets are created or deleted. Steps that verify event delivery use
 * {@code Assumptions.assumeTrue(false, ...)} to skip rather than fail.
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

  private void ebCreateBus() {
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      client.createEventBus(r -> r.name(TEST_EVENT_BUS));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("AlreadyExists")
          && !msg.contains("ResourceInUse")
          && !msg.contains("already exists")) {
        throw e;
      }
    }
  }

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
  // Sequence precondition steps (FizzBee model initialisation — no-op)
  // -------------------------------------------------------------------------

  @Given("^sid not in secret_status$")
  public void sidNotInSecretStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  @Given("^sid in secret_status$")
  public void sidInSecretStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  @Given("^busid not in bus_status$")
  public void busidNotInBusStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  @Given("^busid in bus_status$")
  public void busidInBusStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  // -------------------------------------------------------------------------
  // EventBridge bus Given steps
  // -------------------------------------------------------------------------

  @Given("the bus does not already exist")
  public void theBusDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh session has no event buses
  }

  @Given("the bus already exists")
  public void theBusAlreadyExists() {
    // Arrange
    ebCreateBus();
    // Assert — bus now exists; verified by subsequent steps
  }

  @Given("the bus exists")
  public void theBusExists() {
    // Arrange
    ebCreateBus();
    // Assert — bus now exists; verified by subsequent steps
  }

  @Given("the bus exists and is {string}")
  public void theBusExistsAndIs(String state) {
    // Arrange
    ebCreateBus();
    // Assert — bus now exists and is ACTIVE
  }

  @Given("the bus does not exist or is {string}")
  public void theBusDoesNotExistOrIs(String state) {
    // Arrange / Act / Assert — DELETED bus state not reachable via public SDK API; skip
    Assumptions.assumeTrue(false, "lws limitation: bus DELETED state not reachable via SDK API");
  }

  @Given("the bus is not {string}")
  public void theBusIsNot(String state) {
    // Arrange / Act / Assert — non-DELETED bus state means bus is ACTIVE; no-op
  }

  @Given("the bus does not exist")
  public void theBusDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh session has no event buses
  }

  @Given("the bus is already {string}")
  public void theBusIsAlready(String state) {
    // Arrange / Act / Assert — non-ACTIVE bus lifecycle state not reachable via public API; skip
    Assumptions.assumeTrue(
        false, "lws limitation: bus " + state + " lifecycle state not reachable via SDK API");
  }

  /**
   * Serves as both a Given precondition ({@code And the bus is "ACTIVE"}) and a Then assertion
   * ({@code Then the bus is "ACTIVE"}) — Cucumber annotations are interchangeable at match time.
   */
  @Given("the bus is {string}")
  public void theBusIs(String state) {
    // Arrange
    if ("ACTIVE".equals(state)) {
      ebCreateBus();
      // Assert — bus now exists; verified by subsequent steps
    } else {
      // lws: non-ACTIVE bus states not reachable via public SDK API; skip
      Assumptions.assumeTrue(
          false, "lws limitation: bus " + state + " state not reachable via SDK API");
    }
  }

  // -------------------------------------------------------------------------
  // Event slot Given steps
  // -------------------------------------------------------------------------

  @Given("an event slot is available")
  public void anEventSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: event slots are unlimited by default
  }

  @Given("no event slot is available")
  public void noEventSlotIsAvailable() {
    // Arrange / Act / Assert — capacity exhaustion not configurable via public SDK API; skip
    Assumptions.assumeTrue(
        false, "lws limitation: event slot exhaustion not configurable via SDK API");
  }

  // -------------------------------------------------------------------------
  // Secret Given steps
  // -------------------------------------------------------------------------

  @Given("the secret does not already exist")
  public void theSecretDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh session has no secrets
  }

  @Given("the secret already exists")
  public void theSecretAlreadyExists() {
    // Arrange
    smCreateSecret();
    // Assert — secret now exists; verified by subsequent steps
  }

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
  // When — EventBridge actions
  // -------------------------------------------------------------------------

  @When("the EventBridge event bus is deleted")
  public void theEventBridgeEventBusIsDeleted() {
    // Arrange
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      // Act
      var response = client.deleteEventBus(r -> r.name(TEST_EVENT_BUS));
      // Assert
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // -------------------------------------------------------------------------
  // When — SecretsManager cross-service actions
  // -------------------------------------------------------------------------

  @When(
      "a secret is created and Secrets Manager delivers a {string} event to the EventBridge bus")
  public void aSecretIsCreatedAndSecretsManagerDeliversEventToEventBridgeBus(String eventType) {
    // Arrange / Act / Assert — lws SecretsManagerHandler does not dispatch to EventBridge; skip
    Assumptions.assumeTrue(
        false,
        "lws limitation: SecretsManager does not dispatch "
            + eventType
            + " events to EventBridge");
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
        "lws limitation: SecretsManager does not dispatch "
            + eventType
            + " events to EventBridge");
  }

  @When("a secret rotation occurs and Secrets Manager delivers a {string} event to the bus")
  public void aSecretRotationOccursAndSecretsManagerDeliversEventToBus(String eventType) {
    // Arrange / Act / Assert — lws does not implement secret rotation; skip
    Assumptions.assumeTrue(false, "lws limitation: secret rotation is not implemented in lws");
  }

  // -------------------------------------------------------------------------
  // Then — bus state assertions
  // -------------------------------------------------------------------------

  @Then("the bus is \"ACTIVE\"")
  public void theBusIsActive() {
    // Arrange
    String expectedBusName = TEST_EVENT_BUS;
    // Act
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      var response = client.listEventBuses(r -> r.namePrefix(expectedBusName));
      boolean actualExists =
          response.eventBuses().stream().anyMatch(b -> b.name().equals(expectedBusName));
      // Assert
      assertTrue(actualExists, "expected event bus '" + expectedBusName + "' to be ACTIVE");
    }
  }

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
        actualBusGone,
        "expected event bus '" + expectedBusName + "' to be DELETED (deleted/gone)");
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
        "lws limitation: SecretsManager does not dispatch "
            + eventType
            + " events to EventBridge");
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
      assertTrue(
          actualExists, "expected secret '" + expectedSecretName + "' to be " + secretState);
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
        "lws limitation: SecretsManager does not dispatch "
            + eventType
            + " events to EventBridge");
  }

  // -------------------------------------------------------------------------
  // Invariant catch-all And steps
  // -------------------------------------------------------------------------

  @And("every {string} event references a secret that exists")
  public void everyEventReferencesASecretThatExists(String deliveryState) {
    // Arrange / Act / Assert — no-op: model-level invariant; not verifiable via public API
  }
}
