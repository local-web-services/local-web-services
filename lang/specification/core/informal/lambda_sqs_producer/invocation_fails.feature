@lambdasqsproducer @generated
Feature: LambdaSqsProducer - The "Lambda" "Function" Invocation Fails

  # Generated from FizzBee spec: lambda_sqs_producer.fizz
  # Safety invariants: InvocationRequiresActiveFunction, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the "lambda" "function" invocation fails
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation fails
    Then the "lambda" "invocation" will be "FAILED"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @guard @negative @invocation_fails @internal
  Scenario: the "lambda" "function" invocation fails fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation fails
    Then the operation is rejected
