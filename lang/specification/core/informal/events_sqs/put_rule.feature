@eventssqs @generated
Feature: EventsSqs - An Eventbridge Rule Is Created To Route Matching Events To The Sqs Queue

  # Generated from FizzBee spec: events_sqs.fizz
  # Safety invariants: RuleReferencesActiveBus, MessagesReferenceActiveQueues

  Background:
    Given the system is initialized

  @minimal @happy @put_rule
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the queue exists
    And the queue is "ACTIVE"
    And the rule does not already exist
    When an EventBridge rule is created to route matching events to the "SQS" queue
    Then the rule is "ENABLED" and will forward matching events to the queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @standard @negative @put_rule
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue fails when the event bus does not exist
    Given the event bus does not exist
    When an EventBridge rule is created to route matching events to the "SQS" queue
    Then the operation is rejected

  @standard @negative @put_rule @lifecycle @internal
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue fails when the event bus is not "ACTIVE"
    Given the event bus exists
    And the event bus is not "ACTIVE"
    When an EventBridge rule is created to route matching events to the "SQS" queue
    Then the operation is rejected

  @standard @negative @put_rule
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue fails when the queue does not exist
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the queue does not exist
    When an EventBridge rule is created to route matching events to the "SQS" queue
    Then the operation is rejected

  @standard @negative @put_rule @lifecycle @internal
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue fails when the queue is not "ACTIVE"
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the queue exists
    And the queue is not "ACTIVE"
    When an EventBridge rule is created to route matching events to the "SQS" queue
    Then the operation is rejected

  @standard @negative @put_rule
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue fails when the rule already exists
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the queue exists
    And the queue is "ACTIVE"
    And the rule already exists
    When an EventBridge rule is created to route matching events to the "SQS" queue
    Then the operation is rejected
