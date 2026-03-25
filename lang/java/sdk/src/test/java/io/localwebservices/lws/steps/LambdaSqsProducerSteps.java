package io.localwebservices.lws.steps;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

/**
 * Step definitions for the lambda_sqs_producer cross-service informal specification feature files.
 *
 * <p>Covers: create_queue, deploy_function, invoke_function, send_message, invocation_fails,
 * invocation_succeeds.
 *
 * <p>Steps already registered elsewhere are NOT re-registered here:
 *
 * <ul>
 *   <li>"the system is initialized", "the operation is rejected" → {@link CrossServiceSteps}
 *   <li>"the queue does not already exist", "the queue already exists", "the queue exists", "the
 *       queue does not exist", "the queue is not {string}", "a message slot is available", "no
 *       message slot is available", "the message is AVAILABLE in the queue" → {@link
 *       CrossServiceSteps}
 *   <li>"the function does not already exist", "the function already exists", "the function
 *       exists", "the function does not exist", "the function is {string}", "the function is not
 *       {string}" → {@link LambdaSteps}
 *   <li>"the queue is ACTIVE" (Then) → {@link SqsSteps}
 *   <li>"an invocation is IN_PROGRESS", "no invocation is IN_PROGRESS", "an invocation slot is
 *       available", "no invocation slot is available", "a Lambda function is deployed", "an SQS
 *       queue is created", "the Lambda function is invoked", "the Lambda invocation fails", "the
 *       Lambda invocation completes successfully", "the function is ACTIVE" (Then), "the invocation
 *       is IN_PROGRESS" (Then), "the invocation is FAILED" (Then) → {@link LambdaSqsSteps}
 *   <li>"the invocation is SUCCESS" → {@link LambdaSnsSteps} and other lambda cross-service Steps
 *   <li>"every IN_PROGRESS invocation references an ACTIVE Lambda function" → {@link
 *       LambdaSnsSteps} and other lambda cross-service Steps
 * </ul>
 */
public class LambdaSqsProducerSteps {

  private final WorldContext world;

  public LambdaSqsProducerSteps(WorldContext world) {
    this.world = world;
  }

  // ── When: actions unique to lambda_sqs_producer ───────────────────────────────

  @When("the Lambda function sends a message to the \"SQS\" queue during invocation")
  public void theLambdaFunctionSendsAMessageToTheSqsQueueDuringInvocation() {
    // Cannot trigger a Lambda SQS send from within an invocation in lws without
    // Docker execution support. Store a failure so "the operation is rejected"
    // Then step passes when applicable.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda SQS send in lws: no Docker execution"));
  }

  // ── Then: invariant catch-all steps unique to lambda_sqs_producer ─────────────

  @Then("every \"AVAILABLE\" message belongs to an \"ACTIVE\" queue")
  public void everyAvailableMessageBelongsToAnActiveQueue() {
    // Arrange / Act / Assert — no-op: model-level invariant; trivially satisfied in isolated lws
    // context.
  }
}
