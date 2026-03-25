package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.Map;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.GetQueueAttributesResponse;
import software.amazon.awssdk.services.sqs.model.QueueAttributeName;

/**
 * Step definitions for the lambda_sqs cross-service informal specification feature files.
 *
 * <p>Covers: deploy_function, create_queue, configure_redrive, create_event_source_mapping,
 * e_s_m_poll_and_invoke, invocation_fails, invocation_succeeds, message_arrives.
 *
 * <p>Steps already registered in {@link LambdaSteps} (function existence/lifecycle, ESM given
 * steps), {@link SqsSteps} (dead-letter queue given steps), or {@link CrossServiceSteps} (system
 * initialized, operation rejected, queue existence, message slot steps) are NOT re-registered here.
 */
public class LambdaSqsSteps {

  private static final String TEST_FUNC = "e2e-test-func-1";
  private static final String TEST_QUEUE = "e2e-test-q1";
  private static final String TEST_DLQ = "e2e-test-dlq-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT_ID = "000000000000";
  private static final ObjectMapper MAPPER = new ObjectMapper();

  private final WorldContext world;

  public LambdaSqsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private String queueUrl(String queueName) {
    return world.session.queueUrl(queueName);
  }

  private String queueArn(String queueName) {
    return "arn:aws:sqs:" + TEST_REGION + ":" + TEST_ACCOUNT_ID + ":" + queueName;
  }

  private void createFunction() {
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

  private void createSqsQueue(String queueName) {
    try (SqsClient client = world.session.sqsClient()) {
      // Arrange / Act
      client.createQueue(r -> r.queueName(queueName));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("QueueAlreadyExists")) {
        throw e;
      }
    }
  }

  // ── Given: source queue state ─────────────────────────────────────────────────

  @Given("the source queue exists")
  public void theSourceQueueExists() {
    // Arrange: create the source queue
    // Act
    createSqsQueue(TEST_QUEUE);
    // Assert: source queue created (no error thrown)
  }

  @Given("the source queue does not exist")
  public void theSourceQueueDoesNotExist() {
    // No-op: fresh state has no queues.
  }

  @Given("the source queue is {string}")
  public void theSourceQueueIs(String state) throws Exception {
    // Arrange
    if ("ACTIVE".equals(state)) {
      // No-op: queues are ACTIVE immediately after creation in lws.
      return;
    }
    // Act: apply lifecycle dwell so the source queue is non-ACTIVE
    world.session.lifecycle("sqs").createDwellMs(5000).apply();
    try (SqsClient client = world.session.sqsClient()) {
      try {
        client.deleteQueue(r -> r.queueUrl(queueUrl(TEST_QUEUE)));
      } catch (Exception ignored) {
        // queue may not exist; desired state is non-ACTIVE after re-creation
      }
    }
    createSqsQueue(TEST_QUEUE);
    // Assert: source queue is in non-ACTIVE state
  }

  @Given("the source queue is not {string}")
  public void theSourceQueueIsNot(String state) throws Exception {
    // Arrange
    if ("ACTIVE".equals(state)) {
      // Act: apply lifecycle dwell so the source queue is non-ACTIVE
      world.session.lifecycle("sqs").createDwellMs(5000).apply();
      try (SqsClient client = world.session.sqsClient()) {
        try {
          client.deleteQueue(r -> r.queueUrl(queueUrl(TEST_QUEUE)));
        } catch (Exception ignored) {
          // queue may not exist
        }
      }
      createSqsQueue(TEST_QUEUE);
      // Assert: source queue is in non-ACTIVE state
      return;
    }
    // For other states, no-op.
  }

  @Given("the source queue has no dead-letter queue configured")
  public void theSourceQueueHasNoDeadLetterQueueConfigured() {
    // No-op: queue created without a DLQ.
  }

  @Given("the source queue already has a dead-letter queue configured")
  public void theSourceQueueAlreadyHasADeadLetterQueueConfigured() throws Exception {
    // Arrange: ensure source queue and DLQ exist
    createSqsQueue(TEST_QUEUE);
    createSqsQueue(TEST_DLQ);
    // Act: apply redrive policy
    String expectedDlqArn = queueArn(TEST_DLQ);
    String redrivePolicy =
        MAPPER.writeValueAsString(
            Map.of("deadLetterTargetArn", expectedDlqArn, "maxReceiveCount", 2));
    try (SqsClient client = world.session.sqsClient()) {
      client.setQueueAttributes(
          r ->
              r.queueUrl(queueUrl(TEST_QUEUE))
                  .attributes(Map.of(QueueAttributeName.REDRIVE_POLICY, redrivePolicy)));
    }
    // Assert: redrive policy applied (no error thrown)
  }

  // ── Given: event source mapping state (lambda_sqs-specific phrasings) ─────────
  // "the event source mapping does not already exist", "the event source mapping already exists",
  // "the event source mapping exists", "the event source mapping does not exist" are already
  // registered in LambdaSteps — NOT re-registered here.

  @Given("the event source mapping is {string}")
  public void theEventSourceMappingIs(String state) {
    // @internal: Cannot pre-create enabled event source mapping in lws.
  }

  @Given("the event source mapping is not {string}")
  public void theEventSourceMappingIsNot(String state) {
    // @internal: Cannot pre-create disabled event source mapping in lws.
  }

  @Given("the mapped function is {string}")
  public void theMappedFunctionIs(String state) {
    // @internal: Cannot set up event source mapping in lws.
  }

  @Given("the mapped function is not {string}")
  public void theMappedFunctionIsNot(String state) {
    // @internal: Cannot set up event source mapping in lws.
  }

  @Given("an \"AVAILABLE\" message exists in the mapped queue")
  public void anAvailableMessageExistsInTheMappedQueue() {
    // @internal: Cannot set up event source mapping in lws.
  }

  @Given("no \"AVAILABLE\" message exists in the mapped queue")
  public void noAvailableMessageExistsInTheMappedQueue() {
    // @internal: Cannot set up event source mapping in lws.
  }

  @When("the \"SQS\" queue is configured with a dead-letter queue")
  public void theSqsQueueIsConfiguredWithADeadLetterQueue() throws Exception {
    // Arrange
    String expectedDlqArn = queueArn(TEST_DLQ);
    String redrivePolicy =
        MAPPER.writeValueAsString(
            Map.of("deadLetterTargetArn", expectedDlqArn, "maxReceiveCount", 2));
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      client.setQueueAttributes(
          r ->
              r.queueUrl(queueUrl(TEST_QUEUE))
                  .attributes(Map.of(QueueAttributeName.REDRIVE_POLICY, redrivePolicy)));
      // Assert: store result
      world.setSuccess(TEST_QUEUE);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a Lambda event source mapping is created linking a queue to a function")
  public void aLambdaEventSourceMappingIsCreatedLinkingAQueueToAFunction() {
    // @internal: Cannot create event source mapping in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot create ESM linking queue to function: scenario is @internal"));
  }

  @When("the event source mapping polls the queue and invokes the Lambda function")
  public void theEventSourceMappingPollsTheQueueAndInvokesTheLambdaFunction() {
    // @internal: Cannot trigger ESM polling in lws.
    world.setFailure(
        new UnsupportedOperationException("cannot trigger ESM polling: scenario is @internal"));
  }

  @When("a message arrives in the \"SQS\" queue")
  public void aMessageArrivesInTheSqsQueue() {
    // @internal: Cannot trigger internal message arrival in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal message arrival: scenario is @internal"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────
  // "the function is {string}" is already registered in LambdaSteps — NOT re-registered here.
  // "the operation is rejected" is already registered in CrossServiceSteps — NOT re-registered
  // here.

  @Then("the queue is \"ACTIVE\" with no dead-letter queue configured")
  public void theQueueIsActiveWithNoDeadLetterQueueConfigured() {
    // Arrange
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      GetQueueAttributesResponse result =
          client.getQueueAttributes(
              r ->
                  r.queueUrl(queueUrl(TEST_QUEUE))
                      .attributeNames(QueueAttributeName.REDRIVE_POLICY));
      String actualRedrive =
          result.attributes().getOrDefault(QueueAttributeName.REDRIVE_POLICY, "");
      // Assert
      String expectedRedrive = "";
      assertEquals(
          expectedRedrive,
          actualRedrive,
          "expected no RedrivePolicy but got '"
              + actualRedrive
              + "'; expected_redrive='"
              + expectedRedrive
              + "' actual_redrive='"
              + actualRedrive
              + "'");
    }
  }

  @Then("failed messages will be redriven to the dead-letter queue after two receives")
  public void failedMessagesWillBeRedrivenToTheDeadLetterQueueAfterTwoReceives() throws Exception {
    // Arrange
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      GetQueueAttributesResponse result =
          client.getQueueAttributes(
              r ->
                  r.queueUrl(queueUrl(TEST_QUEUE))
                      .attributeNames(QueueAttributeName.REDRIVE_POLICY));
      String actualPolicy = result.attributes().getOrDefault(QueueAttributeName.REDRIVE_POLICY, "");
      assertTrue(!actualPolicy.isEmpty(), "Expected a RedrivePolicy to be configured but got none");
      // Assert
      @SuppressWarnings("unchecked")
      Map<String, Object> parsed = MAPPER.readValue(actualPolicy, Map.class);
      Object rawCount = parsed.get("maxReceiveCount");
      int actualCount = rawCount instanceof Number ? ((Number) rawCount).intValue() : 0;
      int expectedCount = 2;
      assertEquals(
          expectedCount,
          actualCount,
          "expected maxReceiveCount '"
              + expectedCount
              + "' but got '"
              + actualCount
              + "'; expected_count="
              + expectedCount
              + " actual_count="
              + actualCount);
    }
  }

  @Then("the event source mapping is \"ENABLED\" and will poll the queue for messages")
  public void theEventSourceMappingIsEnabledAndWillPollTheQueueForMessages() {
    // @internal: Cannot observe event source mapping state in lws.
  }

  @Then("the invocation is \"SUCCESS\" and the \"SQS\" message is \"DELETED\"")
  public void theInvocationIsSuccessAndTheSqsMessageIsDeleted() {
    // @internal: Cannot observe Lambda invocation result in lws.
  }

  @Then(
      "if the receive count is below the threshold the message is \"AVAILABLE\""
          + " for reprocessing, otherwise it is redriven to the dead-letter queue")
  public void ifTheReceiveCountIsBelowTheThresholdTheMessageIsAvailableForReprocessing() {
    // @internal: Cannot observe Lambda SQS failure handling in lws.
  }

  @Then("the message is \"IN_FLIGHT\" and a Lambda invocation is \"IN_PROGRESS\"")
  public void theMessageIsInFlightAndALambdaInvocationIsInProgress() {
    // @internal: Cannot observe ESM polling result in lws.
  }

  @Then("the message is \"AVAILABLE\" for processing")
  public void theMessageIsAvailableForProcessing() {
    // @internal: Cannot observe internal message state in lws.
  }

  // ── Then: invariants ──────────────────────────────────────────────────────────

  // "every in-progress invocation was initiated by an \"ENABLED\" event source mapping" → CrossServiceSteps (catch-all @And("^every .*$"))
  // "every in-progress invocation references an \"ACTIVE\" Lambda function" → CrossServiceSteps (catch-all @And("^every .*$"))
  // "every \"AVAILABLE\" or \"IN_FLIGHT\" message belongs to an \"ACTIVE\" queue" → CrossServiceSteps (catch-all @And("^every .*$"))
  // "every \"ENABLED\" event source mapping references an \"ACTIVE\" queue" → CrossServiceSteps (catch-all @And("^every .*$"))
}
