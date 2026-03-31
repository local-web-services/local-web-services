@lambdadynamodb @generated
Feature: LambdaDynamodb - The Lambda Invocation Completes Successfully

  # Generated from FizzBee spec: lambda_dynamodb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the Lambda invocation completes successfully
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation completes successfully
    Then the invocation will be "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @guard @negative @invocation_succeeds @internal
  Scenario: the Lambda invocation completes successfully fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation completes successfully
    Then the operation is rejected
