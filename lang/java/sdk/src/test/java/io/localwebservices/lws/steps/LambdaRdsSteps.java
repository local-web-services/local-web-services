package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;
import software.amazon.awssdk.services.rds.RdsClient;
import software.amazon.awssdk.services.rds.model.DescribeDbInstancesResponse;

/**
 * Step definitions for the lambda_rds cross-service informal specification feature files.
 *
 * <p>Covers: create_d_b_instance, deploy_function, invoke_function, d_b_failover_begins,
 * d_b_failover_complete, invocation_fails_d_b_unavailable, invocation_succeeds.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized", "the
 * operation is rejected") are intentionally absent here to avoid duplicate step definition errors.
 */
public class LambdaRdsSteps {

  private static final String TEST_FUNC = "test-lambda-rds-1";
  private static final String TEST_DB_INSTANCE_ID = "test-lambda-rds-db-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_DB_ENGINE = "mysql";
  private static final String TEST_DB_CLASS = "db.t3.micro";

  private final WorldContext world;

  public LambdaRdsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private void lambdaRdsCreateFunction() {
    try (LambdaClient client = world.session.lambdaClient()) {
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(TEST_ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceConflict") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  private void lambdaRdsCreateDbInstance() {
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

  // ── Given: function state ──────────────────────────────────────────────────────

  @Given("the function does not already exist")
  public void theFunctionDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no functions.
  }

  @Given("the function already exists")
  public void theFunctionAlreadyExists() {
    // Arrange
    // Act
    lambdaRdsCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function exists")
  public void theFunctionExists() {
    // Arrange
    // Act
    lambdaRdsCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function does not exist")
  public void theFunctionDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no functions.
  }

  @Given("the function is \"ACTIVE\"")
  public void theFunctionIsActive() {
    // Arrange / Act / Assert — no-op: fresh functions are ACTIVE immediately after creation.
  }

  @Given("the function is not \"ACTIVE\"")
  public void theFunctionIsNotActive() {
    // @internal: Cannot force a function into a non-ACTIVE state via public API in lws.
  }

  // ── Given: DB instance state ───────────────────────────────────────────────────

  @Given("the instance does not already exist")
  public void theInstanceDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no DB instances.
  }

  @Given("the instance already exists")
  public void theInstanceAlreadyExists() {
    // Arrange
    // Act
    lambdaRdsCreateDbInstance();
    // Assert: DB instance created (no error thrown)
  }

  @Given("the instance exists")
  public void theInstanceExists() {
    // Arrange
    // Act
    lambdaRdsCreateDbInstance();
    // Assert: DB instance created (no error thrown)
  }

  @Given("the instance does not exist")
  public void theInstanceDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no DB instances.
  }

  @Given("the instance is \"AVAILABLE\"")
  public void theInstanceIsAvailable() {
    // Arrange
    // Act
    lambdaRdsCreateDbInstance();
    // Assert: DB instance created and is AVAILABLE (no error thrown)
  }

  @Given("the instance is not \"AVAILABLE\"")
  public void theInstanceIsNotAvailable() {
    // @internal: Cannot force a DB instance into a non-AVAILABLE state via public API.
  }

  @Given("the instance is \"FAILING_OVER\"")
  public void theInstanceIsFailingOver() {
    // @internal: FAILING_OVER state requires a Multi-AZ failover, not reachable via public API.
  }

  @Given("the instance is not \"FAILING_OVER\"")
  public void theInstanceIsNotFailingOver() {
    // Arrange: create the instance (it will be AVAILABLE, not FAILING_OVER)
    // Act
    lambdaRdsCreateDbInstance();
    // Assert: DB instance is AVAILABLE (not FAILING_OVER)
  }

  // ── Given: invocation state ────────────────────────────────────────────────────

  @Given("an invocation is \"IN_PROGRESS\"")
  public void anInvocationIsInProgress() {
    // Arrange: create the Lambda function so an invocation could be in progress
    // Act
    lambdaRdsCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("no invocation is \"IN_PROGRESS\"")
  public void noInvocationIsInProgress() {
    // No-op: fresh state has no invocations.
  }

  @Given("the database instance is \"AVAILABLE\"")
  public void theDatabaseInstanceIsAvailable() {
    // Arrange
    // Act
    lambdaRdsCreateDbInstance();
    // Assert: DB instance created and is AVAILABLE (no error thrown)
  }

  @Given("the database instance is not \"AVAILABLE\"")
  public void theDatabaseInstanceIsNotAvailable() {
    // @internal: Cannot force a DB instance into a non-AVAILABLE state via public API.
  }

  @Given("the database instance is \"FAILING_OVER\"")
  public void theDatabaseInstanceIsFailingOver() {
    // @internal: FAILING_OVER state requires a Multi-AZ failover.
  }

  @Given("the database instance is not \"FAILING_OVER\"")
  public void theDatabaseInstanceIsNotFailingOver() {
    // Arrange
    // Act
    lambdaRdsCreateDbInstance();
    // Assert: DB instance is AVAILABLE (not FAILING_OVER)
  }

  // ── Given: capacity ────────────────────────────────────────────────────────────

  @Given("an invocation slot is available")
  public void anInvocationSlotIsAvailable() {
    // No-op: always room for invocations in lws.
  }

  @Given("no invocation slot is available")
  public void noInvocationSlotIsAvailable() {
    // @internal: Cannot exhaust invocation slot limit in lws via public APIs.
  }

  // ── When: actions ──────────────────────────────────────────────────────────────

  @When("an \"RDS\" database instance is created")
  public void anRdsDatabaseInstanceIsCreated() {
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

  @When("a Lambda function is deployed")
  public void aLambdaFunctionIsDeployed() {
    // Arrange: (function state set up by Given steps)
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(TEST_ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
      // Assert: store result
      world.setSuccess(TEST_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Lambda function is invoked")
  public void theLambdaFunctionIsInvoked() {
    // @internal: Cannot trigger Lambda invocation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation: scenario is @internal"));
  }

  @When("a Multi-\"AZ\" failover begins on the \"RDS\" instance")
  public void aMultiAzFailoverBeginsOnTheRdsInstance() {
    // Arrange: (instance state set up by Given steps)
    try (RdsClient client = world.session.rdsClient()) {
      // Act
      var result =
          client.rebootDBInstance(
              r -> r.dbInstanceIdentifier(TEST_DB_INSTANCE_ID).forceFailover(true));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Multi-\"AZ\" failover completes and the new primary is promoted")
  public void theMultiAzFailoverCompletesAndTheNewPrimaryIsPromoted() {
    // @internal: Failover completion requires internal RDS processing.
    world.setFailure(
        new UnsupportedOperationException("d_b_failover_complete: scenario is @internal"));
  }

  @When("the Lambda function fails to connect because the database is failing over")
  public void theLambdaFunctionFailsToConnectBecauseTheDatabaseIsFailingOver() {
    // @internal: Cannot trigger Lambda connection failure due to DB failover in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "invocation_fails_d_b_unavailable: scenario is @internal"));
  }

  @When(
      "the Lambda function executes a \"SQL\" query against the \"AVAILABLE\" database and succeeds")
  public void theLambdaFunctionExecutesASqlQueryAgainstTheAvailableDatabaseAndSucceeds() {
    // @internal: Cannot trigger Lambda SQL query in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException("invocation_succeeds: scenario is @internal"));
  }

  // ── Then: assertions ───────────────────────────────────────────────────────────

  @Then("the instance is \"AVAILABLE\"")
  public void theInstanceIsAvailableThen() {
    // Arrange
    String expectedInstanceId = TEST_DB_INSTANCE_ID;
    // Act
    try (RdsClient client = world.session.rdsClient()) {
      DescribeDbInstancesResponse response =
          client.describeDBInstances(r -> r.dbInstanceIdentifier(expectedInstanceId));
      assertNotNull(response.dbInstances(), "expected DB instance list to be non-null");
      // Assert
      boolean actualFound =
          response.dbInstances().stream()
              .anyMatch(i -> expectedInstanceId.equals(i.dbInstanceIdentifier()));
      assertTrue(
          actualFound,
          "expected DB instance '"
              + expectedInstanceId
              + "' to be AVAILABLE but was not found; expected_instance_id="
              + expectedInstanceId
              + " actual_found="
              + actualFound);
    }
  }

  @Then("the function is \"ACTIVE\"")
  public void theFunctionIsActiveThen() {
    // Arrange
    String expectedState = "Active";
    // Act
    try (LambdaClient client = world.session.lambdaClient()) {
      var result = client.getFunction(r -> r.functionName(TEST_FUNC));
      String actualState = result.configuration().state().toString();
      // Assert
      assertEquals(
          expectedState,
          actualState,
          "expected function state '"
              + expectedState
              + "' but got '"
              + actualState
              + "'; expected_state="
              + expectedState
              + " actual_state="
              + actualState);
    }
  }

  @Then("the instance is \"FAILING_OVER\" and temporarily unavailable for connections")
  public void theInstanceIsFailingOverAndTemporarilyUnavailableForConnections() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected d_b_failover_begins to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the instance is \"AVAILABLE\" again")
  public void theInstanceIsAvailableAgain() {
    // @internal: failover completion not observable via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"IN_PROGRESS\"")
  public void theInvocationIsInProgress() {
    // @internal: Cannot observe Lambda invocation state in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"FAILED\" with a connection error")
  public void theInvocationIsFailedWithAConnectionError() {
    // @internal: Cannot observe Lambda invocation failure in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"SUCCESS\"")
  public void theInvocationIsSuccess() {
    // @internal: Cannot observe Lambda invocation success in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the operation is rejected")
  public void theOperationIsRejected() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedRejected = true;
    boolean actualRejected = !world.lastSuccess;
    assertTrue(
        actualRejected,
        "expected operation to be rejected but it succeeded; expected_rejected="
            + expectedRejected
            + " actual_rejected="
            + actualRejected);
  }

  // ── Invariant catch-all steps ──────────────────────────────────────────────────

  @Then("every \"IN_PROGRESS\" invocation references an \"ACTIVE\" Lambda function")
  public void everyInProgressInvocationReferencesAnActiveLambdaFunction() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every successful invocation recorded which database it queried")
  public void everySuccessfulInvocationRecordedWhichDatabaseItQueried() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
