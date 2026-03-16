@dynamodblambda @generated
Feature: DynamodbLambda - The Lambda Invocation Fails And The Stream Record Is Retried

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the Lambda invocation fails and the stream record is retried
    Given an invocation is "IN_PROGRESS"
    When the Lambda invocation fails and the stream record is retried
    Then the invocation is "FAILED" and the record is "AVAILABLE" again for reprocessing
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @standard @negative @invocation_fails @internal
  Scenario: the Lambda invocation fails and the stream record is retried fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda invocation fails and the stream record is retried
    Then the operation is rejected
