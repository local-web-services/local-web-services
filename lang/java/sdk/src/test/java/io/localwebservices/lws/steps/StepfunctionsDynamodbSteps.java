package io.localwebservices.lws.steps;

/**
 * Step definitions for the stepfunctions_dynamodb cross-service feature files.
 *
 * <p>Covers: create_state_machine, create_table, configure_dynamo_d_b_task, put_item_task,
 * get_item_not_found_task, start_execution, sequences.
 *
 * <p>All steps used by this suite are already defined in {@link CrossServiceSteps} (system
 * initialisation, state machine/table Given setups, task configuration, execution start/run,
 * invariant catch-alls). No suite-specific steps are needed here.
 */
public class StepfunctionsDynamodbSteps {

  private final WorldContext world;

  public StepfunctionsDynamodbSteps(WorldContext world) {
    this.world = world;
  }
}
