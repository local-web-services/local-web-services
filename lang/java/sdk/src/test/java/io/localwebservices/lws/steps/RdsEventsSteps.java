package io.localwebservices.lws.steps;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.rds.RdsClient;

/**
 * Step definitions for the rds_events cross-service informal specification feature files.
 *
 * <p>Covers: create_d_b_instance, create_event_bus, delete_event_bus.
 *
 * <p>Internal-only actions (d_b_stop_complete, d_b_stop_event_delivered, d_b_stop_event_fails) are
 * registered as no-ops with {@code @internal} comments because they cannot be triggered via public
 * AWS APIs in an lws environment.
 */
public class RdsEventsSteps {

  private static final String TEST_DB_INSTANCE_ID = "test-rds-db-1";
  private static final String TEST_DB_ENGINE = "mysql";
  private static final String TEST_DB_CLASS = "db.t3.micro";

  private final WorldContext world;

  public RdsEventsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Given: DB instance state setup ───────────────────────────────────────────

  @Given("the \"DB\" instance does not already exist")
  public void theDbInstanceDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no DB instances.
  }

  @Given("the \"DB\" instance already exists")
  public void theDbInstanceAlreadyExists() {
    // Arrange
    // Act
    rdsEventsCreateDBInstance();
    // Assert: DB instance created (no error thrown)
  }

  @Given("the \"DB\" instance is \"AVAILABLE\"")
  public void theDbInstanceIsAvailable() {
    // Arrange
    // Act: create the DB instance (lws instances are AVAILABLE after creation)
    rdsEventsCreateDBInstance();
    // Assert: DB instance created (no error thrown)
  }

  @Given("the \"DB\" instance is not \"AVAILABLE\"")
  public void theDbInstanceIsNotAvailable() {
    // @internal: Cannot force a DB instance into a non-AVAILABLE state via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
    Assumptions.assumeTrue(
        false, "Cannot force a DB instance into a non-AVAILABLE state via public API.");
  }

  @Given("the \"DB\" instance is \"STOPPING\"")
  public void theDbInstanceIsStopping() {
    // @internal: Cannot force a DB instance into STOPPING state via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
    Assumptions.assumeTrue(false, "Cannot force a DB instance into STOPPING state via public API.");
  }

  @Given("the \"DB\" instance is not \"STOPPING\"")
  public void theDbInstanceIsNotStopping() {
    // @internal: DB stop state not reachable via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
    Assumptions.assumeTrue(false, "DB stop state not reachable via public API.");
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("an \"RDS\" \"DB\" instance is created and becomes \"AVAILABLE\"")
  public void anRdsDbInstanceIsCreatedAndBecomesAvailable() {
    // Arrange: (DB instance state set up by Given steps)
    try (RdsClient client = world.session.rdsClient()) {
      // Act
      var result =
          client.createDBInstance(
              r ->
                  r.dbInstanceIdentifier(TEST_DB_INSTANCE_ID)
                      .dbInstanceClass(TEST_DB_CLASS)
                      .engine(TEST_DB_ENGINE)
                      .masterUsername("admin")
                      .masterUserPassword("password123"));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the \"DB\" instance finishes stopping")
  public void theDbInstanceFinishesStopping() {
    // @internal: d_b_stop_complete cannot be triggered via public API.
    world.setFailure(new UnsupportedOperationException("d_b_stop_complete: scenario is @internal"));
  }

  @When("the \"RDS\" instance stops and delivers the state change event to the EventBridge bus")
  public void theRdsInstanceStopsAndDeliversTheStateChangeEvent() {
    // @internal: d_b_stop_event_delivered cannot be triggered via public API.
    world.setFailure(
        new UnsupportedOperationException("d_b_stop_event_delivered: scenario is @internal"));
  }

  @When(
      "the \"RDS\" instance stops but the state change event delivery fails because the bus is deleted")
  public void theRdsInstanceStopsButEventDeliveryFails() {
    // @internal: d_b_stop_event_fails cannot be triggered via public API.
    world.setFailure(
        new UnsupportedOperationException("d_b_stop_event_fails: scenario is @internal"));
  }

  // "the bus is \"DELETED\" and \"RDS\" event delivery will fail" is handled by
  // SsmEventsSteps.theBusIsDeletedAndSsmEventDeliveryWillFail(service) via the {string} pattern,
  // which matches both "RDS" and "SSM". Absent here to avoid AmbiguousStepDefinitionsException.

  @Then("the \"DB\" instance is \"STOPPED\"")
  public void theDbInstanceIsStopped() {
    // @internal: d_b_stop_complete outcome not observable via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
    Assumptions.assumeTrue(false, "d_b_stop_complete outcome not observable via public API.");
  }

  @Then("the \"DB\" instance is \"STOPPING\" and the event is \"DELIVERED\"")
  public void theDbInstanceIsStoppingAndTheEventIsDelivered() {
    // @internal: d_b_stop_event_delivered outcome not observable via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
    Assumptions.assumeTrue(
        false, "d_b_stop_event_delivered outcome not observable via public API.");
  }

  @Then("the \"DB\" instance is \"STOPPING\" but no event is delivered")
  public void theDbInstanceIsStoppingButNoEventIsDelivered() {
    // @internal: d_b_stop_event_fails outcome not observable via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
    Assumptions.assumeTrue(false, "d_b_stop_event_fails outcome not observable via public API.");
  }

  // ── Invariant catch-all steps ──────────────────────────────────────────────────

  // "every \"DELIVERED\" event references a \"DB\" instance that exists" → CrossServiceSteps
  // (catch-all @And("^every .*$"))

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void rdsEventsCreateDBInstance() {
    try (RdsClient client = world.session.rdsClient()) {
      client.createDBInstance(
          r ->
              r.dbInstanceIdentifier(TEST_DB_INSTANCE_ID)
                  .dbInstanceClass(TEST_DB_CLASS)
                  .engine(TEST_DB_ENGINE)
                  .masterUsername("admin")
                  .masterUserPassword("password123"));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already") && !msg.contains("DBInstanceAlreadyExists")) {
        throw e;
      }
    }
  }
}
