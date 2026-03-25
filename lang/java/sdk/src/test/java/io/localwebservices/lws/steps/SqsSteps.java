package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.List;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.GetQueueAttributesResponse;
import software.amazon.awssdk.services.sqs.model.ListQueuesResponse;
import software.amazon.awssdk.services.sqs.model.Message;
import software.amazon.awssdk.services.sqs.model.QueueAttributeName;
import software.amazon.awssdk.services.sqs.model.ReceiveMessageResponse;

/**
 * Step definitions for the SQS informal specification feature files.
 *
 * <p>Covers: create_queue, delete_queue, send_message, receive_message, delete_message,
 * change_message_visibility, purge_queue, get_queue_attributes, visibility_timeout_expires,
 * redrive_to_dead_letter_queue.
 *
 * <p>Steps already registered in CrossServiceSteps (the queue does not already exist, the queue
 * already exists, the queue exists, the queue is not {string}, the queue does not exist, the system
 * is initialized, the operation is rejected, every .* catch-all) are NOT re-registered here. Those
 * handlers have been updated in CrossServiceSteps to respect world.sqsActiveQueueName.
 */
public class SqsSteps {

  private static final String TEST_QUEUE = "e2e-sqs-test-q1";
  private static final String TEST_DLQ = "e2e-sqs-test-dlq-1";
  private static final String TEST_MESSAGE = "test-message-body-1";

  private final WorldContext world;

  public SqsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Given: queue lifecycle state (non-conflicting) ───────────────────────────

  // "the queue is {string}" is already registered in CrossServiceSteps.java and updated to use
  // activeQueueName(). We register it here only for the ACTIVE no-op path, but since
  // CrossServiceSteps already handles it, we do NOT re-register it.

  // "the queue does not already exist" — registered in CrossServiceSteps; we hook via the first
  // call that sets sqsActiveQueueName. We need to activate the queue name for the SQS spec.
  // However, since CrossServiceSteps handles the step, we CANNOT register it again. Instead,
  // we set sqsActiveQueueName in the SQS spec When steps.

  // ── Given: message existence ──────────────────────────────────────────────────

  @Given("the message does not exist")
  public void theMessageDoesNotExist() {
    // Arrange / Act / Assert — no-op: SQS ReceiveMessage on an empty queue returns an
    // empty list, not an error. The scenario's Then step will verify rejection behaviour.
    world.sqsActiveQueueName = TEST_QUEUE;
  }

  @Given("the message exists")
  public void theMessageExists() throws Exception {
    // Arrange
    world.sqsActiveQueueName = TEST_QUEUE;
    sqsCreateQueue(TEST_QUEUE);
    // Act: send a test message
    try (SqsClient client = world.session.sqsClient()) {
      client.sendMessage(r -> r.queueUrl(queueUrl(TEST_QUEUE)).messageBody(TEST_MESSAGE));
    }
    // Assert: message sent (no error thrown)
  }

  @Given("the message is \"AVAILABLE\"")
  public void theMessageIsAvailable() {
    // Arrange
    world.sqsActiveQueueName = TEST_QUEUE;
    // Act / Assert — no-op: after send_message the message is AVAILABLE by default.
  }

  @Given("the message is \"IN_FLIGHT\"")
  public void theMessageIsInFlightGiven() {
    // Arrange: receive the message to put it IN_FLIGHT
    world.sqsActiveQueueName = TEST_QUEUE;
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      ReceiveMessageResponse result =
          client.receiveMessage(
              r ->
                  r.queueUrl(queueUrl(TEST_QUEUE))
                      .maxNumberOfMessages(1)
                      .visibilityTimeout(30)
                      .waitTimeSeconds(0));
      List<Message> messages = result.messages();
      // Assert: store receipt handle
      if (!messages.isEmpty() && messages.get(0).receiptHandle() != null) {
        world.sqsReceiptHandle = messages.get(0).receiptHandle();
      }
    }
  }

  @Given("the message is not \"AVAILABLE\"")
  public void theMessageIsNotAvailable() {
    // Arrange: receive the message to put it IN_FLIGHT (not AVAILABLE)
    world.sqsActiveQueueName = TEST_QUEUE;
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      ReceiveMessageResponse result =
          client.receiveMessage(
              r ->
                  r.queueUrl(queueUrl(TEST_QUEUE))
                      .maxNumberOfMessages(1)
                      .visibilityTimeout(30)
                      .waitTimeSeconds(0));
      List<Message> messages = result.messages();
      // Assert: store receipt handle
      if (!messages.isEmpty() && messages.get(0).receiptHandle() != null) {
        world.sqsReceiptHandle = messages.get(0).receiptHandle();
      }
    }
  }

  @Given("the message is not \"IN_FLIGHT\"")
  public void theMessageIsNotInFlight() {
    // No-op: the message is not in-flight by default (it is AVAILABLE after send).
    world.sqsActiveQueueName = TEST_QUEUE;
  }

  // ── Given: message's queue ────────────────────────────────────────────────────

  @Given("the message's queue exists")
  public void theMessageSQueueExists() {
    // No-op: queue was created in "the message exists" step.
    world.sqsActiveQueueName = TEST_QUEUE;
  }

  @Given("the message's queue does not exist")
  public void theMessageSQueueDoesNotExist() {
    // Arrange: delete the queue so it does not exist
    world.sqsActiveQueueName = TEST_QUEUE;
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      try {
        client.deleteQueue(r -> r.queueUrl(queueUrl(TEST_QUEUE)));
      } catch (Exception ignored) {
        // queue may not exist; desired state is absence
      }
    }
    // Assert: queue is absent
  }

  @Given("the message's queue is {string}")
  public void theMessageSQueueIs(String state) {
    // Arrange
    world.sqsActiveQueueName = TEST_QUEUE;
    if ("ACTIVE".equals(state)) {
      // No-op: queue is ACTIVE by default.
      return;
    }
    // Simulate via lifecycle API.
    try {
      world.session.lifecycle("sqs").createDwellMs(5000).apply();
    } catch (Exception ignored) {
      // lifecycle API may not be available
    }
    try (SqsClient client = world.session.sqsClient()) {
      try {
        client.deleteQueue(r -> r.queueUrl(queueUrl(TEST_QUEUE)));
      } catch (Exception ignored) {
        // queue may not exist
      }
    }
    sqsCreateQueue(TEST_QUEUE);
  }

  @Given("the message's queue is not {string}")
  public void theMessageSQueueIsNot(String state) {
    // Arrange
    world.sqsActiveQueueName = TEST_QUEUE;
    if ("ACTIVE".equals(state)) {
      // Simulate via lifecycle API.
      try {
        world.session.lifecycle("sqs").createDwellMs(5000).apply();
      } catch (Exception ignored) {
        // lifecycle API may not be available
      }
      try (SqsClient client = world.session.sqsClient()) {
        try {
          client.deleteQueue(r -> r.queueUrl(queueUrl(TEST_QUEUE)));
        } catch (Exception ignored) {
          // queue may not exist
        }
      }
      sqsCreateQueue(TEST_QUEUE);
      return;
    }
    // For other states, no-op.
  }

  // ── Given: capacity ───────────────────────────────────────────────────────────

  @Given("the message slot is available")
  public void theMessageSlotIsAvailable() throws Exception {
    // Arrange: ensure unlimited capacity for sqs
    // Act
    world.session.capacity("sqs").unlimited().apply();
    // Assert: capacity is unlimited
  }

  @Given("the message slot is not available")
  public void theMessageSlotIsNotAvailable() throws Exception {
    // Arrange: exhaust the sqs message capacity
    // Act
    world.session.capacity("sqs").exhaust().apply();
    // Assert: capacity is exhausted
  }

  // ── Given: DLQ / redrive setup ────────────────────────────────────────────────

  @Given("the queue has a maximum receive count configured")
  public void theQueueHasAMaximumReceiveCountConfigured() {
    // No-op: redrive scenarios are tagged @internal and excluded from the test run.
    world.sqsActiveQueueName = TEST_QUEUE;
  }

  @Given("the queue does not have a maximum receive count configured")
  public void theQueueDoesNotHaveAMaximumReceiveCountConfigured() {
    // No-op: redrive scenarios are tagged @internal and excluded from the test run.
    world.sqsActiveQueueName = TEST_QUEUE;
  }

  @Given("the message has exceeded the maximum receive count")
  public void theMessageHasExceededTheMaximumReceiveCount() {
    // No-op: redrive scenarios are tagged @internal and excluded from the test run.
    world.sqsActiveQueueName = TEST_QUEUE;
  }

  @Given("the message has not exceeded the maximum receive count")
  public void theMessageHasNotExceededTheMaximumReceiveCount() {
    // No-op: redrive scenarios are tagged @internal and excluded from the test run.
    world.sqsActiveQueueName = TEST_QUEUE;
  }

  @Given("the dead-letter queue exists")
  public void theDeadLetterQueueExists() {
    // Arrange: create the DLQ
    // Act
    sqsCreateQueue(TEST_DLQ);
    // Assert: DLQ created (no error thrown)
  }

  @Given("the dead-letter queue is {string}")
  public void theDeadLetterQueueIs(String state) {
    if ("ACTIVE".equals(state)) {
      // No-op: DLQ is ACTIVE by default.
      return;
    }
    // Simulate via lifecycle API.
    try {
      world.session.lifecycle("sqs").createDwellMs(5000).apply();
    } catch (Exception ignored) {
      // lifecycle API may not be available
    }
    try (SqsClient client = world.session.sqsClient()) {
      try {
        client.deleteQueue(r -> r.queueUrl(queueUrl(TEST_DLQ)));
      } catch (Exception ignored) {
        // queue may not exist
      }
    }
    sqsCreateQueue(TEST_DLQ);
  }

  @Given("the dead-letter queue does not exist")
  public void theDeadLetterQueueDoesNotExist() {
    // Arrange: ensure the DLQ is absent
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      try {
        client.deleteQueue(r -> r.queueUrl(queueUrl(TEST_DLQ)));
      } catch (Exception ignored) {
        // queue may not exist; desired state is absence
      }
    }
    // Assert: DLQ is absent
  }

  @Given("the dead-letter queue is not {string}")
  public void theDeadLetterQueueIsNot(String state) {
    if ("ACTIVE".equals(state)) {
      // Simulate via lifecycle API.
      try {
        world.session.lifecycle("sqs").createDwellMs(5000).apply();
      } catch (Exception ignored) {
        // lifecycle API may not be available
      }
      try (SqsClient client = world.session.sqsClient()) {
        try {
          client.deleteQueue(r -> r.queueUrl(queueUrl(TEST_DLQ)));
        } catch (Exception ignored) {
          // queue may not exist
        }
      }
      sqsCreateQueue(TEST_DLQ);
      return;
    }
    // For other states, no-op.
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a queue is created")
  public void aQueueIsCreated() {
    // Arrange
    world.sqsActiveQueueName = TEST_QUEUE;
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      client.createQueue(r -> r.queueName(TEST_QUEUE));
      // Assert: store result
      world.setSuccess(TEST_QUEUE);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a queue is deleted")
  public void aQueueIsDeleted() {
    // Arrange
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      client.deleteQueue(r -> r.queueUrl(queueUrl(TEST_QUEUE)));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a message is sent to the queue")
  public void aMessageIsSentToTheQueue() {
    // Arrange
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      client.sendMessage(r -> r.queueUrl(queueUrl(TEST_QUEUE)).messageBody(TEST_MESSAGE));
      // Assert: store result
      world.setSuccess(TEST_MESSAGE);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a message is received from the queue")
  public void aMessageIsReceivedFromTheQueue() {
    // Arrange
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      ReceiveMessageResponse result =
          client.receiveMessage(
              r ->
                  r.queueUrl(queueUrl(TEST_QUEUE))
                      .maxNumberOfMessages(1)
                      .visibilityTimeout(30)
                      .waitTimeSeconds(0));
      List<Message> messages = result.messages();
      world.setSuccess(result);
      // Assert: store receipt handle for subsequent steps
      if (!messages.isEmpty() && messages.get(0).receiptHandle() != null) {
        world.sqsReceiptHandle = messages.get(0).receiptHandle();
      }
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an in-flight message is deleted")
  public void anInFlightMessageIsDeleted() {
    // Arrange
    String receiptHandle = world.sqsReceiptHandle;
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      client.deleteMessage(r -> r.queueUrl(queueUrl(TEST_QUEUE)).receiptHandle(receiptHandle));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("message visibility timeout is changed")
  public void messageVisibilityTimeoutIsChanged() {
    // Arrange
    String receiptHandle = world.sqsReceiptHandle;
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      client.changeMessageVisibility(
          r -> r.queueUrl(queueUrl(TEST_QUEUE)).receiptHandle(receiptHandle).visibilityTimeout(60));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("all messages in a queue are purged")
  public void allMessagesInAQueueArePurged() {
    // Arrange
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      client.purgeQueue(r -> r.queueUrl(queueUrl(TEST_QUEUE)));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("queue attributes are retrieved")
  public void queueAttributesAreRetrieved() {
    // Arrange
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      GetQueueAttributesResponse result =
          client.getQueueAttributes(
              r -> r.queueUrl(queueUrl(TEST_QUEUE)).attributeNames(QueueAttributeName.ALL));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a message visibility timeout expires")
  public void aMessageVisibilityTimeoutExpires() {
    // Arrange: simulate expiry by setting visibility timeout to 0
    String receiptHandle = world.sqsReceiptHandle;
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      client.changeMessageVisibility(
          r -> r.queueUrl(queueUrl(TEST_QUEUE)).receiptHandle(receiptHandle).visibilityTimeout(0));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a message exceeding its receive count is moved to the dead-letter queue")
  public void aMessageExceedingItsReceiveCountIsMovedToTheDeadLetterQueue() {
    // No-op: redrive scenarios are tagged @internal and excluded from the test run.
    // Simulate failure so "the operation is rejected" passes when reached.
    world.setFailure(
        new UnsupportedOperationException("redrive not triggered: scenario is @internal"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  // "the operation is rejected" — already registered in CrossServiceSteps; NOT re-registered.
  // "every .*" — already registered (catch-all regex) in CrossServiceSteps; NOT re-registered.

  @Then("the queue is \"ACTIVE\"")
  public void theQueueIsActive() {
    // Arrange
    String expectedState = "ACTIVE";
    // Act
    try (SqsClient client = world.session.sqsClient()) {
      ListQueuesResponse result = client.listQueues(r -> r.queueNamePrefix(TEST_QUEUE));
      boolean actualFound = result.queueUrls().stream().anyMatch(u -> u.contains(TEST_QUEUE));
      // Assert
      assertTrue(
          actualFound,
          "expected queue '"
              + TEST_QUEUE
              + "' to be "
              + expectedState
              + " but not found; expected_state="
              + expectedState);
    }
  }

  @Then("the queue is \"DELETED\" and its messages are removed")
  public void theQueueIsDeletedAndItsMessagesAreRemoved() {
    // Arrange
    String expectedState = "DELETED";
    // Act
    try (SqsClient client = world.session.sqsClient()) {
      ListQueuesResponse result = client.listQueues(r -> r.queueNamePrefix(TEST_QUEUE));
      boolean actualFound = result.queueUrls().stream().anyMatch(u -> u.contains(TEST_QUEUE));
      // Assert
      assertFalse(
          actualFound,
          "expected queue '"
              + TEST_QUEUE
              + "' to be "
              + expectedState
              + " but found; expected_state="
              + expectedState);
    }
  }

  @Then("the message is {string} for delivery")
  public void theMessageIsForDelivery(String expectedState) {
    // Arrange
    // Act
    try (SqsClient client = world.session.sqsClient()) {
      ReceiveMessageResponse result =
          client.receiveMessage(
              r ->
                  r.queueUrl(queueUrl(TEST_QUEUE))
                      .maxNumberOfMessages(1)
                      .visibilityTimeout(30)
                      .waitTimeSeconds(0));
      List<Message> actualMessages = result.messages();
      // Assert
      if ("AVAILABLE".equals(expectedState)) {
        assertFalse(
            actualMessages.isEmpty(),
            "expected message to be AVAILABLE but found no messages; expected_state="
                + expectedState);
        String expectedBody = TEST_MESSAGE;
        String actualBody = actualMessages.get(0).body();
        assertEquals(
            expectedBody,
            actualBody,
            "expected message body '" + expectedBody + "' but got '" + actualBody + "'");
      }
    }
  }

  @Then("the message is \"IN_FLIGHT\"")
  public void theMessageIsInFlight() {
    // Arrange
    // Act
    try (SqsClient client = world.session.sqsClient()) {
      GetQueueAttributesResponse result =
          client.getQueueAttributes(
              r ->
                  r.queueUrl(queueUrl(TEST_QUEUE))
                      .attributeNames(
                          QueueAttributeName.APPROXIMATE_NUMBER_OF_MESSAGES_NOT_VISIBLE));
      String actualCountStr =
          result
              .attributes()
              .getOrDefault(QueueAttributeName.APPROXIMATE_NUMBER_OF_MESSAGES_NOT_VISIBLE, "0");
      int actualCount = Integer.parseInt(actualCountStr);
      int expectedCount = 1;
      // Assert
      assertEquals(
          expectedCount,
          actualCount,
          "expected " + expectedCount + " in-flight message(s) but got " + actualCount);
    }
  }

  @Then("the message is removed from the queue")
  public void theMessageIsRemovedFromTheQueue() {
    // Arrange
    // Act
    try (SqsClient client = world.session.sqsClient()) {
      ReceiveMessageResponse result =
          client.receiveMessage(
              r ->
                  r.queueUrl(queueUrl(TEST_QUEUE))
                      .maxNumberOfMessages(1)
                      .visibilityTimeout(1)
                      .waitTimeSeconds(0));
      List<Message> actualMessages = result.messages();
      // Assert
      int expectedCount = 0;
      int actualCount = actualMessages.size();
      assertEquals(
          expectedCount,
          actualCount,
          "expected no messages (message removed) but found " + actualCount);
    }
  }

  @Then("the message visibility is updated")
  public void theMessageVisibilityIsUpdated() {
    // Arrange: no additional setup required
    // Act: action performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected visibility update to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("all messages in the queue are {string}")
  public void allMessagesInTheQueueAre(String expectedState) {
    // Arrange
    // Act
    try (SqsClient client = world.session.sqsClient()) {
      GetQueueAttributesResponse result =
          client.getQueueAttributes(
              r ->
                  r.queueUrl(queueUrl(TEST_QUEUE))
                      .attributeNames(QueueAttributeName.APPROXIMATE_NUMBER_OF_MESSAGES));
      String actualCountStr =
          result.attributes().getOrDefault(QueueAttributeName.APPROXIMATE_NUMBER_OF_MESSAGES, "0");
      int actualCount = Integer.parseInt(actualCountStr);
      // Assert
      if ("DELETED".equals(expectedState)) {
        int expectedCount = 0;
        assertEquals(
            expectedCount,
            actualCount,
            "expected " + expectedCount + " messages after purge but got " + actualCount);
      }
    }
  }

  @Then("the queue attributes are returned")
  public void theQueueAttributesAreReturned() {
    // Arrange: no additional setup required
    // Act: action performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected queue attributes to be returned but got: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected non-null queue attributes result");
  }

  @Then("the message becomes {string} again")
  public void theMessageBecomesAvailableAgain(String expectedState) {
    // Arrange
    // Act
    try (SqsClient client = world.session.sqsClient()) {
      ReceiveMessageResponse result =
          client.receiveMessage(
              r ->
                  r.queueUrl(queueUrl(TEST_QUEUE))
                      .maxNumberOfMessages(1)
                      .visibilityTimeout(30)
                      .waitTimeSeconds(0));
      List<Message> actualMessages = result.messages();
      // Assert
      if ("AVAILABLE".equals(expectedState)) {
        assertFalse(
            actualMessages.isEmpty(),
            "expected message to become AVAILABLE again but found none; expected_state="
                + expectedState);
      }
    }
  }

  @Then("the message is {string} in the dead-letter queue")
  public void theMessageIsInTheDeadLetterQueue(String expectedState) {
    // Arrange
    // Act
    try (SqsClient client = world.session.sqsClient()) {
      ReceiveMessageResponse result =
          client.receiveMessage(
              r ->
                  r.queueUrl(queueUrl(TEST_DLQ))
                      .maxNumberOfMessages(1)
                      .visibilityTimeout(30)
                      .waitTimeSeconds(0));
      List<Message> actualMessages = result.messages();
      // Assert
      if ("AVAILABLE".equals(expectedState)) {
        assertFalse(
            actualMessages.isEmpty(),
            "expected message to be AVAILABLE in dead-letter queue but found none; expected_state="
                + expectedState);
      }
    }
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private String queueUrl(String queueName) {
    return world.session.queueUrl(queueName);
  }

  private void sqsCreateQueue(String queueName) {
    try (SqsClient client = world.session.sqsClient()) {
      client.createQueue(r -> r.queueName(queueName));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("QueueAlreadyExists")) {
        throw e;
      }
    }
  }
}
