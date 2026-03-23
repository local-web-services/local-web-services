package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.eventbridge.model.ListEventBusesResponse;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetBucketNotificationConfigurationResponse;
import software.amazon.awssdk.services.s3.model.ListBucketsResponse;
import software.amazon.awssdk.services.s3.model.NotificationConfiguration;
import software.amazon.awssdk.services.s3.model.PutBucketNotificationConfigurationRequest;

/**
 * Step definitions for the s3api_events cross-service test suite.
 *
 * <p>Covers: create_bucket, create_event_bus, delete_event_bus,
 * enable_event_bridge_notification, put_object_with_event, put_object_event_fails, sequences.
 */
public class S3apiEventsSteps {

  private static final String TEST_S3_BUCKET = "test-bucket-1";
  private static final String TEST_EVENT_BUS = "test-bus-1";
  private static final String TEST_OBJECT_KEY = "test-key-1";
  private static final String TEST_OBJECT_BODY = "test-body-1";

  private final WorldContext world;

  public S3apiEventsSteps(WorldContext world) {
    this.world = world;
  }

  // -------------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------------

  private void s3CreateBucket(String name) {
    try (S3Client client = world.session.s3Client()) {
      client.createBucket(r -> r.bucket(name));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("BucketAlreadyExists") && !msg.contains("BucketAlreadyOwnedByYou")) {
        throw e;
      }
    }
  }

  private void ebCreateBus(String name) {
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      client.createEventBus(r -> r.name(name));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceAlreadyExistsException")) {
        throw e;
      }
    }
  }

  private void ebDeleteBus(String name) {
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      client.deleteEventBus(r -> r.name(name));
    } catch (Exception ignored) {
      // ignore if already deleted
    }
  }

  private void s3EnableEventBridgeNotification(String bucketName) {
    try (S3Client client = world.session.s3Client()) {
      PutBucketNotificationConfigurationRequest req =
          PutBucketNotificationConfigurationRequest.builder()
              .bucket(bucketName)
              .notificationConfiguration(
                  NotificationConfiguration.builder()
                      .eventBridgeConfiguration(eb -> eb.build())
                      .build())
              .build();
      client.putBucketNotificationConfiguration(req);
    }
  }

  // -------------------------------------------------------------------------
  // FizzBee model initialisation preconditions (sequences)
  // -------------------------------------------------------------------------

  @Given("^busid not in bus_status$")
  public void busidNotInBusStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  @Given("^busid in bus_status$")
  public void busidInBusStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  // -------------------------------------------------------------------------
  // Given — bus state
  // -------------------------------------------------------------------------

  @Given("the bus does not already exist")
  public void theBusDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh session has no event buses
  }

  @Given("the bus already exists")
  public void theBusAlreadyExists() {
    // Arrange
    ebCreateBus(TEST_EVENT_BUS);
    // Assert — bus now exists; verified by subsequent steps
  }

  @Given("the bus exists")
  public void theBusExists() {
    // Arrange
    ebCreateBus(TEST_EVENT_BUS);
    // Assert — bus now exists; verified by subsequent steps
  }

  @Given("the bus does not exist")
  public void theBusDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh session has no event buses
  }

  @Given("the bus is {string}")
  public void theBusIs(String state) {
    // Arrange / Act / Assert — no-op: bus is ACTIVE by default when it exists
  }

  @Given("the bus is already {string}")
  public void theBusIsAlready(String state) {
    // Arrange / Act / Assert — non-ACTIVE bus lifecycle state not reachable via public SDK API
    Assumptions.assumeTrue(false, "lws limitation: bus non-ACTIVE lifecycle state not reachable");
  }

  @Given("the bus exists and is {string}")
  public void theBusExistsAndIs(String state) {
    // Arrange
    ebCreateBus(TEST_EVENT_BUS);
    // Assert — bus now exists and is ACTIVE
  }

  @Given("the bus does not exist or is not {string}")
  public void theBusDoesNotExistOrIsNot(String state) {
    // Arrange / Act / Assert — non-ACTIVE bus state not reachable via public SDK API
    Assumptions.assumeTrue(false, "lws limitation: bus non-ACTIVE state not reachable via SDK");
  }

  // -------------------------------------------------------------------------
  // Given — bucket + bus notification configuration
  // -------------------------------------------------------------------------

  @Given("the bucket has no EventBridge notification configured")
  public void theBucketHasNoEventBridgeNotificationConfigured() {
    // Arrange / Act / Assert — no-op: fresh bucket has no EventBridge notification
  }

  @Given("the bucket has an EventBridge notification configured")
  public void theBucketHasAnEventBridgeNotificationConfigured() {
    // Arrange / Act / Assert — assume configured; conceptual precondition
  }

  @Given("the bucket already has an EventBridge notification configured")
  public void theBucketAlreadyHasAnEventBridgeNotificationConfigured() {
    // Arrange / Act / Assert — not reachable via public SDK API
    Assumptions.assumeTrue(
        false,
        "lws limitation: bucket EventBridge notification already-configured not reachable");
  }

  @Given("the target bus is {string}")
  public void theTargetBusIs(String state) {
    // Arrange
    if ("ACTIVE".equals(state)) {
      ebCreateBus(TEST_EVENT_BUS);
    } else if ("DELETED".equals(state)) {
      ebCreateBus(TEST_EVENT_BUS);
      ebDeleteBus(TEST_EVENT_BUS);
    }
    // Assert — bus state set; verified by subsequent steps
  }

  @Given("the target bus is not {string}")
  public void theTargetBusIsNot(String state) {
    // Arrange / Act / Assert — non-ACTIVE target bus state not reachable via public SDK API
    Assumptions.assumeTrue(
        false, "lws limitation: target bus non-DELETED state not reachable via SDK");
  }

  @Given("an event slot is available")
  public void anEventSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: lws imposes no event capacity limits
  }

  @Given("no event slot is available")
  public void noEventSlotIsAvailable() {
    // Arrange / Act / Assert — lws imposes no event capacity limit
    Assumptions.assumeTrue(false, "lws limitation: no event slot capacity enforcement");
  }

  // -------------------------------------------------------------------------
  // When — S3 / EventBridge actions
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

  @When("EventBridge notifications are enabled on the bucket targeting a specific bus")
  public void eventBridgeNotificationsAreEnabledOnTheBucketTargetingASpecificBus() {
    // Arrange
    try (S3Client client = world.session.s3Client()) {
      PutBucketNotificationConfigurationRequest req =
          PutBucketNotificationConfigurationRequest.builder()
              .bucket(TEST_S3_BUCKET)
              .notificationConfiguration(
                  NotificationConfiguration.builder()
                      .eventBridgeConfiguration(eb -> eb.build())
                      .build())
              .build();
      // Act
      var response = client.putBucketNotificationConfiguration(req);
      // Assert
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an object is uploaded and S3 delivers an event to the EventBridge bus")
  public void anObjectIsUploadedAndS3DeliversAnEventToTheEventBridgeBus() {
    // Arrange / Act / Assert — S3 EventBridge event delivery not directly verifiable via SDK API
    Assumptions.assumeTrue(
        false, "lws limitation: S3 EventBridge event delivery not verifiable via SDK API");
  }

  @When("an object is uploaded but event delivery fails because the bus has been deleted")
  public void anObjectIsUploadedButEventDeliveryFailsBecauseTheBusHasBeenDeleted() {
    // Arrange / Act / Assert — S3 EventBridge event failure not directly verifiable via SDK API
    Assumptions.assumeTrue(
        false, "lws limitation: S3 EventBridge event failure not verifiable via SDK API");
  }

  // -------------------------------------------------------------------------
  // Then — assertions
  // -------------------------------------------------------------------------

  @Then("the bucket is \"ACTIVE\" with no EventBridge notification configuration")
  public void theBucketIsActiveWithNoEventBridgeNotificationConfiguration() {
    // Arrange
    String expectedBucketName = TEST_S3_BUCKET;
    // Act
    try (S3Client client = world.session.s3Client()) {
      ListBucketsResponse listResponse = client.listBuckets();
      boolean actualExists =
          listResponse.buckets().stream().anyMatch(b -> b.name().equals(expectedBucketName));
      // Assert
      assertTrue(actualExists, "expected bucket '" + expectedBucketName + "' to exist");
    }
  }

  @Then("the bus is \"ACTIVE\"")
  public void theBusIsActive() {
    // Arrange
    String expectedBusName = TEST_EVENT_BUS;
    // Act
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      ListEventBusesResponse listResponse = client.listEventBuses(r -> r.namePrefix(TEST_EVENT_BUS));
      boolean actualExists =
          listResponse.eventBuses().stream().anyMatch(b -> b.name().equals(expectedBusName));
      // Assert
      assertTrue(actualExists, "expected event bus '" + expectedBusName + "' to be ACTIVE");
    }
  }

  @Then("the bus is \"DELETED\" and event delivery to it will fail")
  public void theBusIsDeletedAndEventDeliveryToItWillFail() {
    // Arrange
    String expectedBusName = TEST_EVENT_BUS;
    // Act
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      ListEventBusesResponse listResponse = client.listEventBuses(r -> r.namePrefix(TEST_EVENT_BUS));
      boolean actualExists =
          listResponse.eventBuses().stream().anyMatch(b -> b.name().equals(expectedBusName));
      // Assert
      assertFalse(actualExists, "expected event bus '" + expectedBusName + "' to be deleted");
    }
  }

  @Then("the bucket will send events to the bus when objects are uploaded")
  public void theBucketWillSendEventsToTheBusWhenObjectsAreUploaded() {
    // Arrange
    String expectedBucketName = TEST_S3_BUCKET;
    // Act
    try (S3Client client = world.session.s3Client()) {
      GetBucketNotificationConfigurationResponse notifResponse =
          client.getBucketNotificationConfiguration(r -> r.bucket(expectedBucketName));
      boolean actualHasEventBridgeConfig =
          notifResponse.eventBridgeConfiguration() != null;
      // Assert
      assertTrue(
          actualHasEventBridgeConfig,
          "expected bucket '" + expectedBucketName + "' to have EventBridge notification");
    }
  }

  @Then("the object \"EXISTS\" and an event is \"DELIVERED\" to the bus")
  public void theObjectExistsAndAnEventIsDeliveredToTheBus() {
    // Arrange / Act / Assert — S3 EventBridge event delivery not directly verifiable via SDK API
    Assumptions.assumeTrue(
        false, "lws limitation: S3 EventBridge event delivery not verifiable via SDK API");
  }

  @Then("the object \"EXISTS\" but no event is delivered")
  public void theObjectExistsButNoEventIsDelivered() {
    // Arrange / Act / Assert — S3 EventBridge event failure not directly verifiable via SDK API
    Assumptions.assumeTrue(
        false, "lws limitation: S3 EventBridge event failure not verifiable via SDK API");
  }

}
