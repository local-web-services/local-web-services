package io.localwebservices.lws.steps;

/**
 * Step definitions for the events_sns cross-service feature files.
 *
 * <p>Covers: create_event_bus, create_topic, put_rule, put_event, consume_message, sequences.
 *
 * <p>All steps used by this suite are already defined in {@link CrossServiceSteps} (system
 * initialisation, event bus/topic Given setups, rule creation, event publish/route, consume,
 * invariant catch-alls). No suite-specific steps are needed here.
 */
public class EventsSnsSteps {

  private final WorldContext world;

  public EventsSnsSteps(WorldContext world) {
    this.world = world;
  }
}
