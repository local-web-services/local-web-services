@lambdastepfunctions @generated
Feature: LambdaStepfunctions - A Running Execution Completes Successfully

  # Generated from FizzBee spec: lambda_stepfunctions.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RunningExecutionReferencesExistingStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @execution_completes @internal
  Scenario: a running execution completes successfully
    Given an execution is "RUNNING"
    When a running execution completes successfully
    Then the execution is "SUCCEEDED"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @standard @negative @execution_completes @internal
  Scenario: a running execution completes successfully fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution completes successfully
    Then the operation is rejected
