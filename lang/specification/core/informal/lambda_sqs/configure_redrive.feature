@lambdasqs @generated
Feature: LambdaSqs - The "Sqs" "Queue" Is Configured With A Dead-Letter Queue

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @configure_redrive
  Scenario: the "sqs" "queue" is configured with a dead-letter queue
    Given the source "sqs" "queue" existed
    And the source "sqs" "queue" was "ACTIVE"
    And the dead-letter "sqs" "queue" existed
    And the "sqs" "dead-letter queue" was "ACTIVE"
    And the source "sqs" "queue" has no dead-letter queue configured
    When the "sqs" "queue" is configured with a dead-letter queue
    Then failed "sqs" "message"s will be redriven to the "sqs" "dead-letter queue" after two receives
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @guard @negative @configure_redrive
  Scenario: the "sqs" "queue" is configured with a dead-letter queue fails when the source "sqs" "queue" did not exist
    Given the source "sqs" "queue" did not exist
    When the "sqs" "queue" is configured with a dead-letter queue
    Then the operation is rejected

  @guard @negative @configure_redrive @lifecycle
  Scenario: the "sqs" "queue" is configured with a dead-letter queue fails when the source "sqs" "queue" was not "ACTIVE"
    Given the source "sqs" "queue" existed
    And the source "sqs" "queue" was not "ACTIVE"
    When the "sqs" "queue" is configured with a dead-letter queue
    Then the operation is rejected

  @guard @negative @configure_redrive
  Scenario: the "sqs" "queue" is configured with a dead-letter queue fails when the dead-letter "sqs" "queue" did not exist
    Given the source "sqs" "queue" existed
    And the source "sqs" "queue" was "ACTIVE"
    And the dead-letter "sqs" "queue" did not exist
    When the "sqs" "queue" is configured with a dead-letter queue
    Then the operation is rejected

  @guard @negative @configure_redrive @lifecycle
  Scenario: the "sqs" "queue" is configured with a dead-letter queue fails when the "sqs" "dead-letter queue" was not "ACTIVE"
    Given the source "sqs" "queue" existed
    And the source "sqs" "queue" was "ACTIVE"
    And the dead-letter "sqs" "queue" existed
    And the "sqs" "dead-letter queue" was not "ACTIVE"
    When the "sqs" "queue" is configured with a dead-letter queue
    Then the operation is rejected

  @guard @negative @configure_redrive
  Scenario: the "sqs" "queue" is configured with a dead-letter queue fails when the source "sqs" "queue" already has a dead-letter queue configured
    Given the source "sqs" "queue" existed
    And the source "sqs" "queue" was "ACTIVE"
    And the dead-letter "sqs" "queue" existed
    And the "sqs" "dead-letter queue" was "ACTIVE"
    And the source "sqs" "queue" already has a dead-letter queue configured
    When the "sqs" "queue" is configured with a dead-letter queue
    Then the operation is rejected
