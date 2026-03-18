@lambdasqs @generated
Feature: LambdaSqs - The Sqs Queue Is Configured With A Dead-Letter Queue

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @configure_redrive
  Scenario: the "SQS" queue is configured with a dead-letter queue
    Given the source queue exists
    And the source queue is "ACTIVE"
    And the dead-letter queue exists
    And the dead-letter queue is "ACTIVE"
    And the source queue has no dead-letter queue configured
    When the "SQS" queue is configured with a dead-letter queue
    Then failed messages will be redriven to the dead-letter queue after two receives
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @standard @negative @configure_redrive
  Scenario: the "SQS" queue is configured with a dead-letter queue fails when the source queue does not exist
    Given the source queue does not exist
    When the "SQS" queue is configured with a dead-letter queue
    Then the operation is rejected

  @standard @negative @configure_redrive @lifecycle @internal
  Scenario: the "SQS" queue is configured with a dead-letter queue fails when the source queue is not "ACTIVE"
    Given the source queue exists
    And the source queue is not "ACTIVE"
    When the "SQS" queue is configured with a dead-letter queue
    Then the operation is rejected

  @standard @negative @configure_redrive
  Scenario: the "SQS" queue is configured with a dead-letter queue fails when the dead-letter queue does not exist
    Given the source queue exists
    And the source queue is "ACTIVE"
    And the dead-letter queue does not exist
    When the "SQS" queue is configured with a dead-letter queue
    Then the operation is rejected

  @standard @negative @configure_redrive @lifecycle @internal
  Scenario: the "SQS" queue is configured with a dead-letter queue fails when the dead-letter queue is not "ACTIVE"
    Given the source queue exists
    And the source queue is "ACTIVE"
    And the dead-letter queue exists
    And the dead-letter queue is not "ACTIVE"
    When the "SQS" queue is configured with a dead-letter queue
    Then the operation is rejected

  @standard @negative @configure_redrive
  Scenario: the "SQS" queue is configured with a dead-letter queue fails when the source queue already has a dead-letter queue configured
    Given the source queue exists
    And the source queue is "ACTIVE"
    And the dead-letter queue exists
    And the dead-letter queue is "ACTIVE"
    And the source queue already has a dead-letter queue configured
    When the "SQS" queue is configured with a dead-letter queue
    Then the operation is rejected
