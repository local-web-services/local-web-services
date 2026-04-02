@stepfunctionslambda @generated
Feature: StepfunctionsLambda - The "Lambda" Task Fails And The "Step Functions" "Execution" Fails

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @minimal @happy @task_fails @internal
  Scenario: the "lambda" task fails and the "step functions" "execution" fails
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" task fails and the "step functions" "execution" fails
    Then the invocation will be "FAILED" and the "step functions" "execution" will be "FAILED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @guard @negative @task_fails @internal
  Scenario: the "lambda" task fails and the "step functions" "execution" fails fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" task fails and the "step functions" "execution" fails
    Then the operation is rejected
