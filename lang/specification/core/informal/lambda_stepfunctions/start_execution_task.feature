@lambdastepfunctions @generated
Feature: LambdaStepfunctions - The "Lambda" "Function" Starts An Execution Of An Active State Machine And Succeeds

  # Generated from FizzBee spec: lambda_stepfunctions.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RunningExecutionReferencesExistingStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @start_execution_task @internal
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "step functions" "state machine" was "ACTIVE"
    And a "step functions" "execution" "slot" was "available"
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Then the "step functions" "execution" will be "RUNNING" and the "lambda" "invocation" will be "SUCCESS"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "RUNNING" "step functions" "execution" references a "step functions" "state machine" that exists

  @guard @negative @start_execution_task @internal
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Then the operation is rejected

  @guard @negative @start_execution_task @internal
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds fails when the "step functions" "state machine" did not exist or was "DELETED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "step functions" "state machine" did not exist or was "DELETED"
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Then the operation is rejected

  @guard @negative @start_execution_task @internal
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds fails when no "step functions" "execution" "slot" was "available"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "step functions" "state machine" was "ACTIVE"
    And no "step functions" "execution" "slot" was "available"
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Then the operation is rejected
