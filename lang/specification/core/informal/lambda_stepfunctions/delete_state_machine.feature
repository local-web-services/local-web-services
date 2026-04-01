@lambdastepfunctions @generated
Feature: LambdaStepfunctions - A "Step Functions" "State Machine" Is Deleted

  # Generated from FizzBee spec: lambda_stepfunctions.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RunningExecutionReferencesExistingStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @delete_state_machine
  Scenario: a "step functions" "state machine" is deleted
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    When a "step functions" "state machine" is deleted
    Then the "step functions" "state machine" will be deleted and Lambda StartExecution calls will fail
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "RUNNING" "step functions" "execution" references a "step functions" "state machine" that exists

  @guard @negative @delete_state_machine
  Scenario: a "step functions" "state machine" is deleted fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When a "step functions" "state machine" is deleted
    Then the operation is rejected

  @guard @negative @delete_state_machine @lifecycle
  Scenario: a "step functions" "state machine" is deleted fails when the "step functions" "state machine" is already "DELETED"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" is already "DELETED"
    When a "step functions" "state machine" is deleted
    Then the operation is rejected
