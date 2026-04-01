@stepfunctionslambda @generated
Feature: StepfunctionsLambda - The Lambda Task Fails And The Execution Fails

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @minimal @happy @task_fails @internal
  Scenario: the Lambda task fails and the execution fails
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda task fails and the execution fails
    Then the invocation will be "FAILED" and the "step functions" "execution" will be "FAILED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @guard @negative @task_fails @internal
  Scenario: the Lambda task fails and the execution fails fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda task fails and the execution fails
    Then the operation is rejected
