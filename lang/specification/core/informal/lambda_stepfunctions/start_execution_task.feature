@lambdastepfunctions @generated
Feature: LambdaStepfunctions - The Lambda Function Starts An Execution Of An Active State Machine And Succeeds

  # Generated from FizzBee spec: lambda_stepfunctions.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RunningExecutionReferencesExistingStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @start_execution_task @internal
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given an invocation is "IN_PROGRESS"
    And the state machine is "ACTIVE"
    And an execution slot is available
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then the execution is "RUNNING" and the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @guard @negative @start_execution_task @internal
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then the operation is rejected

  @guard @negative @start_execution_task @internal
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds fails when the state machine does not exist or is "DELETED"
    Given an invocation is "IN_PROGRESS"
    And the state machine does not exist or is "DELETED"
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then the operation is rejected

  @guard @negative @start_execution_task @internal
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds fails when no execution slot is available
    Given an invocation is "IN_PROGRESS"
    And the state machine is "ACTIVE"
    And no execution slot is available
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then the operation is rejected
