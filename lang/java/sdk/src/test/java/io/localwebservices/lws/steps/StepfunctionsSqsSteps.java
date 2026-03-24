package io.localwebservices.lws.steps;

/**
 * Step definitions for the stepfunctions_sqs cross-service feature files.
 *
 * <p>Covers: create_state_machine, create_queue, configure_s_q_s_task, send_message_task,
 * start_execution, sequences.
 *
 * <p>All steps used by this suite are already defined in {@link CrossServiceSteps} (system
 * initialisation, state machine/queue Given setups, task configuration, execution start/run,
 * invariant catch-alls). No suite-specific steps are needed here.
 */
public class StepfunctionsSqsSteps {

  private final WorldContext world;

  public StepfunctionsSqsSteps(WorldContext world) {
    this.world = world;
  }
}
