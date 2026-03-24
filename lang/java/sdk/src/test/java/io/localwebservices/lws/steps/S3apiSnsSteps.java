package io.localwebservices.lws.steps;

/**
 * Step definitions for the s3api_sns cross-service feature files.
 *
 * <p>Covers: create_bucket, create_topic, configure_notification, put_object_with_notification,
 * put_object_notification_fails, delete_topic, sequences.
 *
 * <p>All steps used by this suite are already defined in {@link CrossServiceSteps} (system
 * initialisation, bucket/topic Given setups, notification configuration, object upload, invariant
 * catch-alls). No suite-specific steps are needed here.
 */
public class S3apiSnsSteps {

  private final WorldContext world;

  public S3apiSnsSteps(WorldContext world) {
    this.world = world;
  }
}
