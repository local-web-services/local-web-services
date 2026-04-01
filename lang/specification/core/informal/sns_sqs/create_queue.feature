@snssqs @generated
Feature: SnsSqs - A "Sqs" "Queue" Is Created

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: a "sqs" "queue" is created
    Given the queue did not already exist
    When a "sqs" "queue" is created
    Then the "sqs" "queue" will be "ACTIVE"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @guard @negative @create_queue
  Scenario: a "sqs" "queue" is created fails when the queue already existed
    Given the queue already existed
    When a "sqs" "queue" is created
    Then the operation is rejected
