@stepfunctionslambda @generated
Feature: StepfunctionsLambda - The Lambda Task Completes Successfully And The Execution Succeeds

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @minimal @happy @task_succeeds @internal
  Scenario: the Lambda task completes successfully and the execution succeeds
    Given an invocation is "IN_PROGRESS"
    When the Lambda task completes successfully and the execution succeeds
    Then the invocation is "SUCCESS" and the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @standard @negative @task_succeeds @internal
  Scenario: the Lambda task completes successfully and the execution succeeds fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda task completes successfully and the execution succeeds
    Then the operation is rejected
