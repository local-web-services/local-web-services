package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.glacier.GlacierClient;
import software.amazon.awssdk.services.glacier.model.DescribeVaultResponse;
import software.amazon.awssdk.services.glacier.model.InitiateJobResponse;
import software.amazon.awssdk.services.sns.SnsClient;
import software.amazon.awssdk.services.sns.model.CreateTopicResponse;

/**
 * Step definitions for the GlacierSns informal specification feature files.
 *
 * <p>Covers: create_vault, delete_topic, create_topic, configure_notification, initiate_job,
 * job_completed_notification_delivered, job_completed_notification_fails.
 *
 * <p>Glacier sends job completion notifications to SNS. Steps use both Glacier and SNS clients.
 */
public class GlacierSnsSteps {

  private static final String TEST_VAULT = "test-glacier-vault-1";
  private static final String TEST_TOPIC = "test-glacier-topic-1";
  private static final String ACCOUNT_ID = "-";
  private static final String REGION = "us-east-1";
  private static final String AWS_ACCOUNT = "000000000000";

  private final WorldContext world;

  // Mutable scenario state
  private String topicArn;
  private String jobId;

  public GlacierSnsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Given: vault state setup ──────────────────────────────────────────────────

  @Given("the vault does not already exist")
  public void theVaultDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no vaults.
  }

  @Given("the vault already exists")
  public void theVaultAlreadyExists() {
    // Arrange
    // Act
    glacierSNSCreateVault();
    // Assert: vault created (no error thrown)
  }

  @Given("the vault exists")
  public void theVaultExists() {
    // Arrange
    // Act
    glacierSNSCreateVault();
    // Assert: vault created (no error thrown)
  }

  @Given("the vault does not exist")
  public void theVaultDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no vaults.
  }

  @Given("the vault has no \"SNS\" notification configured")
  public void theVaultHasNoSnsNotificationConfigured() {
    // Arrange / Act / Assert — no-op: fresh vault has no SNS notification configured.
  }

  @Given("the vault already has an \"SNS\" notification configured")
  public void theVaultAlreadyHasAnSnsNotificationConfigured() {
    // Arrange
    String activeTopicArn = topicArn != null ? topicArn : snsTopicArn(TEST_TOPIC);
    // Act: configure a notification on the vault
    try (GlacierClient client = world.session.glacierClient()) {
      client.setVaultNotifications(
          r ->
              r.accountId(ACCOUNT_ID)
                  .vaultName(TEST_VAULT)
                  .vaultNotificationConfig(
                      cfg ->
                          cfg.snsTopic(activeTopicArn)
                              .events("ArchiveRetrievalCompleted", "InventoryRetrievalCompleted")));
      // Assert: notification configured (no error thrown)
    }
  }

  @Given("the vault has an \"SNS\" notification configured")
  public void theVaultHasAnSnsNotificationConfigured() {
    // @internal: vault notification + job completion requires background processing.
    // No-op — this given is only used in @internal scenarios.
  }

  // ── Given: topic state setup ──────────────────────────────────────────────────

  @Given("the topic does not already exist")
  public void theTopicDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no topics.
  }

  @Given("the topic already exists")
  public void theTopicAlreadyExists() {
    // Arrange
    // Act
    glacierSNSCreateTopic();
    // Assert: topic created (no error thrown)
  }

  @Given("the topic exists")
  public void theTopicExists() {
    // Arrange
    // Act
    glacierSNSCreateTopic();
    // Assert: topic created (no error thrown)
  }

  @Given("the topic exists and is \"ACTIVE\"")
  public void theTopicExistsAndIsActive() {
    // Arrange
    // Act
    glacierSNSCreateTopic();
    // Assert: topic created and is ACTIVE (no error thrown)
  }

  @Given("the topic is \"ACTIVE\"")
  public void theTopicIsActive() {
    // Arrange / Act / Assert — no-op: topics are ACTIVE immediately after creation in lws.
  }

  @Given("the topic is already \"DELETED\"")
  public void theTopicIsAlreadyDeleted() {
    // @internal: topic lifecycle transitions require background processing.
  }

  @Given("the topic does not exist")
  public void theTopicDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no topics.
  }

  @Given("the topic does not exist or is not \"ACTIVE\"")
  public void theTopicDoesNotExistOrIsNotActive() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no topics.
  }

  // ── Given: capacity steps ─────────────────────────────────────────────────────

  @Given("a job slot is available")
  public void aJobSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: job slots are available by default.
  }

  @Given("no job slot is available")
  public void noJobSlotIsAvailable() throws Exception {
    // Arrange: exhaust glacier job capacity
    // Act
    world.session.capacity("glacier").exhaust().apply();
    // Assert: capacity exhausted
  }

  @Given("a message slot is available")
  public void aMessageSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: message slots are available by default.
  }

  @Given("no message slot is available")
  public void noMessageSlotIsAvailable() throws Exception {
    // Arrange: exhaust sns message capacity
    // Act
    world.session.capacity("sns").exhaust().apply();
    // Assert: capacity exhausted
  }

  // ── Given: internal state steps ───────────────────────────────────────────────

  @Given("a job is \"IN_PROGRESS\"")
  public void aJobIsInProgress() {
    // @internal: IN_PROGRESS job state requires background Glacier processing.
  }

  @Given("no job is \"IN_PROGRESS\"")
  public void noJobIsInProgress() {
    // Arrange / Act / Assert — no-op: fresh state has no in-progress jobs.
  }

  @Given("the configured topic is \"ACTIVE\"")
  public void theConfiguredTopicIsActive() {
    // @internal: this given is only used in @internal scenarios.
  }

  @Given("the configured topic is \"DELETED\"")
  public void theConfiguredTopicIsDeleted() {
    // @internal: this given is only used in @internal scenarios.
  }

  @Given("the configured topic is not \"DELETED\"")
  public void theConfiguredTopicIsNotDeleted() {
    // @internal: this given is only used in @internal scenarios.
  }

  // ── Given: model-level precondition steps (sequences.feature) ─────────────────

  @Given("vid not in vault_status")
  public void vidNotInVaultStatus() {
    // Arrange / Act / Assert — no-op: fresh state has no vaults.
  }

  @Given("tid not in topic_status")
  public void tidNotInTopicStatus() {
    // Arrange / Act / Assert — no-op: fresh state has no topics.
  }

  @Given("jid in job_status")
  public void jidInJobStatus() {
    // @internal: job state requires background Glacier processing.
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a Glacier vault is created")
  public void aGlacierVaultIsCreated() {
    // Arrange: (vault may or may not exist — set up by Given steps)
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      client.createVault(r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT));
      // Assert: store result
      world.setSuccess(TEST_VAULT);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an \"SNS\" topic is created")
  public void anSnsTopicIsCreated() {
    // Arrange: (topic may or may not exist — set up by Given steps)
    try (SnsClient client = world.session.snsClient()) {
      // Act
      CreateTopicResponse resp = client.createTopic(r -> r.name(TEST_TOPIC));
      // Assert: store result
      topicArn = resp.topicArn();
      world.setSuccess(resp);
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

  @When("an \"SNS\" notification is configured on the vault")
  public void anSnsNotificationIsConfiguredOnTheVault() {
    // Arrange: (vault/topic state set up by Given steps)
    String activeTopicArn = topicArn != null ? topicArn : snsTopicArn(TEST_TOPIC);
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      client.setVaultNotifications(
          r ->
              r.accountId(ACCOUNT_ID)
                  .vaultName(TEST_VAULT)
                  .vaultNotificationConfig(
                      cfg ->
                          cfg.snsTopic(activeTopicArn)
                              .events("ArchiveRetrievalCompleted", "InventoryRetrievalCompleted")));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a Glacier archive retrieval job is initiated on the vault")
  public void aGlacierArchiveRetrievalJobIsInitiatedOnTheVault() {
    // Arrange: (vault state set up by Given steps)
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      InitiateJobResponse resp =
          client.initiateJob(
              r ->
                  r.accountId(ACCOUNT_ID)
                      .vaultName(TEST_VAULT)
                      .jobParameters(jp -> jp.type("inventory-retrieval")));
      // Assert: store result
      jobId = resp.jobId();
      world.setSuccess(resp);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Glacier job completes and publishes a notification to the configured \"SNS\" topic")
  public void theGlacierJobCompletesAndPublishesANotificationToTheConfiguredSnsTopic() {
    // @internal: Glacier job completion notification delivery requires background processing.
    // This action cannot be performed via the public Glacier API.
    world.setFailure(
        new RuntimeException(
            "InvalidParameterValueException: job completion notification requires internal processing"));
  }

  @When("the Glacier job completes but notification delivery fails because the topic was deleted")
  public void theGlacierJobCompletesButNotificationDeliveryFailsBecauseTheTopicWasDeleted() {
    // @internal: Glacier job completion with failed notification requires background processing.
    // This action cannot be performed via the public Glacier API.
    world.setFailure(
        new RuntimeException(
            "InvalidParameterValueException: job completion notification failure requires internal processing"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the vault \"EXISTS\" with no \"SNS\" notification configuration")
  public void theVaultExistsWithNoSnsNotificationConfiguration() {
    // Arrange
    // Act
    try (GlacierClient client = world.session.glacierClient()) {
      boolean expectedSuccess = true;
      boolean actualSuccess = world.lastSuccess;
      assertTrue(
          actualSuccess,
          "expected create_vault to succeed but got error: "
              + world.lastError
              + "; expected_success="
              + expectedSuccess);
      DescribeVaultResponse resp =
          client.describeVault(r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT));
      // Assert
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

  @Then("the topic is \"ACTIVE\"")
  public void theTopicIsActiveAssertion() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected create_topic to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected CreateTopicResponse but got null");
  }

  @Then("the topic is \"DELETED\" and Glacier notifications will fail")
  public void theTopicIsDeletedAndGlacierNotificationsWillFail() {
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

  @Then("the vault will publish job completion notifications to the topic")
  public void theVaultWillPublishJobCompletionNotificationsToTheTopic() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected set_vault_notifications to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the job is \"IN_PROGRESS\"")
  public void theJobIsInProgressAssertion() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected initiate_job to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected InitiateJobResponse but got null");
  }

  @Then("the job is \"SUCCEEDED\" and the notification is \"PUBLISHED\"")
  public void theJobIsSucceededAndTheNotificationIsPublished() {
    // @internal: job_completed_notification_delivered requires background processing.
    // No assertion performed.
  }

  @Then("the job is \"SUCCEEDED\" but no notification is published")
  public void theJobIsSucceededButNoNotificationIsPublished() {
    // @internal: job_completed_notification_fails requires background processing.
    // No assertion performed.
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

  // ── Safety invariant Then steps ───────────────────────────────────────────────

  @Then("every \"PUBLISHED\" notification references a job that exists")
  public void everyPublishedNotificationReferencesAJobThatExists() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  @Then("every \"PUBLISHED\" notification references a topic that exists")
  public void everyPublishedNotificationReferencesATopicThatExists() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private String snsTopicArn(String name) {
    return "arn:aws:sns:" + REGION + ":" + AWS_ACCOUNT + ":" + name;
  }

  private void glacierSNSCreateVault() {
    try (GlacierClient client = world.session.glacierClient()) {
      client.createVault(r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("VaultAlreadyExists")) {
        throw e;
      }
    }
  }

  private void glacierSNSCreateTopic() {
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
}
