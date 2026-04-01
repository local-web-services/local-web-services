@stepfunctionslambda @generated
Feature: StepfunctionsLambda - A Lambda Task Is Configured On The State Machine

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @minimal @happy @configure_task
  Scenario: a Lambda task is configured on the state machine
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has no Lambda task configured
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When a Lambda task is configured on the state machine
    Then the state machine will invoke the function when it reaches the task state
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @guard @negative @configure_task
  Scenario: a Lambda task is configured on the state machine fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When a Lambda task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_task @lifecycle
  Scenario: a Lambda task is configured on the state machine fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When a Lambda task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_task
  Scenario: a Lambda task is configured on the state machine fails when the state machine already has a Lambda task configured
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine already has a Lambda task configured
    When a Lambda task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_task
  Scenario: a Lambda task is configured on the state machine fails when the "lambda" "function" did not exist
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has no Lambda task configured
    And the "lambda" "function" did not exist
    When a Lambda task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_task @lifecycle
  Scenario: a Lambda task is configured on the state machine fails when the "lambda" "function" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has no Lambda task configured
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a Lambda task is configured on the state machine
    Then the operation is rejected
