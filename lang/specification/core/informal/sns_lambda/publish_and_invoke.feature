@snslambda @generated
Feature: SnsLambda - A Message Is Published To An Sns Topic And Asynchronously Invokes The Subscribed Lambda Function

  # Generated from FizzBee spec: sns_lambda.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, InvocationRequiresActiveFunction, InvocationRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @publish_and_invoke
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given the topic exists
    And the topic is "ACTIVE"
    And a confirmed subscription exists for the topic
    And the subscribed function is "ACTIVE"
    And an invocation slot is available
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then the invocation is "IN_PROGRESS"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @standard @negative @publish_and_invoke
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function fails when the topic does not exist
    Given the topic does not exist
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then the operation is rejected

  @standard @negative @publish_and_invoke @lifecycle
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function fails when the topic is not "ACTIVE"
    Given the topic exists
    And the topic is not "ACTIVE"
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then the operation is rejected

  @standard @negative @publish_and_invoke @lifecycle
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function fails when no confirmed subscription exists for the topic
    Given the topic exists
    And the topic is "ACTIVE"
    And no confirmed subscription exists for the topic
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then the operation is rejected

  @standard @negative @publish_and_invoke @lifecycle
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function fails when the subscribed function is not "ACTIVE"
    Given the topic exists
    And the topic is "ACTIVE"
    And a confirmed subscription exists for the topic
    And the subscribed function is not "ACTIVE"
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then the operation is rejected

  @standard @negative @publish_and_invoke @capacity
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function fails when no invocation slot is available
    Given the topic exists
    And the topic is "ACTIVE"
    And a confirmed subscription exists for the topic
    And the subscribed function is "ACTIVE"
    And no invocation slot is available
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then the operation is rejected
