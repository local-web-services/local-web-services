@snssqs @generated
Feature: SnsSqs - An Sqs Queue Is Created

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: an "SQS" queue is created
    Given the queue does not already exist
    When an "SQS" queue is created
    Then the queue is "ACTIVE"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @guard @negative @create_queue
  Scenario: an "SQS" queue is created fails when the queue already exists
    Given the queue already exists
    When an "SQS" queue is created
    Then the operation is rejected
