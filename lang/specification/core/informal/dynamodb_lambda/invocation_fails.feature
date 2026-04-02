@dynamodblambda @generated
Feature: DynamodbLambda - The "Lambda" "Function" Invocation Fails And The Stream Record Is Retried

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the "lambda" "function" invocation fails and the stream record is retried
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation fails and the stream record is retried
    Then the "lambda" "invocation" will be "FAILED" and the "dynamodb" "record" will be "AVAILABLE" again for reprocessing
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "dynamodb" "table" with streaming enabled

  @guard @negative @invocation_fails @internal
  Scenario: the "lambda" "function" invocation fails and the stream record is retried fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation fails and the stream record is retried
    Then the operation is rejected
