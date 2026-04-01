@stepfunctionslambda @generated
Feature: StepfunctionsLambda - The "Lambda" Task Completes Successfully And The "Step Functions" "Execution" Succeeds

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @minimal @happy @task_succeeds @internal
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Then the invocation will be "SUCCESS" and the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @guard @negative @task_succeeds @internal
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Then the operation is rejected
