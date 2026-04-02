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
    Then the "sqs" "message" will be "DELETED"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And an "sqs" "message" can only be delivered if a "CONFIRMED" "sns" "subscription" exists for the "sns" "topic"

  @guard @negative @consume_message @lifecycle
  Scenario: a message is consumed from the "sqs" "queue" fails when no "AVAILABLE" message existed in the queue
    Given no "AVAILABLE" message existed in the queue
    When a message is consumed from the "sqs" "queue"
    Then the operation is rejected
