@lambdastepfunctions @generated
Feature: LambdaStepfunctions - A Running "Step Functions" "Execution" Completes Successfully

  # Generated from FizzBee spec: lambda_stepfunctions.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RunningExecutionReferencesExistingStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @execution_completes @internal
  Scenario: a running "step functions" "execution" completes successfully
    Given a "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" completes successfully
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @guard @negative @execution_completes @internal
  Scenario: a running "step functions" "execution" completes successfully fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" completes successfully
    Then the operation is rejected
