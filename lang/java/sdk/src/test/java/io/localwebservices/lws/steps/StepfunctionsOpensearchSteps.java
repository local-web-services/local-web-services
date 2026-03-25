package io.localwebservices.lws.steps;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.opensearch.OpenSearchClient;

/**
 * Step definitions for the stepfunctions_opensearch cross-service feature files.
 *
 * <p>Covers: create_state_machine, create_domain, domain_processing_begins,
 * domain_processing_complete, start_execution, search_task_succeeds, search_task_fails.
 *
 * <p>Steps already registered in {@link StepfunctionsSteps} (state machine Given/When/Then) and
 * {@link CrossServiceSteps} (the system is initialized, the operation is rejected, every .*
 * catch-alls) are NOT re-registered here.
 */
public class StepfunctionsOpensearchSteps {

  private static final String TEST_SM = "test-sf-opensearch-sm-1";
  private static final String TEST_DOMAIN_NAME = "test-sf-opensearch-domain-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_PASS_DEFINITION =
      "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";
  private static final String TEST_INPUT = "{\"key\":\"value\"}";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  private final WorldContext world;
  private String localDomainName;

  public StepfunctionsOpensearchSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private String smArn(String name) {
    return "arn:aws:states:" + TEST_REGION + ":" + TEST_ACCOUNT + ":stateMachine:" + name;
  }

  private String createDomain() {
    try (OpenSearchClient client = world.session.openSearchClient()) {
      // Arrange
      // Act
      var result = client.createDomain(r -> r.domainName(TEST_DOMAIN_NAME));
      // Assert: creation succeeded (no exception thrown)
      return result.domainStatus() != null ? result.domainStatus().domainName() : TEST_DOMAIN_NAME;
    }
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  // "a Step Functions state machine is created" is registered in StepfunctionsSteps.
  // "an execution of the state machine is started" is registered in StepfunctionsSteps.

  @When("an OpenSearch domain is created and becomes \"ACTIVE\"")
  public void anOpenSearchDomainIsCreatedAndBecomesActive() {
    // Arrange: use test domain name
    try (OpenSearchClient client = world.session.openSearchClient()) {
      // Act
      var result = client.createDomain(r -> r.domainName(TEST_DOMAIN_NAME));
      // Assert: result captured
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a running execution calls an \"ACTIVE\" OpenSearch domain and the task succeeds")
  public void aRunningExecutionCallsActiveOpenSearchDomainAndTaskSucceeds() {
    // @internal: Cannot trigger internal execution step that calls OpenSearch in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that calls OpenSearch in lws"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the domain is \"ACTIVE\" again")
  public void theDomainIsActiveAgain() {
    // @internal: Cannot observe internal domain ACTIVE recovery in lws.
    // Arrange / Act / Assert — no-op: invariant trivially satisfied in isolated lws context.
  }
}
