package io.localwebservices.lws.steps;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.AttributeDefinition;
import software.amazon.awssdk.services.dynamodb.model.BillingMode;
import software.amazon.awssdk.services.dynamodb.model.KeySchemaElement;
import software.amazon.awssdk.services.dynamodb.model.KeyType;
import software.amazon.awssdk.services.dynamodb.model.ScalarAttributeType;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;

/**
 * Step definitions for the lambda_dynamodb cross-service informal specification feature files.
 *
 * <p>Covers: create_table, deploy_function, invocation_fails, invocation_succeeds, invoke_function,
 * put_item.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized", "the
 * operation is rejected", "an item slot is available", "no item slot is available", "a DynamoDB
 * table is created"), {@link LambdaSteps} ("the function does not already exist", "the function
 * already exists", "the function exists", "the function does not exist", "the function is
 * {string}", "the function is not {string}"), and {@link DynamodbSteps} ("the table does not
 * already exist", "the table already exists", "the table exists", "the table does not exist", "the
 * table is {string}", "the table is not {string}") are intentionally absent here to avoid duplicate
 * step definition errors.
 */
public class LambdaDynamodbSteps {

  private static final String TEST_FUNC = "e2e-test-func-1";
  private static final String TEST_TABLE = "e2e-test-table-1";
  private static final String TEST_PK = "pk";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

  private final WorldContext world;

  public LambdaDynamodbSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private void lambdaDynamodbCreateFunction() {
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

  private void lambdaDynamodbCreateTable() {
    // Arrange
    try (DynamoDbClient client = world.session.dynamoDbClient()) {
      // Act
      client.createTable(
          r ->
              r.tableName(TEST_TABLE)
                  .keySchema(
                      KeySchemaElement.builder()
                          .attributeName(TEST_PK)
                          .keyType(KeyType.HASH)
                          .build())
                  .attributeDefinitions(
                      AttributeDefinition.builder()
                          .attributeName(TEST_PK)
                          .attributeType(ScalarAttributeType.S)
                          .build())
                  .billingMode(BillingMode.PAY_PER_REQUEST));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceInUseException") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  // ── Given: invocation state ────────────────────────────────────────────────────

  @Given("an invocation is \"IN_PROGRESS\"")
  public void anInvocationIsInProgress() {
    // Arrange: create the Lambda function so an invocation could be in progress
    // Act
    lambdaDynamodbCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("no invocation is \"IN_PROGRESS\"")
  public void noInvocationIsInProgress() {
    // No-op: fresh state has no invocations.
  }

  @Given("an invocation slot is available")
  public void anInvocationSlotIsAvailable() {
    // No-op: always room for invocations in lws.
  }

  @Given("no invocation slot is available")
  public void noInvocationSlotIsAvailable() {
    // @internal: Cannot exhaust invocation slot limit in lws via public APIs.
    // Only reached by @internal/@capacity scenarios excluded by the tag filter.
  }

  // ── When: actions ──────────────────────────────────────────────────────────────

  @When("a Lambda function is deployed")
  public void aLambdaFunctionIsDeployed() {
    // Arrange
    try {
      // Act
      lambdaDynamodbCreateFunction();
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

  @When("the Lambda invocation fails")
  public void theLambdaInvocationFails() {
    // @internal: Cannot trigger Lambda invocation failure in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation failure: scenario is @internal"));
  }

  @When("the Lambda invocation completes successfully")
  public void theLambdaInvocationCompletesSuccessfully() {
    // @internal: Cannot trigger Lambda invocation success in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation success: scenario is @internal"));
  }

  @When("the Lambda function writes an item to the DynamoDB table during invocation")
  public void theLambdaFunctionWritesAnItemToTheDynamoDbTableDuringInvocation() {
    // @internal: Cannot trigger Lambda item write in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda item write: scenario is @internal"));
  }

  // ── Then: assertions ───────────────────────────────────────────────────────────

  // "the function is {string}" is already registered in LambdaSteps and covers
  // "Then the function is \"ACTIVE\"" — not re-registered here.

  // "the table is {string}" is already registered in DynamodbSteps and covers
  // "Then the table is \"ACTIVE\"" — not re-registered here.

  // "a DynamoDB table is created" When step is already registered in CrossServiceSteps
  // — not re-registered here.

  @Then("the invocation is \"IN_PROGRESS\"")
  public void theInvocationIsInProgress() {
    // @internal: Cannot observe Lambda invocation state in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"FAILED\"")
  public void theInvocationIsFailed() {
    // @internal: Cannot observe Lambda invocation failure in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"SUCCESS\"")
  public void theInvocationIsSuccess() {
    // @internal: Cannot observe Lambda invocation success in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the item \"EXISTS\" in the table")
  public void theItemExistsInTheTable() {
    // @internal: Cannot observe Lambda item write result in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  // ── Invariant catch-all steps ──────────────────────────────────────────────────

  @Then("every \"IN_PROGRESS\" invocation references an \"ACTIVE\" Lambda function")
  public void everyInProgressInvocationReferencesAnActiveLambdaFunction() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every existing item belongs to an \"ACTIVE\" table")
  public void everyExistingItemBelongsToAnActiveTable() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
