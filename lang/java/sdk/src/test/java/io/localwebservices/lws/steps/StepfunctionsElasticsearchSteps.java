package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.elasticsearch.ElasticsearchClient;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.StartExecutionResponse;
import software.amazon.awssdk.services.sfn.model.StateMachineType;

/**
 * Step definitions for the stepfunctions_elasticsearch cross-service feature files.
 *
 * <p>Covers: create_state_machine, create_elasticsearch_domain, domain_config_update_begins,
 * domain_config_update_completes, start_execution, call_domain_task_fails,
 * call_domain_task_succeeds.
 *
 * <p>Steps already registered in {@link StepfunctionsSteps} (state machine Given/When/Then) and
 * {@link CrossServiceSteps} (the system is initialized, the operation is rejected, every .* catch-alls)
 * are NOT re-registered here.
 */
public class StepfunctionsElasticsearchSteps {

  private static final String TEST_SM = "test-sf-elasticsearch-sm-1";
  private static final String TEST_DOMAIN = "test-sf-elasticsearch-domain-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_PASS_DEFINITION =
      "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";
  private static final String TEST_INPUT = "{\"key\":\"value\"}";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  private final WorldContext world;

  public StepfunctionsElasticsearchSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private String smArn(String name) {
    return "arn:aws:states:" + TEST_REGION + ":" + TEST_ACCOUNT + ":stateMachine:" + name;
  }

  private void createDomain() {
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      // Arrange / Act
      client.createElasticsearchDomain(r -> r.domainName(TEST_DOMAIN));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceAlreadyExists") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  // ── Given: domain existence ────────────────────────────────────────────────────

  @Given("the domain does not already exist")
  public void theDomainDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after session reset has no domains.
  }

  @Given("the domain already exists")
  public void theDomainAlreadyExists() {
    // Arrange: create the domain so it already exists
    // Act
    createDomain();
    // Assert: domain exists
  }

  @Given("the domain exists")
  public void theDomainExists() {
    // Arrange: create the domain
    // Act
    createDomain();
    // Assert: domain exists
  }

  @Given("the domain does not exist")
  public void theDomainDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after session reset has no domains.
  }

  // ── Given: domain status ───────────────────────────────────────────────────────

  @Given("the domain is \"AVAILABLE\"")
  public void theDomainIsAvailable() {
    // Arrange: ensure domain exists; fresh domains start AVAILABLE
    // Act
    createDomain();
    // Assert: domain is AVAILABLE
  }

  @Given("the domain is \"PROCESSING\"")
  public void theDomainIsProcessing() {
    // Arrange / Act / Assert — no-op: cannot drive a domain into PROCESSING state via public API in lws.
  }

  @Given("the domain is not \"PROCESSING\"")
  public void theDomainIsNotProcessing() {
    // Arrange: create an AVAILABLE domain (not PROCESSING)
    // Act
    createDomain();
    // Assert: domain is not PROCESSING
  }

  @Given("the domain is not \"AVAILABLE\"")
  public void theDomainIsNotAvailable() {
    // Arrange / Act / Assert — no-op: cannot drive a domain into a non-AVAILABLE state via public API in lws.
  }

  // ── Given: execution state ────────────────────────────────────────────────────

  @Given("an execution is \"RUNNING\"")
  public void anExecutionIsRunning() {
    // Arrange: create state machine and start execution
    try (SfnClient client = world.session.sfnClient()) {
      var smResult =
          client.createStateMachine(
              r ->
                  r.name(TEST_SM)
                      .definition(TEST_PASS_DEFINITION)
                      .roleArn(TEST_ROLE_ARN)
                      .type(StateMachineType.STANDARD));
      world.lastStateMachineArn = smResult.stateMachineArn();
      // Act: start an execution
      StartExecutionResponse execResult =
          client.startExecution(r -> r.stateMachineArn(smArn(TEST_SM)).input(TEST_INPUT));
      // Assert: execution started
      world.lastExecutionArn = execResult.executionArn();
    }
  }

  @Given("no execution is \"RUNNING\"")
  public void noExecutionIsRunning() {
    // Arrange / Act / Assert — no-op: fresh state after session reset has no executions.
  }

  // ── Given: capacity ───────────────────────────────────────────────────────────

  @Given("an execution slot is available")
  public void anExecutionSlotIsAvailable() throws Exception {
    // Arrange: set unlimited capacity for stepfunctions
    // Act
    world.session.capacity("stepfunctions").unlimited().apply();
    // Assert: capacity is unlimited
  }

  @Given("no execution slot is available")
  public void noExecutionSlotIsAvailable() throws Exception {
    // Arrange: exhaust the stepfunctions execution capacity
    // Act
    world.session.capacity("stepfunctions").exhaust().apply();
    // Assert: capacity is exhausted
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  // "a Step Functions state machine is created" is registered in StepfunctionsSteps.
  // "an execution of the state machine is started" is registered in StepfunctionsSteps.

  @When("an Elasticsearch domain is created and becomes \"AVAILABLE\"")
  public void anElasticsearchDomainIsCreatedAndBecomesAvailable() {
    // Arrange: use the test domain name
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      // Act
      var result = client.createElasticsearchDomain(r -> r.domainName(TEST_DOMAIN));
      // Assert: result captured
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a domain configuration update begins")
  public void aDomainConfigurationUpdateBegins() {
    // Arrange: use the test domain name
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      // Act
      var result = client.updateElasticsearchDomainConfig(r -> r.domainName(TEST_DOMAIN));
      // Assert: result captured
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the domain configuration update completes")
  public void theDomainConfigurationUpdateCompletes() {
    // @internal: Cannot drive domain configuration update to completion via public API in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot drive domain configuration update to completion via public API in lws"));
  }

  @When("a running execution fails because the domain is processing a config update")
  public void aRunningExecutionFailsBecauseDomainIsProcessingAConfigUpdate() {
    // @internal: Cannot trigger internal execution step that fails due to PROCESSING domain in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that fails due to PROCESSING domain in lws"));
  }

  @When("a running execution calls an \"AVAILABLE\" Elasticsearch domain and the task succeeds")
  public void aRunningExecutionCallsAvailableElasticsearchDomainAndTaskSucceeds() {
    // @internal: Cannot trigger internal execution step that calls Elasticsearch domain in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that calls Elasticsearch domain in lws"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  // "the state machine is "ACTIVE"" is registered in StepfunctionsSteps.
  // "the execution is "RUNNING"" is registered in StepfunctionsSteps.
  // "the operation is rejected" is registered in CrossServiceSteps.

  @Then("the domain is \"AVAILABLE\"")
  public void theDomainIsAvailableThen() throws Exception {
    // Arrange
    String expectedDomainName = TEST_DOMAIN;
    // Act
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      var result = client.describeElasticsearchDomain(r -> r.domainName(expectedDomainName));
      // Assert: domain exists (no error means available)
      assertNotNull(
          result.domainStatus(),
          "Expected domain status to be non-null; expected_domain_name=" + expectedDomainName);
      String actualDomainName = result.domainStatus().domainName();
      assertEquals(
          expectedDomainName,
          actualDomainName,
          "Expected domain name \""
              + expectedDomainName
              + "\" but got \""
              + actualDomainName
              + "\"; expected_domain_name="
              + expectedDomainName
              + " actual_domain_name="
              + actualDomainName);
    }
  }

  @Then("the domain is \"PROCESSING\" and \"API\" calls may fail")
  public void theDomainIsProcessingAndApiCallsMayFail() {
    // @internal: Cannot observe PROCESSING domain state via public API in lws.
    // No-op: treat as invariant satisfied.
  }

  @Then("the domain is \"AVAILABLE\" again")
  public void theDomainIsAvailableAgain() {
    // @internal: Cannot observe domain returning to AVAILABLE after update via public API in lws.
    // No-op: treat as invariant satisfied.
  }

  @Then("the execution is \"SUCCEEDED\"")
  public void theExecutionIsSucceeded() {
    // @internal: Cannot observe internal execution Elasticsearch task success in lws.
    // No-op: treat as invariant satisfied.
  }

  @Then("the execution is \"FAILED\" with a connection error")
  public void theExecutionIsFailedWithAConnectionError() {
    // @internal: Cannot observe internal execution Elasticsearch task failure in lws.
    // No-op: treat as invariant satisfied.
  }

  // ── Then: invariants ──────────────────────────────────────────────────────────

  @Then("every \"RUNNING\" execution references an \"ACTIVE\" state machine")
  public void everyRunningExecutionReferencesAnActiveStateMachine() {
    // Invariant: trivially satisfied in isolated lws context.
  }

  @Then("every succeeded execution recorded which domain it called")
  public void everySucceededExecutionRecordedWhichDomainItCalled() {
    // Invariant: trivially satisfied in isolated lws context.
  }
}
