@stepfunctionslambda @generated
Feature: StepfunctionsLambda - A Lambda Task Is Configured On The State Machine

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @minimal @happy @configure_task
  Scenario: a Lambda task is configured on the state machine
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no Lambda task configured
    And the function exists
    And the function is "ACTIVE"
    When a Lambda task is configured on the state machine
    Then the state machine will invoke the function when it reaches the task state
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @standard @negative @configure_task
  Scenario: a Lambda task is configured on the state machine fails when the state machine does not exist
    Given the state machine does not exist
    When a Lambda task is configured on the state machine
    Then the operation is rejected

  @standard @negative @configure_task @lifecycle
  Scenario: a Lambda task is configured on the state machine fails when the state machine is not "ACTIVE"
    Given the state machine exists
    And the state machine is not "ACTIVE"
    When a Lambda task is configured on the state machine
    Then the operation is rejected

  @standard @negative @configure_task
  Scenario: a Lambda task is configured on the state machine fails when the state machine already has a Lambda task configured
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine already has a Lambda task configured
    When a Lambda task is configured on the state machine
    Then the operation is rejected

  @standard @negative @configure_task
  Scenario: a Lambda task is configured on the state machine fails when the function does not exist
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no Lambda task configured
    And the function does not exist
    When a Lambda task is configured on the state machine
    Then the operation is rejected

  @standard @negative @configure_task @lifecycle
  Scenario: a Lambda task is configured on the state machine fails when the function is not "ACTIVE"
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no Lambda task configured
    And the function exists
    And the function is not "ACTIVE"
    When a Lambda task is configured on the state machine
    Then the operation is rejected
