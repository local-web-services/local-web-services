@stepfunctionslambda @generated
Feature: StepfunctionsLambda - The Lambda Task Completes Successfully And The Execution Succeeds

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @minimal @happy @task_succeeds @internal
  Scenario: the Lambda task completes successfully and the execution succeeds
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda task completes successfully and the execution succeeds
    Then the invocation will be "SUCCESS" and the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @guard @negative @task_succeeds @internal
  Scenario: the Lambda task completes successfully and the execution succeeds fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda task completes successfully and the execution succeeds
    Then the operation is rejected
