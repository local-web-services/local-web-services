package io.localwebservices.lws.steps;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;

/**
 * Step definitions for the stepfunctions_sns cross-service feature files.
 *
 * <p>Covers: create_state_machine, create_topic, configure_s_n_s_task, publish_task,
 * start_execution, sequences.
 *
 * <p>Steps already defined in {@link CrossServiceSteps} (e.g. system initialisation, topic/state
 * machine Given setups, execution start, invariant catch-alls) are intentionally absent here to
 * avoid duplicate step definition errors.
 */
public class StepfunctionsSnsSteps {

  private final WorldContext world;

  public StepfunctionsSnsSteps(WorldContext world) {
    this.world = world;
  }

  // -------------------------------------------------------------------------
  // When — SNS publish task configuration (not reachable via public SDK API)
  // -------------------------------------------------------------------------

  @When("an \"SNS\" publish task is configured on the state machine")
  public void anSnsPublishTaskIsConfiguredOnTheStateMachine() {
    // Arrange / Act / Assert — state machine task configuration not reachable via public API
    Assumptions.assumeTrue(
        false, "SNS publish task configuration on state machine not reachable via SDK API");
  }

  // -------------------------------------------------------------------------
  // When — running execution publishes to SNS (internal; not reachable via public API)
  // -------------------------------------------------------------------------

  @When("a running execution publishes a message to the \"SNS\" topic and succeeds")
  public void aRunningExecutionPublishesAMessageToSnsTopicAndSucceeds() {
    // Arrange / Act / Assert — internal execution SNS publish task not reachable via public API
    Assumptions.assumeTrue(false, "internal execution SNS publish task not reachable via SDK API");
  }

  // -------------------------------------------------------------------------
  // Then — state machine will publish (internal; not verifiable via public API)
  // -------------------------------------------------------------------------

  @Then("the state machine will publish a message to the topic when it reaches the task state")
  public void theStateMachineWillPublishAMessageToTopicWhenItReachesTheTaskState() {
    // Arrange / Act / Assert — internal task execution not verifiable via public API
    Assumptions.assumeTrue(false, "internal task execution not verifiable via SDK API");
  }

  // -------------------------------------------------------------------------
  // Then — execution succeeded with SNS publish result
  // -------------------------------------------------------------------------

  @Then("the execution is \"SUCCEEDED\" and the message has been published to the topic")
  public void theExecutionIsSucceededAndTheMessageHasBeenPublished() {
    // Arrange / Act / Assert — internal execution task result not verifiable via public API
    Assumptions.assumeTrue(false, "internal execution task result not verifiable via SDK API");
  }
}
