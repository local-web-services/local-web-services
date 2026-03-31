@snslambda @generated
Feature: SnsLambda - A Message Is Published To A "Sns" "Topic" And Asynchronously Invokes The Subscribed Lambda Function

  # Generated from FizzBee spec: sns_lambda.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, InvocationRequiresActiveFunction, InvocationRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @publish_and_invoke
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And a confirmed subscription existed for the "sns" "topic"
    And the subscribed function was "ACTIVE"
    And a "lambda" "invocation" slot is available
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Then the invocation will be "IN_PROGRESS"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @guard @negative @publish_and_invoke
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function fails when the "sns" "topic" did not exist
    Given the "sns" "topic" did not exist
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Then the operation is rejected

  @guard @negative @publish_and_invoke @lifecycle
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function fails when the "sns" "topic" was not "ACTIVE"
    Given the "sns" "topic" existed
    And the "sns" "topic" was not "ACTIVE"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Then the operation is rejected

  @guard @negative @publish_and_invoke @lifecycle
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function fails when no confirmed subscription existed for the topic
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And no confirmed subscription existed for the topic
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Then the operation is rejected

  @guard @negative @publish_and_invoke @lifecycle
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function fails when the subscribed function was not "ACTIVE"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And a confirmed subscription existed for the "sns" "topic"
    And the subscribed function was not "ACTIVE"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Then the operation is rejected

  @guard @negative @publish_and_invoke @capacity
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function fails when no invocation slot is available
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And a confirmed subscription existed for the "sns" "topic"
    And the subscribed function was "ACTIVE"
    And no invocation slot is available
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Then the operation is rejected
