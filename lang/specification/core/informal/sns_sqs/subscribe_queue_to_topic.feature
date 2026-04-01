@snssqs @generated
Feature: SnsSqs - A "Sqs" "Queue" Subscribes To A "Sns" "Topic"

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @subscribe_queue_to_topic
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    And an "sns" "subscription" "slot" was "available"
    When a "sqs" "queue" subscribes to a "sns" "topic"
    Then the "sns" "subscription" will be "CONFIRMED" and the "sqs" "queue" will receive published messages
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And an "sqs" "message" can only be delivered if a "CONFIRMED" "sns" "subscription" exists for the "sns" "topic"

  @guard @negative @subscribe_queue_to_topic
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic" fails when the "sns" "topic" did not exist
    Given the "sns" "topic" did not exist
    When a "sqs" "queue" subscribes to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @subscribe_queue_to_topic @lifecycle
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic" fails when the "sns" "topic" was not "ACTIVE"
    Given the "sns" "topic" existed
    And the "sns" "topic" was not "ACTIVE"
    When a "sqs" "queue" subscribes to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @subscribe_queue_to_topic
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic" fails when the "sqs" "queue" did not exist
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And the "sqs" "queue" did not exist
    When a "sqs" "queue" subscribes to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @subscribe_queue_to_topic @lifecycle
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic" fails when the "sqs" "queue" was not "ACTIVE"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And the "sqs" "queue" existed
    And the "sqs" "queue" was not "ACTIVE"
    When a "sqs" "queue" subscribes to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @subscribe_queue_to_topic @capacity
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic" fails when no "sns" "subscription" "slot" was "available"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    And no "sns" "subscription" "slot" was "available"
    When a "sqs" "queue" subscribes to a "sns" "topic"
    Then the operation is rejected
