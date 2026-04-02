@snssqs @generated
Feature: SnsSqs - A "Sns" "Topic" Is Created

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @create_topic
  Scenario: a "sns" "topic" is created
    Given the "sns" "topic" did not already exist
    When a "sns" "topic" is created
    Then the "sns" "topic" will be "ACTIVE"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And an "sqs" "message" can only be delivered if a "CONFIRMED" "sns" "subscription" exists for the "sns" "topic"

  @guard @negative @create_topic
  Scenario: a "sns" "topic" is created fails when the "sns" "topic" already existed
    Given the "sns" "topic" already existed
    When a "sns" "topic" is created
    Then the operation is rejected
