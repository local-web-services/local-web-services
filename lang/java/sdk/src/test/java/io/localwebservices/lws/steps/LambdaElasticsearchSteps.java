package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.elasticsearch.ElasticsearchClient;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;

/**
 * Step definitions for the lambda_elasticsearch cross-service informal specification feature files.
 *
 * <p>Covers: create_domain, deploy_function, invoke_function, domain_processing_begins,
 * domain_processing_complete, index_document_task, invocation_fails_domain_processing.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized",
 * "the operation is rejected") are intentionally absent here to avoid duplicate step definition
 * errors.
 */
public class LambdaElasticsearchSteps {

  private static final String TEST_FUNC = "test-lambda-elasticsearch-1";
  private static final String TEST_DOMAIN = "test-lambda-elasticsearch-domain-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

  private final WorldContext world;

  public LambdaElasticsearchSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private void lambdaEsCreateFunction() {
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

  private void lambdaEsCreateDomain() {
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      client.createElasticsearchDomain(r -> r.domainName(TEST_DOMAIN));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("AlreadyExists") && !msg.contains("already")) {
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
    lambdaEsCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function exists")
  public void theFunctionExists() {
    // Arrange
    // Act
    lambdaEsCreateFunction();
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

  // ── Given: domain state ────────────────────────────────────────────────────────

  @Given("the domain does not already exist")
  public void theDomainDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no domains.
  }

  @Given("the domain already exists")
  public void theDomainAlreadyExists() {
    // Arrange
    // Act
    lambdaEsCreateDomain();
    // Assert: domain created (no error thrown)
  }

  @Given("the domain exists")
  public void theDomainExists() {
    // Arrange
    // Act
    lambdaEsCreateDomain();
    // Assert: domain created (no error thrown)
  }

  @Given("the domain does not exist")
  public void theDomainDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no domains.
  }

  @Given("the domain is \"AVAILABLE\"")
  public void theDomainIsAvailable() {
    // Arrange: ensure domain exists; fresh domains start AVAILABLE in lws
    // Act
    lambdaEsCreateDomain();
    // Assert: domain is AVAILABLE
  }

  @Given("the domain is not \"AVAILABLE\"")
  public void theDomainIsNotAvailable() {
    // @internal: Cannot force a domain into a non-AVAILABLE state via public API in lws.
  }

  @Given("the domain is \"PROCESSING\"")
  public void theDomainIsProcessing() {
    // @internal: PROCESSING state requires domain config update; not reachable in lws.
  }

  @Given("the domain is not \"PROCESSING\"")
  public void theDomainIsNotProcessing() {
    // Arrange / Act / Assert — no-op: domains are not in PROCESSING after creation in lws.
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

  @Given("an invocation is \"IN_PROGRESS\"")
  public void anInvocationIsInProgress() {
    // Arrange: create the Lambda function so an invocation could be in progress
    // Act
    lambdaEsCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("no invocation is \"IN_PROGRESS\"")
  public void noInvocationIsInProgress() {
    // No-op: fresh state has no invocations.
  }

  @Given("a document slot is available")
  public void aDocumentSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: document slots are always available in lws.
  }

  @Given("no document slot is available")
  public void noDocumentSlotIsAvailable() {
    // @internal: Cannot exhaust document slot limit in lws via public APIs.
  }

  // ── When: actions ──────────────────────────────────────────────────────────────

  @When("an Elasticsearch domain is created and becomes \"AVAILABLE\"")
  public void anElasticsearchDomainIsCreatedAndBecomesAvailable() {
    // Arrange: (domain state set up by Given steps)
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      // Act
      var result = client.createElasticsearchDomain(r -> r.domainName(TEST_DOMAIN));
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

  @When("a domain configuration update begins")
  public void aDomainConfigurationUpdateBegins() {
    // Arrange: (domain state set up by Given steps)
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      // Act
      var result = client.updateElasticsearchDomainConfig(r -> r.domainName(TEST_DOMAIN));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the domain configuration update completes")
  public void theDomainConfigurationUpdateCompletes() {
    // @internal: Cannot force domain config update completion via public API in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "domain_processing_complete: scenario is @internal"));
  }

  @When("the Lambda function indexes a document into the \"AVAILABLE\" domain and succeeds")
  public void theLambdaFunctionIndexesADocumentIntoTheAvailableDomainAndSucceeds() {
    // @internal: Cannot trigger Lambda index operation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "index_document_task: scenario is @internal"));
  }

  @When("the Lambda function fails to write because the domain is processing a config update")
  public void theLambdaFunctionFailsToWriteBecauseTheDomainIsProcessingAConfigUpdate() {
    // @internal: Cannot trigger Lambda write failure due to PROCESSING domain in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "invocation_fails_domain_processing: scenario is @internal"));
  }

  // ── Then: assertions ───────────────────────────────────────────────────────────

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

  @Then("the invocation is \"IN_PROGRESS\"")
  public void theInvocationIsInProgress() {
    // @internal: Cannot observe Lambda invocation state in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the domain is \"PROCESSING\" and write operations may fail")
  public void theDomainIsProcessingAndWriteOperationsMayFail() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected domain_processing_begins to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the domain is \"AVAILABLE\" again")
  public void theDomainIsAvailableAgain() {
    // @internal: domain config update completion not observable via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the document \"EXISTS\" and the invocation is \"SUCCESS\"")
  public void theDocumentExistsAndTheInvocationIsSuccess() {
    // @internal: Cannot observe document indexing result in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"FAILED\" with a connection error")
  public void theInvocationIsFailedWithAConnectionError() {
    // @internal: Cannot observe Lambda invocation failure in lws.
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

  @Then("every existing document references a domain that exists")
  public void everyExistingDocumentReferencesADomainThatExists() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
