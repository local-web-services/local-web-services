@dynamodblambda @generated
Feature: DynamodbLambda - The Lambda Invocation Processes The Stream Record Successfully

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the Lambda invocation processes the stream record successfully
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation processes the stream record successfully
    Then the invocation will be "SUCCESS" and the record will be "PROCESSED"
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @guard @negative @invocation_succeeds @internal
  Scenario: the Lambda invocation processes the stream record successfully fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation processes the stream record successfully
    Then the operation is rejected
