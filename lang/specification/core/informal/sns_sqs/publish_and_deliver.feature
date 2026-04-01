@snssqs @generated
Feature: SnsSqs - A Message Is Published To A "Sns" "Topic" And Delivered To The Subscribed Sqs Queue

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @publish_and_deliver
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And a confirmed subscription existed for the "sns" "topic"
    And the subscribed "sqs" "queue" was "ACTIVE"
    And a "sqs" "message" "slot" was "available"
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Then the "sqs" "message" will be "AVAILABLE" in the "sqs" "queue"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And an "sqs" "message" can only be delivered if a "CONFIRMED" "sns" "subscription" exists for the "sns" "topic"

  @guard @negative @publish_and_deliver
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue fails when the "sns" "topic" did not exist
    Given the "sns" "topic" did not exist
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Then the operation is rejected

  @guard @negative @publish_and_deliver @lifecycle
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue fails when the "sns" "topic" was not "ACTIVE"
    Given the "sns" "topic" existed
    And the "sns" "topic" was not "ACTIVE"
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Then the operation is rejected

  @guard @negative @publish_and_deliver @lifecycle
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue fails when no "confirmed" "subscription" existed for the "sns" "topic"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And no "confirmed" "subscription" existed for the "sns" "topic"
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Then the operation is rejected

  @guard @negative @publish_and_deliver @lifecycle
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue fails when the subscribed "sqs" "queue" was not "ACTIVE"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And a confirmed subscription existed for the "sns" "topic"
    And the subscribed "sqs" "queue" was not "ACTIVE"
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Then the operation is rejected

  @guard @negative @publish_and_deliver @capacity
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue fails when no "sqs" "message" "slot" was "available"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And a confirmed subscription existed for the "sns" "topic"
    And the subscribed "sqs" "queue" was "ACTIVE"
    And no "sqs" "message" "slot" was "available"
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Then the operation is rejected
