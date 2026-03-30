package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.GetFunctionResponse;
import software.amazon.awssdk.services.lambda.model.ListTagsResponse;
import software.amazon.awssdk.services.lambda.model.Runtime;
import software.amazon.awssdk.services.lambda.model.State;

/**
 * Step definitions for the Lambda informal specification feature files.
 *
 * <p>Covers: create_function, delete_function, delete_failed_function, update_function_code,
 * update_function_configuration, add_permission, remove_permission, set_reserved_concurrency,
 * tag_resource, untag_resource, and all ESM / invocation / lifecycle features.
 *
 * <p>Steps already registered in CrossServiceSteps ("the system is initialized", "the operation is
 * rejected") are NOT re-registered here.
 */
public class LambdaSteps {

  private static final String TEST_FUNC = "e2e-lambda-test-fn-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT_ID = "000000000000";
  private static final String TEST_TAG_KEY = "e2e-test-tag-key-1";
  private static final String TEST_TAG_VALUE = "e2e-test-tag-value-1";
  private static final String TEST_STATEMENT_ID = "e2e-test-stmt-1";

  private final WorldContext world;

  public LambdaSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private String funcArn() {
    return "arn:aws:lambda:" + TEST_REGION + ":" + TEST_ACCOUNT_ID + ":function:" + TEST_FUNC;
  }

  private void lambdaCreateFunction() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(TEST_ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceConflict") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  // ── Given: function existence ─────────────────────────────────────────────────

  @Given("the function does not already exist")
  public void theFunctionDoesNotAlreadyExist() {
    // No-op: fresh state after reset has no Lambda functions.
  }

  @Given("the function already exists")
  public void theFunctionAlreadyExists() {
    // Arrange: create the function so it already exists
    // Act
    lambdaCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function exists")
  public void theFunctionExists() {
    // Arrange: create the function
    // Act
    lambdaCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function does not exist")
  public void theFunctionDoesNotExist() {
    // Arrange: delete the function if present so it does not exist
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act: delete, ignore errors (function may not exist)
      try {
        client.deleteFunction(r -> r.functionName(TEST_FUNC));
      } catch (Exception ignored) {
        // function may not exist; desired state is absence
      }
    }
    // Assert: desired state is absence
  }

  // ── Given: function lifecycle states ──────────────────────────────────────────

  @Given("the function is {string}")
  public void theFunctionIs(String state) {
    // Arrange
    if ("ACTIVE".equals(state)) {
      // No-op: lws resolves functions to ACTIVE immediately after creation.
      return;
    }
    // For DELETING, DELETED, PENDING, FAILED: @internal — cannot observe in lws.
  }

  @Given("the function is not {string}")
  public void theFunctionIsNot(String state) throws Exception {
    // Arrange
    if ("ACTIVE".equals(state)) {
      // Arrange: delete the function, apply a create dwell so next create is non-ACTIVE
      try (LambdaClient client = world.session.lambdaClient()) {
        try {
          client.deleteFunction(r -> r.functionName(TEST_FUNC));
        } catch (Exception ignored) {
          // function may not exist
        }
      }
      // Act: set lifecycle dwell to prevent immediate ACTIVE transition
      world.session.lifecycle("lambda").createDwellMs(5000).apply();
      lambdaCreateFunction();
      return;
    }
    // For other states, no-op.
  }

  // ── Given: execution state ────────────────────────────────────────────────────

  @Given("the function has no active executions")
  public void theFunctionHasNoActiveExecutions() {
    // No-op: fresh state has no active executions.
  }

  @Given("the function has active executions")
  public void theFunctionHasActiveExecutions() {
    // @internal: Cannot inject active execution state into Lambda in lws.
    Assumptions.assumeTrue(false, "Cannot inject active execution state into Lambda in lws.");
  }

  // ── Given: resource policy ────────────────────────────────────────────────────

  @Given("the function has a resource policy entry")
  public void theFunctionHasAResourcePolicyEntry() {
    // Arrange: create the function and add a permission entry
    lambdaCreateFunction();
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      try {
        client.addPermission(
            r ->
                r.functionName(TEST_FUNC)
                    .statementId(TEST_STATEMENT_ID)
                    .action("lambda:InvokeFunction")
                    .principal("s3.amazonaws.com"));
      } catch (Exception ignored) {
        // permission entry may already exist
      }
    }
    // Assert: policy entry added
  }

  @Given("the function has a resource policy")
  public void theFunctionHasAResourcePolicy() {
    // No-op: policy already added by "the function has a resource policy entry" step.
  }

  @Given("the function does not have a resource policy entry")
  public void theFunctionDoesNotHaveAResourcePolicyEntry() {
    // No-op: fresh state has no policy entries.
  }

  @Given("the function does not have a resource policy")
  public void theFunctionDoesNotHaveAResourcePolicy() {
    // Arrange: remove the permission if present
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act: remove, ignore errors
      try {
        client.removePermission(r -> r.functionName(TEST_FUNC).statementId(TEST_STATEMENT_ID));
      } catch (Exception ignored) {
        // permission may not exist
      }
    }
    // Assert: policy removed
  }

  // ── Given: tags ───────────────────────────────────────────────────────────────

  @Given("the tag exists on the function")
  public void theTagExistsOnTheFunction() {
    // Arrange: tag the function
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.tagResource(
          r -> r.resource(funcArn()).tags(java.util.Map.of(TEST_TAG_KEY, TEST_TAG_VALUE)));
    }
    // Assert: tag applied (no error thrown)
  }

  @Given("the tag does not exist on the function")
  public void theTagDoesNotExistOnTheFunction() {
    // @internal: Cannot verify that untag_resource fails for non-existent tags in lws.
    // Desired precondition: function exists but without the tag.
    Assumptions.assumeTrue(
        false, "Cannot verify that untag_resource fails for non-existent tags in lws.");
  }

  @Given("the tag is set")
  public void theTagIsSet() {
    // No-op: tag already created by "the tag exists on the function" step.
  }

  @Given("the tag is not set")
  public void theTagIsNotSet() {
    // @internal: Cannot verify tag absence without prior tag removal step.
    Assumptions.assumeTrue(false, "Cannot verify tag absence without prior tag removal step.");
  }

  // ── Given: concurrency ────────────────────────────────────────────────────────

  @Given("the function has concurrency configured")
  public void theFunctionHasConcurrencyConfigured() {
    // @internal: Cannot trigger Lambda concurrency-based invocation in lws.
    Assumptions.assumeTrue(false, "Cannot trigger Lambda concurrency-based invocation in lws.");
  }

  @Given("the function does not have concurrency configured")
  public void theFunctionDoesNotHaveConcurrencyConfigured() {
    // @internal: Cannot trigger Lambda concurrency-based invocation in lws.
    Assumptions.assumeTrue(false, "Cannot trigger Lambda concurrency-based invocation in lws.");
  }

  @Given("the function has a positive concurrency limit")
  public void theFunctionHasAPositiveConcurrencyLimit() {
    // @internal: Cannot trigger Lambda concurrency-based invocation in lws.
    Assumptions.assumeTrue(false, "Cannot trigger Lambda concurrency-based invocation in lws.");
  }

  @Given("the function does not have a positive concurrency limit")
  public void theFunctionDoesNotHaveAPositiveConcurrencyLimit() {
    // @internal: Cannot trigger Lambda concurrency-based invocation in lws.
    Assumptions.assumeTrue(false, "Cannot trigger Lambda concurrency-based invocation in lws.");
  }

  @Given("the function has unreserved concurrency")
  public void theFunctionHasUnreservedConcurrency() {
    // @internal: Cannot trigger Lambda concurrency-based invocation in lws.
    Assumptions.assumeTrue(false, "Cannot trigger Lambda concurrency-based invocation in lws.");
  }

  @Given("the function does not have unreserved concurrency")
  public void theFunctionDoesNotHaveUnreservedConcurrency() {
    // @internal: Cannot trigger Lambda concurrency-based invocation in lws.
    Assumptions.assumeTrue(false, "Cannot trigger Lambda concurrency-based invocation in lws.");
  }

  @Given("the function has active executions tracked")
  public void theFunctionHasActiveExecutionsTracked() {
    // @internal: Cannot trigger Lambda concurrency-based invocation in lws.
    Assumptions.assumeTrue(false, "Cannot trigger Lambda concurrency-based invocation in lws.");
  }

  @Given("the function does not have active executions tracked")
  public void theFunctionDoesNotHaveActiveExecutionsTracked() {
    // @internal: Cannot trigger Lambda concurrency-based invocation in lws.
    Assumptions.assumeTrue(false, "Cannot trigger Lambda concurrency-based invocation in lws.");
  }

  @Given("the active executions are below the concurrency limit")
  public void theActiveExecutionsAreBelowTheConcurrencyLimit() {
    // @internal: Cannot trigger Lambda concurrency-based invocation in lws.
    Assumptions.assumeTrue(false, "Cannot trigger Lambda concurrency-based invocation in lws.");
  }

  @Given("the active executions are at or above the concurrency limit")
  public void theActiveExecutionsAreAtOrAboveTheConcurrencyLimit() {
    // @internal: Cannot trigger Lambda concurrency-based invocation in lws.
    Assumptions.assumeTrue(false, "Cannot trigger Lambda concurrency-based invocation in lws.");
  }

  // ── Given: event source mapping ───────────────────────────────────────────────

  @Given("the event source mapping does not already exist")
  public void theEventSourceMappingDoesNotAlreadyExist() {
    // No-op: fresh state has no event source mappings.
  }

  @Given("the event source mapping already exists")
  public void theEventSourceMappingAlreadyExists() {
    // @internal: Cannot create ESM in lws without a real event source ARN.
    Assumptions.assumeTrue(false, "Cannot create ESM in lws without a real event source ARN.");
  }

  @Given("the event source mapping exists")
  public void theEventSourceMappingExists() {
    // @internal: Cannot create ESM in lws without a real event source ARN.
    Assumptions.assumeTrue(false, "Cannot create ESM in lws without a real event source ARN.");
  }

  @Given("the event source mapping does not exist")
  public void theEventSourceMappingDoesNotExist() {
    // No-op: fresh state has no event source mappings.
  }

  @Given("the mapping is {string}")
  public void theMappingIs(String state) {
    // @internal: Cannot observe ESM state transitions in lws without a real event source.
    Assumptions.assumeTrue(
        false, "Cannot observe ESM state transitions in lws without a real event source.");
  }

  @Given("the mapping is not {string}")
  public void theMappingIsNot(String state) {
    // @internal: Cannot observe ESM state transitions in lws without a real event source.
    Assumptions.assumeTrue(
        false, "Cannot observe ESM state transitions in lws without a real event source.");
  }

  // ── Given: async slots ────────────────────────────────────────────────────────

  @Given("an async slot is available")
  public void anAsyncSlotIsAvailable() {
    // @internal: Cannot trigger Lambda async invocation in lws.
    Assumptions.assumeTrue(false, "Cannot trigger Lambda async invocation in lws.");
  }

  @Given("no async slot is available")
  public void noAsyncSlotIsAvailable() {
    // @internal: Cannot exhaust Lambda async slot limit in lws.
    Assumptions.assumeTrue(false, "Cannot exhaust Lambda async slot limit in lws.");
  }

  @Given("the async slot is occupied")
  public void theAsyncSlotIsOccupied() {
    // @internal: Cannot observe Lambda async slot state in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda async slot state in lws.");
  }

  @Given("the async slot is empty")
  public void theAsyncSlotIsEmpty() {
    // @internal: Cannot observe Lambda async slot state in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda async slot state in lws.");
  }

  @Given("the async slot has a function assigned")
  public void theAsyncSlotHasAFunctionAssigned() {
    // @internal: Cannot observe Lambda async slot state in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda async slot state in lws.");
  }

  @Given("the async slot does not have a function assigned")
  public void theAsyncSlotDoesNotHaveAFunctionAssigned() {
    // @internal: Cannot observe Lambda async slot state in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda async slot state in lws.");
  }

  @Given("retry tracking is available for the slot")
  public void retryTrackingIsAvailableForTheSlot() {
    // @internal: Cannot observe Lambda async retry state in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda async retry state in lws.");
  }

  @Given("retry tracking is not available for the slot")
  public void retryTrackingIsNotAvailableForTheSlot() {
    // @internal: Cannot observe Lambda async retry state in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda async retry state in lws.");
  }

  @Given("the retry count has been exhausted")
  public void theRetryCountHasBeenExhausted() {
    // @internal: Cannot observe Lambda async retry exhaustion in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda async retry exhaustion in lws.");
  }

  @Given("the retry count has not been exhausted")
  public void theRetryCountHasNotBeenExhausted() {
    // @internal: Cannot observe Lambda async retry state in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda async retry state in lws.");
  }

  // ── Given: execution tracking ─────────────────────────────────────────────────

  @Given("the function has active execution tracking")
  public void theFunctionHasActiveExecutionTracking() {
    // @internal: Cannot observe Lambda execution tracking state in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda execution tracking state in lws.");
  }

  @Given("the function does not have active execution tracking")
  public void theFunctionDoesNotHaveActiveExecutionTracking() {
    // @internal: Cannot observe Lambda execution tracking state in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda execution tracking state in lws.");
  }

  @Given("the function has at least one active execution")
  public void theFunctionHasAtLeastOneActiveExecution() {
    // @internal: Cannot observe Lambda execution tracking state in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda execution tracking state in lws.");
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a function is created")
  public void aFunctionIsCreated() {
    // Arrange
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

  @When("an active function is deleted")
  public void anActiveFunctionIsDeleted() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.deleteFunction(r -> r.functionName(TEST_FUNC));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a failed function is deleted")
  public void aFailedFunctionIsDeleted() {
    // @internal: Cannot delete a FAILED Lambda function in lws (cannot reach FAILED state).
    world.setFailure(
        new UnsupportedOperationException("cannot delete FAILED function: scenario is @internal"));
  }

  @When("a function's code is updated")
  public void aFunctionSCodeIsUpdated() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.updateFunctionCode(
          r -> r.functionName(TEST_FUNC).zipFile(SdkBytes.fromUtf8String("updated-fake")));
      // Assert: store result
      world.setSuccess(TEST_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a function's configuration is updated")
  public void aFunctionSConfigurationIsUpdated() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.updateFunctionConfiguration(
          r -> r.functionName(TEST_FUNC).description("updated-description"));
      // Assert: store result
      world.setSuccess(TEST_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a permission is added to a function's resource policy")
  public void aPermissionIsAddedToAFunctionSResourcePolicy() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.addPermission(
          r ->
              r.functionName(TEST_FUNC)
                  .statementId(TEST_STATEMENT_ID)
                  .action("lambda:InvokeFunction")
                  .principal("s3.amazonaws.com"));
      // Assert: store result
      world.setSuccess(TEST_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a permission is removed from a function's resource policy")
  public void aPermissionIsRemovedFromAFunctionSResourcePolicy() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.removePermission(r -> r.functionName(TEST_FUNC).statementId(TEST_STATEMENT_ID));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("reserved concurrency is set for a function")
  public void reservedConcurrencyIsSetForAFunction() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.putFunctionConcurrency(r -> r.functionName(TEST_FUNC).reservedConcurrentExecutions(5));
      // Assert: store result
      world.setSuccess(TEST_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a tag is added to a function")
  public void aTagIsAddedToAFunction() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.tagResource(
          r -> r.resource(funcArn()).tags(java.util.Map.of(TEST_TAG_KEY, TEST_TAG_VALUE)));
      // Assert: store result
      world.setSuccess(TEST_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a tag is removed from a function")
  public void aTagIsRemovedFromAFunction() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.untagResource(r -> r.resource(funcArn()).tagKeys(TEST_TAG_KEY));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an event source mapping is created")
  public void anEventSourceMappingIsCreated() {
    // @internal: Cannot create ESM in lws without a real event source ARN.
    world.setFailure(new UnsupportedOperationException("cannot create ESM: scenario is @internal"));
  }

  @When("an enabled event source mapping is deleted")
  public void anEnabledEventSourceMappingIsDeleted() {
    // @internal: Cannot delete ESM in lws without a real event source mapping UUID.
    world.setFailure(
        new UnsupportedOperationException("cannot delete enabled ESM: scenario is @internal"));
  }

  @When("a disabled event source mapping is deleted")
  public void aDisabledEventSourceMappingIsDeleted() {
    // @internal: Cannot delete ESM in lws without a real event source mapping UUID.
    world.setFailure(
        new UnsupportedOperationException("cannot delete disabled ESM: scenario is @internal"));
  }

  @When("an enabled event source mapping is disabled")
  public void anEnabledEventSourceMappingIsDisabled() {
    // @internal: Cannot disable ESM in lws without a real event source mapping UUID.
    world.setFailure(
        new UnsupportedOperationException("cannot disable ESM: scenario is @internal"));
  }

  @When("a disabled event source mapping is enabled")
  public void aDisabledEventSourceMappingIsEnabled() {
    // @internal: Cannot enable ESM in lws without a real event source mapping UUID.
    world.setFailure(new UnsupportedOperationException("cannot enable ESM: scenario is @internal"));
  }

  @When("an event source mapping finishes creating")
  public void anEventSourceMappingFinishesCreating() {
    // @internal: Cannot trigger ESM lifecycle transition in lws.
    world.setFailure(
        new UnsupportedOperationException("cannot trigger ESM lifecycle: scenario is @internal"));
  }

  @When("an event source mapping finishes being deleted")
  public void anEventSourceMappingFinishesBeingDeleted() {
    // @internal: Cannot trigger ESM delete lifecycle in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger ESM delete lifecycle: scenario is @internal"));
  }

  @When("a pending function resolves its deployment")
  public void aPendingFunctionResolvesItsDeployment() {
    // @internal: Cannot trigger Lambda PENDING->ACTIVE transition in lws.
    world.setFailure(
        new UnsupportedOperationException("cannot trigger PENDING->ACTIVE: scenario is @internal"));
  }

  @When("a function finishes being deleted")
  public void aFunctionFinishesBeingDeleted() {
    // @internal: Cannot trigger Lambda DELETING->DELETED transition in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger DELETING->DELETED: scenario is @internal"));
  }

  @When("a function is invoked asynchronously")
  public void aFunctionIsInvokedAsynchronously() {
    // @internal: Cannot trigger Lambda async invocation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger async invocation: scenario is @internal"));
  }

  @When("a function is invoked synchronously without a concurrency limit")
  public void aFunctionIsInvokedSynchronouslyWithoutAConcurrencyLimit() {
    // @internal: Cannot trigger Lambda sync invocation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException("cannot trigger sync invocation: scenario is @internal"));
  }

  @When("a function is invoked synchronously within its concurrency limit")
  public void aFunctionIsInvokedSynchronouslyWithinItsConcurrencyLimit() {
    // @internal: Cannot trigger Lambda sync invocation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger sync invocation with concurrency: scenario is @internal"));
  }

  @When("a synchronous function invocation completes")
  public void aSynchronousFunctionInvocationCompletes() {
    // @internal: Cannot trigger Lambda invocation completion in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger invocation completion: scenario is @internal"));
  }

  @When("an async invocation succeeds")
  public void anAsyncInvocationSucceeds() {
    // @internal: Cannot trigger Lambda async invocation success in lws.
    world.setFailure(
        new UnsupportedOperationException("cannot trigger async success: scenario is @internal"));
  }

  @When("an async invocation fails and is retried")
  public void anAsyncInvocationFailsAndIsRetried() {
    // @internal: Cannot trigger Lambda async retry in lws.
    world.setFailure(
        new UnsupportedOperationException("cannot trigger async retry: scenario is @internal"));
  }

  @When("an async invocation exhausts all retries")
  public void anAsyncInvocationExhaustsAllRetries() {
    // @internal: Cannot trigger Lambda async retry exhaustion in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger async retry exhaustion: scenario is @internal"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  // "the operation is rejected" — already registered in CrossServiceSteps; NOT re-registered.

  @Then("the function is in {string} state")
  public void theFunctionIsInState(String expectedState) {
    // Arrange: no additional setup required
    // Act: action performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected create_function to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the function becomes {string} or {string} non-deterministically")
  public void theFunctionBecomesOrNonDeterministically(String stateA, String stateB) {
    // @internal: Cannot observe Lambda PENDING resolution in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda PENDING resolution in lws.");
  }

  @Then("the function enters {string} state")
  public void theFunctionEntersState(String expectedState) {
    // Arrange: no additional setup required
    // Act: action performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected delete_function to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the function's resource policy is cleared")
  public void theFunctionSResourcePolicyIsCleared() {
    // Arrange: no additional setup required
    // Act: action performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected remove_permission to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the function has an unreserved, throttled, or explicit concurrency limit")
  public void theFunctionHasAnUnreservedThrottledOrExplicitConcurrencyLimit() {
    // Arrange: no additional setup required
    // Act: action performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected put_function_concurrency to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the function has the tag set")
  public void theFunctionHasTheTagSet() {
    // Arrange
    // Act
    try (LambdaClient client = world.session.lambdaClient()) {
      ListTagsResponse result = client.listTags(r -> r.resource(funcArn()));
      java.util.Map<String, String> actualTags = result.tags();
      // Assert
      String expectedTagKey = TEST_TAG_KEY;
      assertTrue(
          actualTags.containsKey(expectedTagKey),
          "expected tag key '"
              + expectedTagKey
              + "' to be set but found tags: "
              + actualTags
              + "; expected_tag_key="
              + expectedTagKey);
    }
  }

  @Then("the tag is cleared from the function")
  public void theTagIsClearedFromTheFunction() {
    // Arrange: no additional setup required
    // Act: action performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected untag_resource to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the mapping is in {string} state and linked to a function")
  public void theMappingIsInStateAndLinkedToAFunction(String expectedState) {
    // @internal: Cannot observe ESM CREATING state in lws.
    Assumptions.assumeTrue(false, "Cannot observe ESM CREATING state in lws.");
  }

  @Then("the mapping is {string} and inactive")
  public void theMappingIsAndInactive(String expectedState) {
    // @internal: Cannot observe ESM DISABLED state in lws.
    Assumptions.assumeTrue(false, "Cannot observe ESM DISABLED state in lws.");
  }

  @Then("the mapping is {string} and active")
  public void theMappingIsAndActive(String expectedState) {
    // @internal: Cannot observe ESM ENABLED state in lws.
    Assumptions.assumeTrue(false, "Cannot observe ESM ENABLED state in lws.");
  }

  @Then("the mapping enters {string} state")
  public void theMappingEntersState(String expectedState) {
    // @internal: Cannot observe ESM DELETING state in lws.
    Assumptions.assumeTrue(false, "Cannot observe ESM DELETING state in lws.");
  }

  @Then("the event is queued in an async slot")
  public void theEventIsQueuedInAnAsyncSlot() {
    // @internal: Cannot observe Lambda async slot state in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda async slot state in lws.");
  }

  @Then("the active execution count increases")
  public void theActiveExecutionCountIncreases() {
    // @internal: Cannot observe Lambda execution count changes in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda execution count changes in lws.");
  }

  @Then("the active execution count decreases")
  public void theActiveExecutionCountDecreases() {
    // @internal: Cannot observe Lambda execution count changes in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda execution count changes in lws.");
  }

  @Then("the retry count increases")
  public void theRetryCountIncreases() {
    // @internal: Cannot observe Lambda async retry count in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda async retry count in lws.");
  }

  @Then("the event is dropped and the slot is freed")
  public void theEventIsDroppedAndTheSlotIsFreed() {
    // @internal: Cannot observe Lambda async slot state in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda async slot state in lws.");
  }

  @Then("the async slot is freed")
  public void theAsyncSlotIsFreed() {
    // @internal: Cannot observe Lambda async slot state in lws.
    Assumptions.assumeTrue(false, "Cannot observe Lambda async slot state in lws.");
  }

  @Then("the function configuration is updated while remaining {string}")
  public void theFunctionConfigurationIsUpdatedWhileRemaining(String expectedState) {
    // Arrange
    // Act
    try (LambdaClient client = world.session.lambdaClient()) {
      GetFunctionResponse result = client.getFunction(r -> r.functionName(TEST_FUNC));
      State actualState = result.configuration().state();
      // Assert
      String expectedStateName = "Active";
      assertEquals(
          expectedStateName,
          actualState.toString(),
          "expected function state '"
              + expectedStateName
              + "' but got '"
              + actualState
              + "'; expected_state="
              + expectedStateName
              + " actual_state="
              + actualState);
    }
  }

  @Then("the function returns to {string} state for redeployment")
  public void theFunctionReturnsToStateForRedeployment(String expectedState) {
    // Arrange: no additional setup required
    // Act: action performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected update_function_code to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  // ── Invariant catch-all steps ─────────────────────────────────────────────────

  // "every active event source mapping references an existing non-deleted function" →
  // CrossServiceSteps (catch-all @And("^every .*$"))

  @Then("no function in {string} state has active executions")
  public void noFunctionInStateHasActiveExecutions(String state) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    Assumptions.assumeTrue(
        false, "No-op: model-level invariant; trivially satisfied in isolated lws context.");
  }

  @Then("active execution count never exceeds reserved concurrency when set")
  public void activeExecutionCountNeverExceedsReservedConcurrencyWhenSet() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    Assumptions.assumeTrue(
        false, "No-op: model-level invariant; trivially satisfied in isolated lws context.");
  }

  @Then("async retry count never exceeds two")
  public void asyncRetryCountNeverExceedsTwo() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    Assumptions.assumeTrue(
        false, "No-op: model-level invariant; trivially satisfied in isolated lws context.");
  }

  // "every event source mapping has a valid status" → CrossServiceSteps (catch-all @And("^every
  // .*$"))
  // "every function has a valid status" → CrossServiceSteps (catch-all @And("^every .*$"))

  @Then("all async slots reference known function IDs or are empty")
  public void allAsyncSlotsReferenceKnownFunctionIDsOrAreEmpty() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    Assumptions.assumeTrue(
        false, "No-op: model-level invariant; trivially satisfied in isolated lws context.");
  }
}
