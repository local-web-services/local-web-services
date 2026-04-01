@lambdasqsproducer @generated
Feature: LambdaSqsProducer - The Lambda Invocation Fails

  # Generated from FizzBee spec: lambda_sqs_producer.fizz
  # Safety invariants: InvocationRequiresActiveFunction, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the Lambda invocation fails
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation fails
    Then the invocation will be "FAILED"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @guard @negative @invocation_fails @internal
  Scenario: the Lambda invocation fails fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation fails
    Then the operation is rejected
