@lambdasqsproducer @generated
Feature: LambdaSqsProducer - The Lambda Invocation Completes Successfully

  # Generated from FizzBee spec: lambda_sqs_producer.fizz
  # Safety invariants: InvocationRequiresActiveFunction, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the Lambda invocation completes successfully
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation completes successfully
    Then the invocation will be "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @guard @negative @invocation_succeeds @internal
  Scenario: the Lambda invocation completes successfully fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation completes successfully
    Then the operation is rejected
