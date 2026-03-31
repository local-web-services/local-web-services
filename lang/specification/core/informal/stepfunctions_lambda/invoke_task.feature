@stepfunctionslambda @generated
Feature: StepfunctionsLambda - A Running "Step Functions" "Execution" Reaches The Lambda Task State And Invokes The Function

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @minimal @happy @invoke_task
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given a "step functions" "execution" was "RUNNING"
    And the execution's state machine has a configured Lambda task
    And the configured function was "ACTIVE"
    And a "lambda" "invocation" slot is available
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Then the invocation will be "IN_PROGRESS"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @guard @negative @invoke_task
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Then the operation is rejected

  @guard @negative @invoke_task
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function fails when the execution's state machine has no Lambda task configured
    Given a "step functions" "execution" was "RUNNING"
    And the execution's state machine has no Lambda task configured
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Then the operation is rejected

  @guard @negative @invoke_task @lifecycle
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function fails when the configured function was not "ACTIVE"
    Given a "step functions" "execution" was "RUNNING"
    And the execution's state machine has a configured Lambda task
    And the configured function was not "ACTIVE"
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Then the operation is rejected

  @guard @negative @invoke_task @capacity
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function fails when no invocation slot is available
    Given a "step functions" "execution" was "RUNNING"
    And the execution's state machine has a configured Lambda task
    And the configured function was "ACTIVE"
    And no invocation slot is available
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Then the operation is rejected
