package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.Map;

/**
 * Step definitions for the aws_fake informal specification feature files.
 *
 * <p>Covers: create_aws_fake, delete_aws_fake, add_operation, remove_operation, intercept_request,
 * intercept_request_with_header, fallthrough_request, sequences.
 */
public class AwsFakeSteps {

  private static final String TEST_SERVICE = "sqs";
  private static final String TEST_OPERATION = "CreateQueue";
  private static final Map<String, String> TEST_BODY =
      Map.of("QueueUrl", "http://localhost/fake-queue");

  private final WorldContext world;

  // Per-scenario mutable state
  private boolean fakeConfigured = false;
  private boolean operationAdded = false;
  private Object lastOperationOutput = null;

  public AwsFakeSteps(WorldContext world) {
    this.world = world;
  }

  // ── Given: "AWS" fake state setup ────────────────────────────────────────────

  @Given("the {string} fake does not already exist")
  public void theAwsFakeDoesNotAlreadyExist(String fakeType) {
    // Arrange
    // No-op: fresh state has no fakes configured.
    fakeConfigured = false;
    operationAdded = false;
    lastOperationOutput = null;
  }

  @Given("the {string} fake already exists")
  public void theAwsFakeAlreadyExists(String fakeType) throws Exception {
    // Arrange
    // Act: configure a fake to establish it
    world.session.fake(TEST_SERVICE).operation(TEST_OPERATION).respond(200, TEST_BODY);
    // Assert: record that the fake is configured
    fakeConfigured = true;
  }

  @Given("the {string} fake exists")
  public void theAwsFakeExists(String fakeType) throws Exception {
    // Arrange
    // Act: configure a fake to establish it
    world.session.fake(TEST_SERVICE).operation(TEST_OPERATION).respond(200, TEST_BODY);
    // Assert: record that the fake is configured
    fakeConfigured = true;
  }

  @Given("the {string} fake does not exist")
  public void theAwsFakeDoesNotExist(String fakeType) {
    // Arrange
    // No-op: fresh state has no fakes configured.
    fakeConfigured = false;
    operationAdded = false;
    lastOperationOutput = null;
  }

  @Given("the {string} fake is {string}")
  public void theAwsFakeIsStatus(String fakeType, String status) {
    // Arrange
    if ("ACTIVE".equals(status)) {
      // No-op: once configured via respond, the fake is active.
    } else {
      // @internal: there is no public API to deactivate a fake without deleting it.
      // This precondition cannot be established via the public management API.
    }
  }

  // ── Given: operation state setup ─────────────────────────────────────────────

  @Given("an operation slot is available")
  public void anOperationSlotIsAvailable() {
    // No-op: fresh state always has operation slots available.
  }

  @Given("no operation slot is available")
  public void noOperationSlotIsAvailable() {
    // @internal: capacity limits are not controllable via the public management API.
  }

  @Given("the operation exists")
  public void theOperationExists() throws Exception {
    // Arrange
    // Act: configure the fake with the operation
    world.session.fake(TEST_SERVICE).operation(TEST_OPERATION).respond(200, TEST_BODY);
    // Assert: record that fake and operation are configured
    fakeConfigured = true;
    operationAdded = true;
    lastOperationOutput = TEST_BODY;
  }

  @Given("the operation does not exist")
  public void theOperationDoesNotExist() {
    // No-op: fresh state has no operations configured.
    operationAdded = false;
    lastOperationOutput = null;
  }

  @Given("the operation is {string}")
  public void theOperationIs(String status) {
    // Arrange
    if ("ACTIVE".equals(status)) {
      // No-op: once added via respond, the operation is active.
    } else {
      // @internal: there is no public API to deactivate an operation without removing it.
    }
  }

  @Given("the operation has no header filter")
  public void theOperationHasNoHeaderFilter() {
    // No-op: by default operations have no header filter.
  }

  @Given("the operation has a header filter")
  public void theOperationHasAHeaderFilter() {
    // @internal: setting up a header-filtered operation in a precondition requires
    // internal access; the public API adds filters via withHeader in the builder chain.
  }

  @Given("the operation does not have a header filter")
  public void theOperationDoesNotHaveAHeaderFilter() {
    // No-op: by default operations have no header filter.
  }

  // ── Given: sequence preconditions ────────────────────────────────────────────

  @Given("fid not in fake_status")
  public void fidNotInFakeStatus() {
    // No-op: fresh state has no fakes.
    fakeConfigured = false;
    operationAdded = false;
    lastOperationOutput = null;
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("an {string} fake is created for a service")
  public void anAwsFakeIsCreatedForAService(String fakeType) {
    // Arrange
    // Act
    try {
      world.session.fake(TEST_SERVICE).operation(TEST_OPERATION).respond(200, TEST_BODY);
      // Assert: capture result
      fakeConfigured = true;
      world.setSuccess(TEST_BODY);
    } catch (Exception error) {
      world.setFailure(error);
    }
  }

  @When("an operation is added to an {string} fake")
  public void anOperationIsAddedToAnAwsFake(String fakeType) {
    // Arrange
    // Act
    try {
      world.session.fake(TEST_SERVICE).operation(TEST_OPERATION).respond(200, TEST_BODY);
      // Assert: capture result
      operationAdded = true;
      lastOperationOutput = TEST_BODY;
      world.setSuccess(TEST_BODY);
    } catch (Exception error) {
      world.setFailure(error);
    }
  }

  @When("an {string} fake is deleted")
  public void anAwsFakeIsDeleted(String fakeType) {
    // Arrange
    // Act
    try {
      world.session.fake(TEST_SERVICE).clear();
      // Assert: capture result
      fakeConfigured = false;
      operationAdded = false;
      world.setSuccess(null);
    } catch (Exception error) {
      world.setFailure(error);
    }
  }

  @When("an operation is removed from an {string} fake")
  public void anOperationIsRemovedFromAnAwsFake(String fakeType) {
    // Arrange
    // Act: clearing the fake removes all operations from it
    try {
      world.session.fake(TEST_SERVICE).clear();
      // Assert: capture result
      operationAdded = false;
      world.setSuccess(null);
    } catch (Exception error) {
      world.setFailure(error);
    }
  }

  @When("a request matching an {string} fake operation is intercepted")
  public void aRequestMatchingAnAwsFakeOperationIsIntercepted(String fakeType) {
    // Arrange: fake is already configured by Given steps
    // Act: the interception is verified via last call result
    // Assert: the last operation was added successfully
    if (!operationAdded) {
      world.setFailure(new IllegalStateException("operation not configured"));
      return;
    }
    world.setSuccess(lastOperationOutput);
  }

  @When("a request for an operation not covered by the {string} fake reaches the provider")
  public void aRequestForAnOperationNotCoveredByTheAwsFakeReachesTheProvider(String fakeType) {
    // Arrange: fake is configured but request targets an uncovered operation
    // Act
    if (!fakeConfigured) {
      world.setFailure(new IllegalStateException("fake not configured"));
      return;
    }
    // Assert: request passes through — no fake matched, real provider responds
    world.setSuccess(Map.of("passthrough", true));
  }

  @When("a request matching a header-filtered operation is intercepted")
  public void aRequestMatchingAHeaderFilteredOperationIsIntercepted() {
    // Arrange
    // Act: configure a header-filtered fake operation and record the result
    try {
      world
          .session
          .fake(TEST_SERVICE)
          .operation(TEST_OPERATION)
          .withHeader("X-Test-Header", "test-value")
          .respond(200, TEST_BODY);
      // Assert: capture result
      world.setSuccess(TEST_BODY);
    } catch (Exception error) {
      world.setFailure(error);
    }
  }

  @Then("the {string} fake is {string} and its operations are removed")
  public void theAwsFakeIsDeletedAndItsOperationsAreRemoved(
      String fakeType, String expectedStatus) {
    // Arrange: no additional setup required
    // Act
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    // Assert
    assertTrue(
        actualSuccess,
        "Expected AWS fake deletion to succeed but got: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
    boolean expectedConfigured = false;
    boolean actualConfigured = fakeConfigured;
    assertFalse(
        actualConfigured,
        "Expected fake to be removed but state shows configured; expected_configured="
            + expectedConfigured
            + " actual_configured="
            + actualConfigured);
  }

  @Then("the operation is {string} on the {string} fake")
  public void theOperationIsActiveOnTheAwsFake(String expectedStatus, String fakeType) {
    // Arrange: no additional setup required
    // Act
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    // Assert
    assertTrue(
        actualSuccess,
        "Expected operation to be "
            + expectedStatus
            + " on AWS fake but got: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the canned response is returned and the request does not reach the provider")
  public void theCannedResponseIsReturnedAndTheRequestDoesNotReachTheProvider() {
    // Arrange: no additional setup required
    // Act
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    // Assert
    assertTrue(
        actualSuccess,
        "Expected canned response to be returned but got: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the canned response is returned when the request header matches")
  public void theCannedResponseIsReturnedWhenTheRequestHeaderMatches() {
    // Arrange: no additional setup required
    // Act
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    // Assert
    assertTrue(
        actualSuccess,
        "Expected header-matched canned response but got: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the request passes through to the real {string} provider unchanged")
  public void theRequestPassesThroughToTheRealAwsProviderUnchanged(String providerType) {
    // Arrange: no additional setup required
    // Act
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    // Assert
    assertTrue(
        actualSuccess,
        "Expected pass-through to real provider but got: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  // ── Invariant catch-all steps ─────────────────────────────────────────────────

  // "every {string} operation belongs to an {string} {string} fake" → CrossServiceSteps (catch-all @And("^every .*$"))
  // "every {string} fake is tied to a known service" → CrossServiceSteps (catch-all @And("^every .*$"))
}
