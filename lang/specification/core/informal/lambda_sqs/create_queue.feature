@lambdasqs @generated
Feature: LambdaSqs - A "Sqs" "Queue" Is Created

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: a "sqs" "queue" is created
    Given the "sqs" "queue" did not already exist
    When a "sqs" "queue" is created
    Then the "sqs" "queue" will be "ACTIVE" with no dead-letter queue configured
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @guard @negative @create_queue
  Scenario: a "sqs" "queue" is created fails when the "sqs" "queue" already existed
    Given the "sqs" "queue" already existed
    When a "sqs" "queue" is created
    Then the operation is rejected
