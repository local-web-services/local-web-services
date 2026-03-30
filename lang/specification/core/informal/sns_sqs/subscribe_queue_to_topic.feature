@snssqs @generated
Feature: SnsSqs - An Sqs Queue Subscribes To An Sns Topic

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @subscribe_queue_to_topic
  Scenario: an "SQS" queue subscribes to an "SNS" topic
    Given the topic exists
    And the topic is "ACTIVE"
    And the queue exists
    And the queue is "ACTIVE"
    And the subscription slot is available
    When an "SQS" queue subscribes to an "SNS" topic
    Then the subscription is "CONFIRMED" and the queue will receive published messages
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @guard @negative @subscribe_queue_to_topic
  Scenario: an "SQS" queue subscribes to an "SNS" topic fails when the topic does not exist
    Given the topic does not exist
    When an "SQS" queue subscribes to an "SNS" topic
    Then the operation is rejected

  @guard @negative @subscribe_queue_to_topic @lifecycle
  Scenario: an "SQS" queue subscribes to an "SNS" topic fails when the topic is not "ACTIVE"
    Given the topic exists
    And the topic is not "ACTIVE"
    When an "SQS" queue subscribes to an "SNS" topic
    Then the operation is rejected

  @guard @negative @subscribe_queue_to_topic
  Scenario: an "SQS" queue subscribes to an "SNS" topic fails when the queue does not exist
    Given the topic exists
    And the topic is "ACTIVE"
    And the queue does not exist
    When an "SQS" queue subscribes to an "SNS" topic
    Then the operation is rejected

  @guard @negative @subscribe_queue_to_topic @lifecycle
  Scenario: an "SQS" queue subscribes to an "SNS" topic fails when the queue is not "ACTIVE"
    Given the topic exists
    And the topic is "ACTIVE"
    And the queue exists
    And the queue is not "ACTIVE"
    When an "SQS" queue subscribes to an "SNS" topic
    Then the operation is rejected

  @guard @negative @internal @subscribe_queue_to_topic @capacity
  Scenario: an "SQS" queue subscribes to an "SNS" topic fails when the subscription slot is not available
    Given the topic exists
    And the topic is "ACTIVE"
    And the queue exists
    And the queue is "ACTIVE"
    And the subscription slot is not available
    When an "SQS" queue subscribes to an "SNS" topic
    Then the operation is rejected
