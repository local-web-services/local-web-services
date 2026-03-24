package io.localwebservices.lws.steps;

/**
 * Step definitions for the sns_sqs cross-service feature files.
 *
 * <p>Covers: create_queue, create_topic, subscribe_queue_to_topic, publish_and_deliver,
 * consume_message, sequences.
 *
 * <p>All steps used by this suite are already defined in {@link CrossServiceSteps} (system
 * initialisation, queue/topic Given setups, subscription, publish/deliver, consume, invariant
 * catch-alls). No suite-specific steps are needed here.
 */
public class SnsSqsSteps {

  private final WorldContext world;

  public SnsSqsSteps(WorldContext world) {
    this.world = world;
  }
}
