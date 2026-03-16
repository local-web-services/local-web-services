@snssqs @generated
Feature: SnsSqs - A Message Is Consumed From The Sqs Queue

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @consume_message
  Scenario: a message is consumed from the "SQS" queue
    Given an "AVAILABLE" message exists in the queue
    When a message is consumed from the "SQS" queue
    Then the message is "DELETED"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @standard @negative @consume_message @lifecycle
  Scenario: a message is consumed from the "SQS" queue fails when no "AVAILABLE" message exists in the queue
    Given no "AVAILABLE" message exists in the queue
    When a message is consumed from the "SQS" queue
    Then the operation is rejected
