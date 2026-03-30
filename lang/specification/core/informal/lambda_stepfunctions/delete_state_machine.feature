@lambdastepfunctions @generated
Feature: LambdaStepfunctions - A Step Functions State Machine Is Deleted

  # Generated from FizzBee spec: lambda_stepfunctions.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RunningExecutionReferencesExistingStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @delete_state_machine
  Scenario: a Step Functions state machine is deleted
    Given the state machine exists
    And the state machine is "ACTIVE"
    When a Step Functions state machine is deleted
    Then the state machine is "DELETED" and Lambda StartExecution calls will fail
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @guard @negative @delete_state_machine
  Scenario: a Step Functions state machine is deleted fails when the state machine does not exist
    Given the state machine does not exist
    When a Step Functions state machine is deleted
    Then the operation is rejected

  @guard @negative @delete_state_machine @lifecycle
  Scenario: a Step Functions state machine is deleted fails when the state machine is already "DELETED"
    Given the state machine exists
    And the state machine is already "DELETED"
    When a Step Functions state machine is deleted
    Then the operation is rejected
