@snssqs @generated
Feature: SnsSqs - A "Sqs" "Queue" Is Created

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: a "sqs" "queue" is created
    Given the "sqs" "queue" did not already exist
    When a "sqs" "queue" is created
    Then the "sqs" "queue" will be "ACTIVE"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And an "sqs" "message" can only be delivered if a "CONFIRMED" "sns" "subscription" exists for the "sns" "topic"

  @guard @negative @create_queue
  Scenario: a "sqs" "queue" is created fails when the "sqs" "queue" already existed
    Given the "sqs" "queue" already existed
    When a "sqs" "queue" is created
    Then the operation is rejected
