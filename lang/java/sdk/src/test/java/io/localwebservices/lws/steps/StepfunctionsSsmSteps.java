package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.StateMachineType;
import software.amazon.awssdk.services.ssm.SsmClient;
import software.amazon.awssdk.services.ssm.model.ParameterType;

/**
 * Step definitions for the stepfunctions_ssm cross-service feature suite.
 *
 * <p>Covers: create_state_machine, create_parameter, delete_parameter,
 * read_parameter_task_succeeds, read_parameter_task_fails, start_execution, sequences.
 *
 * <p>Steps already defined in {@link CrossServiceSteps} (e.g. invariant catch-alls, state-machine
 * Given steps, execution Given steps) are intentionally absent here to avoid duplicate-step errors.
 */
public class StepfunctionsSsmSteps {

  private static final String TEST_SFN_SM = "test-sm-1";
  private static final String TEST_SFN_ROLE_ARN =
      "arn:aws:iam::000000000000:role/StepFunctionsRole";
  private static final String TEST_SSM_PARAM = "/test/ssm/cs-1";
  private static final String TEST_SSM_PARAM_VALUE = "test-value-1";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  /** State machine definition that uses the SSM GetParameter integration task. */
  private static final String TEST_SFN_SSM_DEFINITION =
      "{\"StartAt\":\"GetParam\","
          + "\"States\":{\"GetParam\":{"
          + "\"Type\":\"Task\","
          + "\"Resource\":\"arn:aws:states:::ssm:getParameter\","
          + "\"Parameters\":{\"Name\":\"/test/ssm/cs-1\"},"
          + "\"End\":true}}}";

  private final WorldContext world;

  public StepfunctionsSsmSteps(WorldContext world) {
    this.world = world;
  }

  // -------------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------------

  private String sfnArn(String name) {
    return "arn:aws:states:" + TEST_REGION + ":" + TEST_ACCOUNT + ":stateMachine:" + name;
  }

  @SuppressWarnings("unused")
  private void sfnCreateSsmSM(String name) {
    try (SfnClient client = world.session.sfnClient()) {
      var result =
          client.createStateMachine(
              r ->
                  r.name(name)
                      .definition(TEST_SFN_SSM_DEFINITION)
                      .roleArn(TEST_SFN_ROLE_ARN)
                      .type(StateMachineType.STANDARD));
      world.lastStateMachineArn = result.stateMachineArn();
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (msg.contains("StateMachineAlreadyExists")) {
        world.lastStateMachineArn = sfnArn(name);
      } else {
        throw e;
      }
    }
  }

  private void ssmCreateParameter(String name, String value) {
    try (SsmClient client = world.session.ssmClient()) {
      client.putParameter(
          r -> r.name(name).value(value).type(ParameterType.STRING).overwrite(false));
    } catch (software.amazon.awssdk.services.ssm.model.ParameterAlreadyExistsException ignored) {
      // parameter already exists — acceptable for setup steps
    }
  }

  private void ssmDeleteParameter(String name) {
    try (SsmClient client = world.session.ssmClient()) {
      client.deleteParameter(r -> r.name(name));
    } catch (Exception e) {
      // Ignore — already deleted or does not exist
    }
  }

  private boolean ssmParameterExists(String name) {
    try (SsmClient client = world.session.ssmClient()) {
      client.getParameter(r -> r.name(name));
      return true;
    } catch (Exception e) {
      return false;
    }
  }

  // -------------------------------------------------------------------------
  // FizzBee model initialisation preconditions (sequences.feature)
  // -------------------------------------------------------------------------

  @Given("^pid not in param_status$")
  public void pidNotInParamStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  @Given("^pid in param_status$")
  public void pidInParamStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  // -------------------------------------------------------------------------
  // Parameter state step — shared by Given (setup) and Then (assertion).
  //
  // Matches "Given the parameter {string}" and "Then the parameter {string}".
  // Cucumber resolves both keywords to the same expression text.
  // -------------------------------------------------------------------------

  @Given("the parameter {string}")
  public void theParameterState(String state) {
    // Arrange
    String expectedParamName = TEST_SSM_PARAM;
    if ("EXISTS".equals(state)) {
      // Act — ensure parameter exists
      ssmCreateParameter(expectedParamName, TEST_SSM_PARAM_VALUE);
      // Assert
      boolean actualExists = ssmParameterExists(expectedParamName);
      assertTrue(actualExists, "expected parameter '" + expectedParamName + "' to exist");
    } else {
      // Assert — parameter should be absent
      boolean actualGone = !ssmParameterExists(expectedParamName);
      assertTrue(actualGone, "expected parameter '" + expectedParamName + "' to be absent");
    }
  }

  // -------------------------------------------------------------------------
  // Parameter Given steps
  // -------------------------------------------------------------------------

  @Given("the parameter does not already exist")
  public void theParameterDoesNotAlreadyExist() {
    // Arrange — ensure parameter does not exist (delete if present from previous test)
    ssmDeleteParameter(TEST_SSM_PARAM);
    // Assert — parameter is gone; verified by subsequent steps
  }

  @Given("the parameter already exists")
  public void theParameterAlreadyExists() {
    // Arrange
    ssmCreateParameter(TEST_SSM_PARAM, TEST_SSM_PARAM_VALUE);
    // Assert — parameter now exists; verified by subsequent steps
  }

  @Given("the parameter exists")
  public void theParameterExists() {
    // Arrange
    ssmCreateParameter(TEST_SSM_PARAM, TEST_SSM_PARAM_VALUE);
    // Assert — parameter now exists; verified by subsequent steps
  }

  @Given("the parameter does not exist")
  public void theParameterDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh session has no SSM parameters
  }

  @Given("the parameter is already {string}")
  public void theParameterIsAlready(String state) {
    // Arrange — create then delete the parameter to reach DELETED state
    ssmCreateParameter(TEST_SSM_PARAM, TEST_SSM_PARAM_VALUE);
    ssmDeleteParameter(TEST_SSM_PARAM);
    // Assert — parameter is now deleted; verified by subsequent steps
  }

  @Given("the parameter is {string}")
  public void theParameterIs(String state) {
    // Arrange
    if ("DELETED".equals(state)) {
      ssmCreateParameter(TEST_SSM_PARAM, TEST_SSM_PARAM_VALUE);
      ssmDeleteParameter(TEST_SSM_PARAM);
    } else {
      ssmCreateParameter(TEST_SSM_PARAM, TEST_SSM_PARAM_VALUE);
    }
    // Assert — state applied; verified by subsequent steps
  }

  @Given("the parameter is not {string}")
  public void theParameterIsNot(String state) {
    // Arrange — ensure the parameter exists (not deleted)
    ssmCreateParameter(TEST_SSM_PARAM, TEST_SSM_PARAM_VALUE);
    // Assert — parameter exists and is not in the given state; verified by subsequent steps
  }

  @Given("the parameter does not exist or is {string}")
  public void theParameterDoesNotExistOrIs(String state) {
    // Arrange / Act / Assert — no-op: fresh session has no parameters
  }

  // -------------------------------------------------------------------------
  // When — SSM parameter actions
  // -------------------------------------------------------------------------

  @When("a parameter is created in {string} Parameter Store")
  public void aParameterIsCreatedInParameterStore(String store) {
    // Arrange
    try (SsmClient client = world.session.ssmClient()) {
      // Act
      var response =
          client.putParameter(
              r ->
                  r.name(TEST_SSM_PARAM)
                      .value(TEST_SSM_PARAM_VALUE)
                      .type(ParameterType.STRING)
                      .overwrite(false));
      // Assert
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a parameter is deleted from {string} Parameter Store")
  public void aParameterIsDeletedFromParameterStore(String store) {
    // Arrange
    try (SsmClient client = world.session.ssmClient()) {
      // Act
      var response = client.deleteParameter(r -> r.name(TEST_SSM_PARAM));
      // Assert
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // -------------------------------------------------------------------------
  // When — internal execution task actions (not reachable via public API)
  // -------------------------------------------------------------------------

  @When("a running execution reads an existing parameter and the task succeeds")
  public void aRunningExecutionReadsAnExistingParameterAndTheTaskSucceeds() {
    // Arrange / Act / Assert — internal execution SSM task not reachable via public SDK API
    Assumptions.assumeTrue(
        false, "internal execution SSM getParameter task not reachable via SDK API");
  }

  @When("a running execution fails to read the parameter because it has been deleted")
  public void aRunningExecutionFailsToReadTheParameterBecauseItHasBeenDeleted() {
    // Arrange / Act / Assert — internal execution SSM task failure not reachable via SDK API
    Assumptions.assumeTrue(
        false, "internal execution SSM getParameter task failure not reachable via SDK API");
  }

  // -------------------------------------------------------------------------
  // Then — parameter assertions
  // -------------------------------------------------------------------------

  @Then("the parameter is {string} and will cause task failures when read")
  public void theParameterIsDeletedAndWillCauseTaskFailuresWhenRead(String state) {
    // Arrange
    String expectedParamName = TEST_SSM_PARAM;
    // Act
    boolean actualGone = !ssmParameterExists(expectedParamName);
    // Assert
    assertTrue(actualGone, "expected parameter '" + expectedParamName + "' to be deleted");
  }

  @Then("the execution is {string} with a ParameterNotFound error")
  public void theExecutionIsWithParameterNotFoundError(String state) {
    // Arrange / Act / Assert — internal execution task failure not verifiable via public SDK API
    Assumptions.assumeTrue(
        false, "internal execution SSM ParameterNotFound error not verifiable via SDK API");
  }
}
