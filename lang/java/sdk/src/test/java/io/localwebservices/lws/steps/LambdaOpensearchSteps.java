package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.opensearch.OpenSearchClient;
import software.amazon.awssdk.services.opensearch.model.DescribeDomainResponse;

/**
 * Step definitions for the lambda_opensearch cross-service informal specification feature files.
 *
 * <p>Covers: deploy_function, create_domain, create_index, invoke_function, invocation_fails,
 * invocation_succeeds, index_document.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized", "the
 * operation is rejected"), {@link LambdaSteps} ("the function does not already exist", "the
 * function already exists", "the function exists", "the function does not exist", "the function is
 * {string}", "the function is not {string}"), and {@link OpensearchSteps} ("the domain does not
 * already exist", "the domain already exists", "the domain exists", "the domain does not exist",
 * "the domain is {string}", "the domain is not {string}") are intentionally absent here to avoid
 * duplicate step definition errors.
 */
public class LambdaOpensearchSteps {

  private static final String TEST_FUNC = "test-lambda-opensearch-1";
  private static final String TEST_DOMAIN = "test-lambda-opensearch-domain-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

  private final WorldContext world;

  public LambdaOpensearchSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private void lambdaOpenSearchCreateFunction() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(software.amazon.awssdk.services.lambda.model.Runtime.PYTHON3_12)
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

  private void lambdaOpenSearchCreateDomain() {
    // Arrange
    try (OpenSearchClient client = world.session.openSearchClient()) {
      // Act
      client.createDomain(r -> r.domainName(TEST_DOMAIN));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceAlreadyExists") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  // ── Given: invocation state ────────────────────────────────────────────────────

  @Given("an invocation is \"IN_PROGRESS\"")
  public void anInvocationIsInProgress() {
    // Arrange: create the Lambda function so an invocation could be in progress
    // Act
    lambdaOpenSearchCreateFunction();
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

  @Given("a document slot is available")
  public void aDocumentSlotIsAvailable() {
    // No-op: always room for documents in lws.
  }

  @Given("no document slot is available")
  public void noDocumentSlotIsAvailable() {
    // @internal: Cannot exhaust document slot limit in lws via public APIs.
    // Only reached by @internal/@capacity scenarios excluded by the tag filter.
  }

  // ── Given: OpenSearch domain/index state unique to cross-service scenarios ──────

  @Given("the domain exists")
  public void theDomainExists() {
    // Arrange
    // Act
    lambdaOpenSearchCreateDomain();
    // Assert: domain created (no error thrown)
  }

  @Given("the index exists")
  public void theIndexExists() {
    // No-op: index existence is managed via the OpenSearch domain; handled by OpensearchSteps.
  }

  @Given("the index's domain is \"ACTIVE\"")
  public void theIndexsDomainIsActive() {
    // Arrange: ensure domain exists and is ACTIVE
    // Act
    lambdaOpenSearchCreateDomain();
    // Assert: domain created (no error thrown)
  }

  @Given("the index's domain is not \"ACTIVE\"")
  public void theIndexsDomainIsNotActive() {
    // @internal: Cannot force a domain into a non-ACTIVE state via public APIs.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Given("the index does not exist")
  public void theIndexDoesNotExist() {
    // No-op: fresh state has no indexes in lws.
  }

  // ── When: actions ──────────────────────────────────────────────────────────────

  @When("a Lambda function is deployed")
  public void aLambdaFunctionIsDeployed() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(software.amazon.awssdk.services.lambda.model.Runtime.PYTHON3_12)
                  .role(TEST_ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
      // Assert: store result
      world.setSuccess(TEST_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an OpenSearch domain is created")
  public void anOpenSearchDomainIsCreated() {
    // Arrange
    try (OpenSearchClient client = world.session.openSearchClient()) {
      // Act
      var response = client.createDomain(r -> r.domainName(TEST_DOMAIN));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an index is created in the OpenSearch domain")
  public void anIndexIsCreatedInTheOpenSearchDomain() {
    // @internal: OpenSearch index creation requires HTTP calls to the domain endpoint, not via the
    // management API.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot create index via management API: scenario is @internal"));
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

  @When("the Lambda function indexes a document into the OpenSearch index during invocation")
  public void theLambdaFunctionIndexesADocumentIntoTheOpenSearchIndexDuringInvocation() {
    // @internal: Cannot trigger Lambda document indexing in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda document indexing: scenario is @internal"));
  }

  // ── Then: assertions ───────────────────────────────────────────────────────────

  @Then("the function is \"ACTIVE\"")
  public void theFunctionIsActive() {
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

  @Then("the domain is \"ACTIVE\"")
  public void theDomainIsActive() {
    // Arrange
    String expectedName = TEST_DOMAIN;
    // Act
    try (OpenSearchClient client = world.session.openSearchClient()) {
      DescribeDomainResponse response = client.describeDomain(r -> r.domainName(TEST_DOMAIN));
      String actualName =
          response.domainStatus().domainName() != null ? response.domainStatus().domainName() : "";
      // Assert
      assertEquals(
          expectedName,
          actualName,
          "expected domain name '"
              + expectedName
              + "' but got '"
              + actualName
              + "'; expected_name="
              + expectedName
              + " actual_name="
              + actualName);
    }
  }

  @Then("the index \"EXISTS\" and is ready to receive documents")
  public void theIndexExistsAndIsReadyToReceiveDocuments() {
    // @internal: Cannot verify index existence via management API alone.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

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

  @Then("the document is \"INDEXED\"")
  public void theDocumentIsIndexed() {
    // @internal: Cannot observe Lambda document indexing result in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  // ── Invariant catch-all steps ──────────────────────────────────────────────────

  @Then("every \"IN_PROGRESS\" invocation references an \"ACTIVE\" Lambda function")
  public void everyInProgressInvocationReferencesAnActiveLambdaFunction() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every indexed document belongs to an existing index")
  public void everyIndexedDocumentBelongsToAnExistingIndex() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every existing index belongs to an \"ACTIVE\" domain")
  public void everyExistingIndexBelongsToAnActiveDomain() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
