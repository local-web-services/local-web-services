@snslambda @generated
Feature: SnsLambda - An Sns Topic Is Created

  # Generated from FizzBee spec: sns_lambda.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, InvocationRequiresActiveFunction, InvocationRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @create_topic
  Scenario: an "SNS" topic is created
    Given the topic does not already exist
    When an "SNS" topic is created
    Then the topic is "ACTIVE"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @standard @negative @create_topic
  Scenario: an "SNS" topic is created fails when the topic already exists
    Given the topic already exists
    When an "SNS" topic is created
    Then the operation is rejected
