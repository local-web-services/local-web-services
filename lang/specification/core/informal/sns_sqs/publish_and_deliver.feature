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
    And the subscribed queue was "ACTIVE"
    And a message slot is available
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Then the message will be "AVAILABLE" in the queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

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
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue fails when no confirmed subscription existed for the topic
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And no confirmed subscription existed for the topic
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Then the operation is rejected

  @guard @negative @publish_and_deliver @lifecycle
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue fails when the subscribed queue was not "ACTIVE"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And a confirmed subscription existed for the "sns" "topic"
    And the subscribed queue was not "ACTIVE"
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Then the operation is rejected

  @guard @negative @publish_and_deliver @capacity
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue fails when no message slot is available
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And a confirmed subscription existed for the "sns" "topic"
    And the subscribed queue was "ACTIVE"
    And no message slot is available
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Then the operation is rejected
