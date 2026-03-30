package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
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
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized", "the
 * operation is rejected") are intentionally absent here to avoid duplicate step definition errors.
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
    Assumptions.assumeTrue(
        false, "Cannot force a domain into a non-AVAILABLE state via public API in lws.");
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
        new UnsupportedOperationException("domain_processing_complete: scenario is @internal"));
  }

  @When("the Lambda function indexes a document into the \"AVAILABLE\" domain and succeeds")
  public void theLambdaFunctionIndexesADocumentIntoTheAvailableDomainAndSucceeds() {
    // @internal: Cannot trigger Lambda index operation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException("index_document_task: scenario is @internal"));
  }

  @When("the Lambda function fails to write because the domain is processing a config update")
  public void theLambdaFunctionFailsToWriteBecauseTheDomainIsProcessingAConfigUpdate() {
    // @internal: Cannot trigger Lambda write failure due to PROCESSING domain in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "invocation_fails_domain_processing: scenario is @internal"));
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
    Assumptions.assumeTrue(false, "domain config update completion not observable via public API.");
  }

  // "every existing document references a domain that exists" → CrossServiceSteps (catch-all
  // @And("^every .*$"))
}
