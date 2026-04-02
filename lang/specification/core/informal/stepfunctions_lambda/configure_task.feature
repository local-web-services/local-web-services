@stepfunctionslambda @generated
Feature: StepfunctionsLambda - A "Lambda" Task Is Configured On The "Step Functions" "State Machine"

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @minimal @happy @configure_task
  Scenario: a "lambda" task is configured on the "step functions" "state machine"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" has no "lambda" task configured
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When a "lambda" task is configured on the "step functions" "state machine"
    Then the "step functions" "state machine" will invoke the "lambda" "function" when it reaches the task state
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @guard @negative @configure_task
  Scenario: a "lambda" task is configured on the "step functions" "state machine" fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When a "lambda" task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_task @lifecycle
  Scenario: a "lambda" task is configured on the "step functions" "state machine" fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When a "lambda" task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_task
  Scenario: a "lambda" task is configured on the "step functions" "state machine" fails when the "step functions" "state machine" already has a "lambda" task configured
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" already has a "lambda" task configured
    When a "lambda" task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_task
  Scenario: a "lambda" task is configured on the "step functions" "state machine" fails when the "lambda" "function" did not exist
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" has no "lambda" task configured
    And the "lambda" "function" did not exist
    When a "lambda" task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_task @lifecycle
  Scenario: a "lambda" task is configured on the "step functions" "state machine" fails when the "lambda" "function" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" has no "lambda" task configured
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a "lambda" task is configured on the "step functions" "state machine"
    Then the operation is rejected
