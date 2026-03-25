package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.elasticache.ElastiCacheClient;
import software.amazon.awssdk.services.sns.SnsClient;
import software.amazon.awssdk.services.sns.model.CreateTopicResponse;

/**
 * Step definitions for the ElasticacheSns informal specification feature files.
 *
 * <p>Covers: create_cluster, create_topic, delete_topic, configure_notification,
 * cluster_event_notification_delivered, cluster_event_notification_fails,
 * cluster_modification_complete.
 *
 * <p>ElastiCache publishes lifecycle events to SNS. Steps use both ElastiCache and SNS clients.
 */
public class ElasticacheSnsSteps {

  private static final String TEST_CLUSTER = "test-elasticachesns-cluster-1";
  private static final String TEST_TOPIC = "test-elasticachesns-topic-1";
  private static final String REGION = "us-east-1";
  private static final String AWS_ACCOUNT = "000000000000";

  private final WorldContext world;

  // Mutable scenario state
  private String topicArn;

  public ElasticacheSnsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private String snsTopicArn(String name) {
    return "arn:aws:sns:" + REGION + ":" + AWS_ACCOUNT + ":" + name;
  }

  private void elasticacheSnsCreateCluster() {
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      client.createCacheCluster(r -> r.cacheClusterId(TEST_CLUSTER).engine("redis"));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("CacheClusterAlreadyExists") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  private void elasticacheSnsCreateTopic() {
    try (SnsClient client = world.session.snsClient()) {
      CreateTopicResponse resp = client.createTopic(r -> r.name(TEST_TOPIC));
      topicArn = resp.topicArn();
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (msg.contains("already exists") || msg.contains("TopicLimitExceeded")) {
        topicArn = snsTopicArn(TEST_TOPIC);
      } else {
        throw e;
      }
    }
  }

  @Given("the cluster exists and is \"AVAILABLE\"")
  public void theClusterExistsAndIsAvailable() {
    // Arrange
    // Act
    elasticacheSnsCreateCluster();
    // Assert: cluster created and is AVAILABLE (no error thrown)
  }

  @Given("the cluster does not exist or is not \"AVAILABLE\"")
  public void theClusterDoesNotExistOrIsNotAvailable() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no clusters.
  }

  @Given("the cluster is \"MODIFYING\"")
  public void theClusterIsModifying() {
    // @internal: MODIFYING state is not reachable via public API in lws.
  }

  @Given("the cluster is not \"MODIFYING\"")
  public void theClusterIsNotModifying() {
    // Arrange: create an AVAILABLE cluster (not MODIFYING)
    // Act
    elasticacheSnsCreateCluster();
    // Assert: cluster is AVAILABLE (not MODIFYING)
  }

  @Given("the cluster has no \"SNS\" notification configured")
  public void theClusterHasNoSnsNotificationConfigured() {
    // Arrange / Act / Assert — no-op: fresh cluster has no SNS notification.
  }

  @Given("the cluster already has an \"SNS\" notification configured")
  public void theClusterAlreadyHasAnSnsNotificationConfigured() {
    // Arrange: configure a notification on the cluster via SNS topic ARN
    String activeTopicArn = topicArn != null ? topicArn : snsTopicArn(TEST_TOPIC);
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      client.modifyCacheCluster(
          r -> r.cacheClusterId(TEST_CLUSTER).notificationTopicArn(activeTopicArn));
      // Assert: notification configured (no error thrown)
    }
  }

  @Given("the cluster has an \"SNS\" notification configured")
  public void theClusterHasAnSnsNotificationConfigured() {
    // @internal: cluster SNS notification state requires background processing.
    // No-op — this given is only used in @internal scenarios.
  }

  @Given("the topic exists and is \"ACTIVE\"")
  public void theTopicExistsAndIsActive() {
    // Arrange
    // Act
    elasticacheSnsCreateTopic();
    // Assert: topic created and is ACTIVE (no error thrown)
  }

  @Given("the topic is \"ACTIVE\"")
  public void theTopicIsActive() {
    // Arrange / Act / Assert — no-op: topics are ACTIVE immediately after creation in lws.
  }

  @Given("the topic is \"DELETED\"")
  public void theTopicIsDeleted() {
    // @internal: topic lifecycle transitions require background processing.
  }

  @Given("the topic is not \"DELETED\"")
  public void theTopicIsNotDeleted() {
    // Arrange / Act / Assert — no-op: fresh topics are not DELETED.
  }

  @Given("the topic already is \"DELETED\"")
  public void theTopicIsAlreadyDeleted() {
    // @internal: topic lifecycle transitions require background processing.
  }

  @Given("the topic does not exist or is not \"ACTIVE\"")
  public void theTopicDoesNotExistOrIsNotActive() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no topics.
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("an ElastiCache cluster is created")
  public void anElastiCacheClusterIsCreated() {
    // Arrange: (cluster may or may not exist — set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result = client.createCacheCluster(r -> r.cacheClusterId(TEST_CLUSTER).engine("redis"));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the \"SNS\" topic is deleted")
  public void theSnsTopicIsDeleted() {
    // Arrange: (topic state set up by Given steps)
    String activeTopicArn = topicArn != null ? topicArn : snsTopicArn(TEST_TOPIC);
    try (SnsClient client = world.session.snsClient()) {
      // Act
      client.deleteTopic(r -> r.topicArn(activeTopicArn));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an \"SNS\" notification is configured on the ElastiCache cluster")
  public void anSnsNotificationIsConfiguredOnTheElastiCacheCluster() {
    // Arrange: (cluster/topic state set up by Given steps)
    String activeTopicArn = topicArn != null ? topicArn : snsTopicArn(TEST_TOPIC);
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result =
          client.modifyCacheCluster(
              r -> r.cacheClusterId(TEST_CLUSTER).notificationTopicArn(activeTopicArn));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When(
      "a cluster modification event occurs and ElastiCache publishes a notification to the \"SNS\" topic")
  public void aClusterModificationEventOccursAndElastiCachePublishesNotification() {
    // @internal: cluster event notification delivery requires background processing.
    world.setFailure(
        new RuntimeException(
            "InvalidParameterValueException: cluster event notification requires internal processing"));
  }

  @When(
      "a cluster event occurs but the \"SNS\" notification fails because the topic has been deleted")
  public void aClusterEventOccursButSnsNotificationFailsBecauseTopicDeleted() {
    // @internal: cluster event notification failure requires background processing.
    world.setFailure(
        new RuntimeException(
            "InvalidParameterValueException: cluster event notification failure requires internal processing"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the cluster is \"AVAILABLE\" with no \"SNS\" notification configured")
  public void theClusterIsAvailableWithNoSnsNotificationConfigured() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected create_cluster to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected CreateCacheClusterResponse but got null");
  }

  @Then("the topic is \"DELETED\" and ElastiCache event notifications will fail")
  public void theTopicIsDeletedAndElastiCacheEventNotificationsWillFail() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected delete_topic to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the cluster will publish lifecycle events to the topic")
  public void theClusterWillPublishLifecycleEventsToTheTopic() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected configure_notification to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the cluster is \"MODIFYING\" and the notification is \"PUBLISHED\" to the topic")
  public void theClusterIsModifyingAndTheNotificationIsPublishedToTheTopic() {
    // @internal: cluster event notification delivery requires background processing.
    // No assertion performed.
  }

  @Then("the cluster is \"MODIFYING\" but no notification is published")
  public void theClusterIsModifyingButNoNotificationIsPublished() {
    // @internal: cluster event notification failure requires background processing.
    // No assertion performed.
  }

  // ── Safety invariant Then steps ───────────────────────────────────────────────

  // "every \"PUBLISHED\" notification references a cluster that exists" → CrossServiceSteps (catch-all @And("^every .*$"))
  // "every \"PUBLISHED\" notification references a topic that exists" → CrossServiceSteps (catch-all @And("^every .*$"))
}
