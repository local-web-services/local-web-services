@lambdastepfunctions @generated
Feature: LambdaStepfunctions - The "Lambda" "Function" Fails To Start An Execution Because The State Machine Has Been Deleted

  # Generated from FizzBee spec: lambda_stepfunctions.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RunningExecutionReferencesExistingStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_state_machine_deleted
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "step functions" "state machine" was "DELETED"
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    Then the invocation will be "FAILED" with a StateMachineDoesNotExist error
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @guard @negative @invocation_fails_state_machine_deleted @lifecycle
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_state_machine_deleted @lifecycle
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted fails when the "step functions" "state machine" was not "DELETED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "step functions" "state machine" was not "DELETED"
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    Then the operation is rejected
