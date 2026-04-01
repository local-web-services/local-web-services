@stepfunctionslambda @generated
Feature: StepfunctionsLambda - A "Lambda" "Function" Is Deployed

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @minimal @happy @deploy_function
  Scenario: a "lambda" "function" is deployed
    Given the "lambda" "function" did not already exist
    When a "lambda" "function" is deployed
    Then the "lambda" "function" will be "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @guard @negative @deploy_function
  Scenario: a "lambda" "function" is deployed fails when the "lambda" "function" already existed
    Given the "lambda" "function" already existed
    When a "lambda" "function" is deployed
    Then the operation is rejected
