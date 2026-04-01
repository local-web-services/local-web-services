@snslambda @generated
Feature: SnsLambda - A "Sns" "Topic" Is Created

  # Generated from FizzBee spec: sns_lambda.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, InvocationRequiresActiveFunction, InvocationRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @create_topic
  Scenario: a "sns" "topic" is created
    Given the topic did not already exist
    When a "sns" "topic" is created
    Then the "sns" "topic" will be "ACTIVE"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @guard @negative @create_topic
  Scenario: a "sns" "topic" is created fails when the topic already existed
    Given the topic already existed
    When a "sns" "topic" is created
    Then the operation is rejected
