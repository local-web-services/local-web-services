@snssqs @generated
Feature: SnsSqs - A "Sns" "Topic" Is Created

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @create_topic
  Scenario: a "sns" "topic" is created
    Given the topic did not already exist
    When a "sns" "topic" is created
    Then the "sns" "topic" will be "ACTIVE"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @guard @negative @create_topic
  Scenario: a "sns" "topic" is created fails when the topic already existed
    Given the topic already existed
    When a "sns" "topic" is created
    Then the operation is rejected
