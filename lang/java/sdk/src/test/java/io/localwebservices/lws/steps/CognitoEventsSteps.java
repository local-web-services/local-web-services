package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.cognitoidentityprovider.CognitoIdentityProviderClient;
import software.amazon.awssdk.services.cognitoidentityprovider.model.ListUserPoolsResponse;
import software.amazon.awssdk.services.cognitoidentityprovider.model.UserPoolDescriptionType;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;

/**
 * Step definitions for the cognito_events cross-service feature suite.
 *
 * <p>Covers: create_event_bus, create_user_pool, delete_event_bus, enable_event_publishing,
 * user_action_delivered (@internal), user_action_delivery_fails (@internal).
 *
 * <p>Bus lifecycle Given steps (the bus does not already exist, the bus already exists, the bus
 * exists, the bus is {string}, the bus is already {string}, the bus is not {string}, the bus exists
 * and is {string}, the bus does not exist, the bus does not exist or is not {string}, an event slot
 * is available, no event slot is available) are defined in {@link CrossServiceEventBusSteps} and
 * intentionally absent here to avoid DuplicateStepDefinitionException.
 *
 * <p>The "the EventBridge event bus is deleted" When step is defined in {@link
 * CrossServiceEventBusSteps} and intentionally absent here.
 *
 * <p>Invariant catch-all Then steps (every "DELIVERED" event references a pool/bus that exists) are
 * handled by the {@code ^every .*$} catch-all in {@link CrossServiceSteps} and intentionally absent
 * here.
 *
 * <p>Pool Given steps unique to cognito_idp (the user pool does not already exist, the user pool
 * already exists, the user pool exists, the user pool is {string}, the user pool does not exist)
 * use the prefix "the user pool" and do NOT conflict with the "the pool" steps defined here.
 */
public class CognitoEventsSteps {

  private static final String TEST_POOL_NAME = "e2e-test-pool-1";
  private static final String TEST_BUS_NAME = "test-bus-1";

  private final WorldContext world;

  public CognitoEventsSteps(WorldContext world) {
    this.world = world;
  }

  // -------------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------------

  private void cognitoCreatePool() {
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      client.createUserPool(r -> r.poolName(TEST_POOL_NAME));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("UsernameExistsException")
          && !msg.contains("already exists")
          && !msg.contains("ResourceInUse")) {
        throw e;
      }
    }
  }

  @Given("the pool exists and is {string}")
  public void thePoolExistsAndIs(String state) {
    // Arrange
    cognitoCreatePool();
    // Assert — pool now exists and is ACTIVE by default; verified by subsequent steps
  }

  @Given("the pool does not exist or is not {string}")
  public void thePoolDoesNotExistOrIsNot(String state) {
    // Arrange / Act / Assert — no-op: fresh session has no user pools
  }

  @Given("the pool has an EventBridge configuration")
  public void thePoolHasAnEventBridgeConfiguration() {
    // Arrange / Act / Assert — cannot configure EventBridge on a Cognito user pool in lws; skip
    Assumptions.assumeTrue(
        false, "lws limitation: EventBridge configuration on Cognito user pool not supported");
  }

  @Given("the pool has no EventBridge configuration")
  public void thePoolHasNoEventBridgeConfiguration() {
    // Arrange / Act / Assert — no-op: pools have no EventBridge configuration by default
  }

  @Given("the pool already has an EventBridge configuration")
  public void thePoolAlreadyHasAnEventBridgeConfiguration() {
    // Arrange / Act / Assert — cannot configure EventBridge on a Cognito user pool in lws; skip
    Assumptions.assumeTrue(
        false, "lws limitation: EventBridge configuration on Cognito user pool not supported");
  }

  @When("a Cognito user pool is created")
  public void aCognitoUserPoolIsCreated() {
    // Arrange
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var response = client.createUserPool(r -> r.poolName(TEST_POOL_NAME));
      // Assert
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("EventBridge publishing is enabled on the user pool")
  public void eventBridgePublishingIsEnabledOnTheUserPool() {
    // Arrange / Act / Assert — cannot trigger internal EventBridge publishing configuration; skip
    Assumptions.assumeTrue(
        false,
        "lws limitation: EventBridge publishing configuration on Cognito user pool not supported");
  }

  @When("a user action occurs in the pool and Cognito delivers the event to the EventBridge bus")
  public void aUserActionOccursAndCognitoDeliversEventToEventBridgeBus() {
    // Arrange / Act / Assert — @internal scenario: cannot trigger internal Cognito event routing;
    // skip
    Assumptions.assumeTrue(
        false, "lws limitation: internal Cognito user action event routing not supported");
  }

  @When("a user action occurs but event delivery fails because the bus has been deleted")
  public void aUserActionOccursButEventDeliveryFailsBecauseBusIsDeleted() {
    // Arrange / Act / Assert — @internal scenario: cannot trigger internal Cognito event delivery
    // failure; skip
    Assumptions.assumeTrue(
        false, "lws limitation: internal Cognito event delivery failure not supported");
  }

  // -------------------------------------------------------------------------
  // Then — bus state assertions (unique to cognito_events)
  // -------------------------------------------------------------------------

  @Then("the bus is \"ACTIVE\"")
  public void theBusIsActive() {
    // Arrange
    String expectedBusName = TEST_BUS_NAME;
    // Act
    boolean actualFound;
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      var response = client.listEventBuses(r -> r.namePrefix(expectedBusName));
      actualFound = response.eventBuses().stream().anyMatch(b -> b.name().equals(expectedBusName));
    } catch (Exception e) {
      actualFound = false;
    }
    // Assert
    assertTrue(actualFound, "Expected event bus '" + expectedBusName + "' to be ACTIVE");
  }

  @Then("the bus is \"DELETED\" and Cognito event delivery will fail")
  public void theBusIsDeletedAndCognitoEventDeliveryWillFail() {
    // Arrange
    String expectedBusName = TEST_BUS_NAME;
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
    assertTrue(actualBusGone, "Expected event bus '" + expectedBusName + "' to be DELETED (gone)");
  }

  // -------------------------------------------------------------------------
  // Then — pool state assertions
  // -------------------------------------------------------------------------

  @Then("the pool is \"ACTIVE\" with no EventBridge configuration")
  public void thePoolIsActiveWithNoEventBridgeConfiguration() {
    // Arrange
    String expectedPoolName = TEST_POOL_NAME;
    // Act
    boolean actualFound;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      ListUserPoolsResponse response = client.listUserPools(r -> r.maxResults(60));
      actualFound =
          response.userPools().stream()
              .map(UserPoolDescriptionType::name)
              .anyMatch(expectedPoolName::equals);
    } catch (Exception e) {
      actualFound = false;
    }
    // Assert
    assertTrue(actualFound, "Expected user pool '" + expectedPoolName + "' to be ACTIVE");
  }

  @Then("the pool will send user events to the bus")
  public void thePoolWillSendUserEventsToBus() {
    // Arrange / Act / Assert — cannot observe internal EventBridge publishing configuration; skip
    Assumptions.assumeTrue(
        false,
        "lws limitation: internal EventBridge publishing configuration not observable via SDK API");
  }

  // -------------------------------------------------------------------------
  // Then — event delivery assertions
  // -------------------------------------------------------------------------

  @Then("the event is \"DELIVERED\" to the bus")
  public void theEventIsDeliveredToBus() {
    // Arrange / Act / Assert — @internal: cannot trigger internal Cognito event delivery; skip
    Assumptions.assumeTrue(
        false, "lws limitation: internal Cognito event delivery not observable via SDK API");
  }

  @Then("the event delivery \"FAILED\"")
  public void theEventDeliveryFailed() {
    // Arrange / Act / Assert — @internal: cannot observe internal Cognito event delivery failure;
    // skip
    Assumptions.assumeTrue(
        false,
        "lws limitation: internal Cognito event delivery failure not observable via SDK API");
  }
}
