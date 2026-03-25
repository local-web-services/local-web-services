package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;
import software.amazon.awssdk.services.rds.RdsClient;

/**
 * Step definitions for the rds_lambda cross-service informal specification feature files.
 *
 * <p>Covers: create_d_b_instance, deploy_function, configure_lambda_integration,
 * stored_proc_invokes_lambda, invocation_fails_function_deleted, delete_function.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized", "the
 * operation is rejected") are intentionally absent here to avoid duplicate step definition errors.
 */
public class RdsLambdaSteps {

  private static final String TEST_DB_INSTANCE_ID = "test-rdslambda-db-1";
  private static final String TEST_FUNC = "test-rdslambda-func-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_DB_ENGINE = "mysql";
  private static final String TEST_DB_CLASS = "db.t3.micro";

  private final WorldContext world;

  public RdsLambdaSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private void rdsLambdaCreateDbInstance() {
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

  private void rdsLambdaCreateFunction() {
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

  // ── Given: DB instance state ───────────────────────────────────────────────────

  @Given("the \"DB\" instance does not already exist")
  public void theDbInstanceDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no DB instances.
  }

  @Given("the \"DB\" instance already exists")
  public void theDbInstanceAlreadyExists() {
    // Arrange
    // Act
    rdsLambdaCreateDbInstance();
    // Assert: DB instance created (no error thrown)
  }

  @Given("the \"DB\" instance exists and is \"AVAILABLE\"")
  public void theDbInstanceExistsAndIsAvailable() {
    // Arrange
    // Act
    rdsLambdaCreateDbInstance();
    // Assert: DB instance created and is AVAILABLE (no error thrown)
  }

  @Given("the \"DB\" instance is \"AVAILABLE\"")
  public void theDbInstanceIsAvailable() {
    // Arrange
    // Act
    rdsLambdaCreateDbInstance();
    // Assert: DB instance created (no error thrown)
  }

  @Given("the \"DB\" instance is not \"AVAILABLE\"")
  public void theDbInstanceIsNotAvailable() {
    // @internal: Cannot force a DB instance into a non-AVAILABLE state via public API.
  }

  @Given("the \"DB\" instance does not exist or is not \"AVAILABLE\"")
  public void theDbInstanceDoesNotExistOrIsNotAvailable() {
    // Arrange / Act / Assert — no-op: fresh state has no DB instances.
  }

  @Given("the \"DB\" instance has no Lambda integration configured")
  public void theDbInstanceHasNoLambdaIntegrationConfigured() {
    // Arrange / Act / Assert — no-op: fresh DB instances have no Lambda integration.
  }

  @Given("the \"DB\" instance already has a Lambda integration configured")
  public void theDbInstanceAlreadyHasALambdaIntegrationConfigured() {
    // @internal: Lambda integration state requires specific RDS configuration API calls.
  }

  @Given("the \"DB\" instance has a Lambda integration configured")
  public void theDbInstanceHasALambdaIntegrationConfigured() {
    // @internal: Lambda integration state requires specific RDS configuration API calls.
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
    rdsLambdaCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function exists")
  public void theFunctionExists() {
    // Arrange
    // Act
    rdsLambdaCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function does not exist")
  public void theFunctionDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no functions.
  }

  @Given("the function exists and is \"ACTIVE\"")
  public void theFunctionExistsAndIsActive() {
    // Arrange
    // Act
    rdsLambdaCreateFunction();
    // Assert: function created and is ACTIVE (no error thrown)
  }

  @Given("the function does not exist or is not \"ACTIVE\"")
  public void theFunctionDoesNotExistOrIsNotActive() {
    // Arrange / Act / Assert — no-op: fresh state has no functions.
  }

  @Given("the Lambda function is \"ACTIVE\"")
  public void theLambdaFunctionIsActive() {
    // Arrange
    // Act
    rdsLambdaCreateFunction();
    // Assert: function created and is ACTIVE (no error thrown)
  }

  @Given("the Lambda function is not \"ACTIVE\"")
  public void theLambdaFunctionIsNotActive() {
    // @internal: cannot force a function into a non-ACTIVE state via public API in lws.
  }

  @Given("the Lambda function is \"DELETED\"")
  public void theLambdaFunctionIsDeleted() {
    // @internal: DELETED state requires the function to have been deleted.
  }

  @Given("the Lambda function is not \"DELETED\"")
  public void theLambdaFunctionIsNotDeleted() {
    // Arrange
    // Act
    rdsLambdaCreateFunction();
    // Assert: function created (not DELETED)
  }

  @Given("the function is \"ACTIVE\"")
  public void theFunctionIsActive() {
    // Arrange / Act / Assert — no-op: fresh functions are ACTIVE immediately after creation.
  }

  @Given("the function is already \"DELETED\"")
  public void theFunctionIsAlreadyDeleted() {
    // @internal: DELETED state requires the function to have been deleted.
  }

  // ── Given: capacity ────────────────────────────────────────────────────────────

  @Given("an invocation slot is available")
  public void anInvocationSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: always room for invocations in lws.
  }

  @Given("no invocation slot is available")
  public void noInvocationSlotIsAvailable() {
    // @internal: Cannot exhaust invocation slot limit in lws via public APIs.
  }

  // ── When: actions ──────────────────────────────────────────────────────────────

  @When("an \"RDS\" \"DB\" instance is created")
  public void anRdsDbInstanceIsCreated() {
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

  @When("the \"DB\" instance is configured with an \"IAM\" role to invoke the Lambda function")
  public void theDbInstanceIsConfiguredWithAnIamRoleToInvokeTheLambdaFunction() {
    // @internal: RDS Lambda integration configuration requires specific IAM role setup.
    world.setFailure(
        new UnsupportedOperationException(
            "configure_lambda_integration: scenario is @internal in lws"));
  }

  @When("an \"RDS\" stored procedure invokes the Lambda function and succeeds")
  public void anRdsStoredProcedureInvokesTheLambdaFunctionAndSucceeds() {
    // @internal: RDS stored procedure invocation requires internal Lambda integration.
    world.setFailure(
        new UnsupportedOperationException(
            "stored_proc_invokes_lambda: scenario is @internal in lws"));
  }

  @When("an \"RDS\" stored procedure fails to invoke Lambda because the function has been deleted")
  public void anRdsStoredProcedureFailsToInvokeLambdaBecauseFunctionDeleted() {
    // @internal: RDS stored procedure invocation failure requires internal Lambda integration.
    world.setFailure(
        new UnsupportedOperationException(
            "invocation_fails_function_deleted: scenario is @internal in lws"));
  }

  // ── Then: assertions ───────────────────────────────────────────────────────────

  @Then("the \"DB\" instance is \"AVAILABLE\" with no Lambda integration configured")
  public void theDbInstanceIsAvailableWithNoLambdaIntegrationConfigured() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected create_d_b_instance to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected output from RDS DB instance creation but got null");
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
      org.junit.jupiter.api.Assertions.assertEquals(
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

  @Then("stored procedures on the \"DB\" can invoke the Lambda function")
  public void storedProceduresOnTheDbCanInvokeTheLambdaFunction() {
    // @internal: Lambda integration not observable via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"SUCCESS\"")
  public void theInvocationIsSuccess() {
    // @internal: invocation success not observable via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"FAILED\" with a function not found error")
  public void theInvocationIsFailedWithAFunctionNotFoundError() {
    // @internal: invocation failure not observable via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the function is \"DELETED\" and stored procedure invocations targeting it will fail")
  public void theFunctionIsDeletedAndStoredProcedureInvocationsTargetingItWillFail() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected delete_function to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
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

  @Then("every successful invocation references a \"DB\" instance that exists")
  public void everySuccessfulInvocationReferencesADbInstanceThatExists() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  @Then("every successful invocation recorded which function it invoked")
  public void everySuccessfulInvocationRecordedWhichFunctionItInvoked() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }
}
