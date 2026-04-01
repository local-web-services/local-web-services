@dynamodblambda @generated
Feature: DynamodbLambda - The "Lambda" "Function" Invocation Processes The "Dynamodb" "Stream" Record Successfully

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the "lambda" "function" invocation processes the "dynamodb" "stream" record successfully
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation processes the "dynamodb" "stream" record successfully
    Then the "lambda" "invocation" will be "SUCCESS" and the "dynamodb" "record" will be "PROCESSED"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "dynamodb" "table" with streaming enabled

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" invocation processes the "dynamodb" "stream" record successfully fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation processes the "dynamodb" "stream" record successfully
    Then the operation is rejected
