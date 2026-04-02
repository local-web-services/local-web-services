@stepfunctionslambda @generated
Feature: StepfunctionsLambda - A Running "Step Functions" "Execution" Reaches The Lambda Task State And Invokes The Function

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @minimal @happy @invoke_task
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given a "step functions" "execution" was "RUNNING"
    And the "step functions" "execution"'s state machine has a configured "lambda" task
    And the configured "lambda" "function" was "ACTIVE"
    And a "lambda" "invocation" slot is available
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Then the "lambda" "invocation" will be "IN_PROGRESS"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @guard @negative @invoke_task
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Then the operation is rejected

  @guard @negative @invoke_task
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function fails when the "step functions" "execution"'s state machine has no "lambda" task configured
    Given a "step functions" "execution" was "RUNNING"
    And the "step functions" "execution"'s state machine has no "lambda" task configured
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Then the operation is rejected

  @guard @negative @invoke_task @lifecycle
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function fails when the configured "lambda" "function" was not "ACTIVE"
    Given a "step functions" "execution" was "RUNNING"
    And the "step functions" "execution"'s state machine has a configured "lambda" task
    And the configured "lambda" "function" was not "ACTIVE"
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Then the operation is rejected

  @guard @negative @invoke_task @capacity
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function fails when no "lambda" "invocation" "slot" was "available"
    Given a "step functions" "execution" was "RUNNING"
    And the "step functions" "execution"'s state machine has a configured "lambda" task
    And the configured "lambda" "function" was "ACTIVE"
    And no "lambda" "invocation" "slot" was "available"
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Then the operation is rejected
