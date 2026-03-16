@snssqs @generated
Feature: SnsSqs - An Sns Topic Is Created

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @create_topic
  Scenario: an "SNS" topic is created
    Given the topic does not already exist
    When an "SNS" topic is created
    Then the topic is "ACTIVE"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @standard @negative @create_topic
  Scenario: an "SNS" topic is created fails when the topic already exists
    Given the topic already exists
    When an "SNS" topic is created
    Then the operation is rejected
