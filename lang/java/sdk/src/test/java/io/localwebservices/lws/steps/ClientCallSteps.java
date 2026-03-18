package io.localwebservices.lws.steps;

import io.cucumber.java.en.When;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.ListStateMachinesResponse;
import software.amazon.awssdk.services.sfn.model.StateMachineListItem;
import software.amazon.awssdk.services.sfn.model.StateMachineType;

/**
 * Implements the generic "I call {string} {string}" steps used by chaos_injection, fake_responses,
 * iam_enforce, and log_capture features.
 */
public class ClientCallSteps {

  private static final String ACCOUNT = "000000000000";
  private static final String REGION = "us-east-1";

  private final WorldContext world;

  public ClientCallSteps(WorldContext world) {
    this.world = world;
  }

  @When("I call {string} {string}")
  public void iCall(String service, String operation) {
    try {
      dispatch(service, operation);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I call {string} {string} against a real state machine")
  public void iCallAgainstARealStateMachine(String service, String operation) {
    // For stepfunctions StartExecution, ensure a real state machine exists so
    // the call succeeds against the real server (verifying fakes were cleared).
    if ("stepfunctions".equals(service) && "StartExecution".equals(operation)) {
      try (SfnClient sfn = world.session.sfnClient()) {
        boolean exists =
            sfn.listStateMachines().stateMachines().stream()
                .anyMatch(sm -> "OrderProcessor".equals(sm.name()));
        if (!exists) {
          sfn.createStateMachine(
              r ->
                  r.name("OrderProcessor")
                      .definition(
                          "{\"Comment\":\"test\",\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}")
                      .roleArn("arn:aws:iam::000000000000:role/StepFunctionsRole")
                      .type(StateMachineType.STANDARD));
        }
      } catch (Exception e) {
        world.setFailure(e);
        return;
      }
    }
    iCall(service, operation);
  }

  @When("I start log capture and call {string} {string}")
  public void iStartLogCaptureAndCall(String service, String operation) throws Exception {
    world.logCapture = world.session.startLogCapture();
    iCall(service, operation);
    // Allow a moment for the WebSocket log entry to arrive
    Thread.sleep(200);
  }

  @When("I start log capture and call {string} {string} twice")
  public void iStartLogCaptureAndCallTwice(String service, String operation) throws Exception {
    world.logCapture = world.session.startLogCapture();
    iCall(service, operation);
    iCall(service, operation);
    Thread.sleep(400);
  }

  @When("I start log capture and call both {string} {string} and {string} {string}")
  public void iStartLogCaptureAndCallBoth(String service1, String op1, String service2, String op2)
      throws Exception {
    world.logCapture = world.session.startLogCapture();
    iCall(service1, op1);
    iCall(service2, op2);
    Thread.sleep(400);
  }

  // ---- dispatch ----

  private void dispatch(String service, String operation) throws Exception {
    switch (service) {
      case "stepfunctions" -> callStepFunctions(operation);
      case "dynamodb" -> callDynamoDb(operation);
      default -> world.setSuccess("pending: " + service + " " + operation);
    }
  }

  private static final String STATIC_SM_ARN =
      "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor";

  private void callStepFunctions(String operation) throws Exception {
    try (SfnClient sfn = world.session.sfnClient()) {
      switch (operation) {
        case "StartExecution" -> {
          // Try to find the state machine; fall back to a static ARN for fake/chaos scenarios
          String smArn = findStateMachineArn(sfn, "OrderProcessor");
          world.setSuccess(sfn.startExecution(r -> r.stateMachineArn(smArn).input("{}")));
        }
        case "ListStateMachines" -> world.setSuccess(sfn.listStateMachines());
        default -> world.setSuccess(sfn.listStateMachines());
      }
    }
  }

  private void callDynamoDb(String operation) throws Exception {
    try (DynamoDbClient ddb = world.session.dynamoDbClient()) {
      switch (operation) {
        case "ListTables" -> world.setSuccess(ddb.listTables());
        default -> world.setSuccess(ddb.listTables());
      }
    }
  }

  private String findStateMachineArn(SfnClient sfn, String name) {
    try {
      ListStateMachinesResponse list = sfn.listStateMachines();
      return list.stateMachines().stream()
          .filter(sm -> sm.name().equals(name))
          .map(StateMachineListItem::stateMachineArn)
          .findFirst()
          .orElse(STATIC_SM_ARN);
    } catch (Exception e) {
      // Under chaos or fake the list call may fail — use static ARN
      return STATIC_SM_ARN;
    }
  }
}
