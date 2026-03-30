@lambdastepfunctions @generated
Feature: LambdaStepfunctions - The Lambda Function Fails To Start An Execution Because The State Machine Has Been Deleted

  # Generated from FizzBee spec: lambda_stepfunctions.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RunningExecutionReferencesExistingStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_state_machine_deleted
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted
    Given an invocation is "IN_PROGRESS"
    And the state machine is "DELETED"
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then the invocation is "FAILED" with a StateMachineDoesNotExist error
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @guard @negative @invocation_fails_state_machine_deleted @lifecycle
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_state_machine_deleted @lifecycle
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted fails when the state machine is not "DELETED"
    Given an invocation is "IN_PROGRESS"
    And the state machine is not "DELETED"
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then the operation is rejected
