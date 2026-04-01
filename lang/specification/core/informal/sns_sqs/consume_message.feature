@snssqs @generated
Feature: SnsSqs - A Message Is Consumed From The "Sqs" "Queue"

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @consume_message
  Scenario: a message is consumed from the "sqs" "queue"
    Given an "AVAILABLE" message existed in the queue
    When a message is consumed from the "sqs" "queue"
    Then the message will be deleted
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @guard @negative @consume_message @lifecycle
  Scenario: a message is consumed from the "sqs" "queue" fails when no "AVAILABLE" message existed in the queue
    Given no "AVAILABLE" message existed in the queue
    When a message is consumed from the "sqs" "queue"
    Then the operation is rejected
