package io.localwebservices.lws.steps;

/**
 * Step definitions for the events_sqs cross-service feature files.
 *
 * <p>Covers: create_event_bus, create_queue, put_rule, put_event, consume_message, sequences.
 *
 * <p>All steps used by this suite are already defined in {@link CrossServiceSteps} (system
 * initialisation, event bus/queue Given setups, rule creation, event publish/route, consume,
 * invariant catch-alls). No suite-specific steps are needed here.
 */
public class EventsSqsSteps {

  private final WorldContext world;

  public EventsSqsSteps(WorldContext world) {
    this.world = world;
  }
}
