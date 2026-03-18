@snssqs @generated
Feature: SnsSqs - A Message Is Published To An Sns Topic And Delivered To The Subscribed Sqs Queue

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @publish_and_deliver
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Given the topic exists
    And the topic is "ACTIVE"
    And a confirmed subscription exists for the topic
    And the subscribed queue is "ACTIVE"
    And a message slot is available
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Then the message is "AVAILABLE" in the queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @standard @negative @publish_and_deliver
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue fails when the topic does not exist
    Given the topic does not exist
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Then the operation is rejected

  @standard @negative @publish_and_deliver @lifecycle @internal
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue fails when the topic is not "ACTIVE"
    Given the topic exists
    And the topic is not "ACTIVE"
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Then the operation is rejected

  @standard @negative @publish_and_deliver @lifecycle @internal
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue fails when no confirmed subscription exists for the topic
    Given the topic exists
    And the topic is "ACTIVE"
    And no confirmed subscription exists for the topic
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Then the operation is rejected

  @standard @negative @publish_and_deliver @lifecycle @internal
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue fails when the subscribed queue is not "ACTIVE"
    Given the topic exists
    And the topic is "ACTIVE"
    And a confirmed subscription exists for the topic
    And the subscribed queue is not "ACTIVE"
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Then the operation is rejected

  @standard @negative @publish_and_deliver @capacity @internal
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue fails when no message slot is available
    Given the topic exists
    And the topic is "ACTIVE"
    And a confirmed subscription exists for the topic
    And the subscribed queue is "ACTIVE"
    And no message slot is available
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Then the operation is rejected
