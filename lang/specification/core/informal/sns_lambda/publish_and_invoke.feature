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
    And a "sns" "subscription" was "CONFIRMED" for the "sns" "topic"
    And the subscribed "lambda" "function" was "ACTIVE"
    And a "lambda" "invocation" "slot" was "available"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Then the "lambda" "invocation" will be "IN_PROGRESS"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

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
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function fails when no "sns" "subscription" was "CONFIRMED" for the "sns" "topic"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And no "sns" "subscription" was "CONFIRMED" for the "sns" "topic"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Then the operation is rejected

  @guard @negative @publish_and_invoke @lifecycle
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function fails when the subscribed "lambda" "function" was not "ACTIVE"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And a "sns" "subscription" was "CONFIRMED" for the "sns" "topic"
    And the subscribed "lambda" "function" was not "ACTIVE"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Then the operation is rejected

  @guard @negative @publish_and_invoke @capacity
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function fails when no "lambda" "invocation" "slot" was "available"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And a "sns" "subscription" was "CONFIRMED" for the "sns" "topic"
    And the subscribed "lambda" "function" was "ACTIVE"
    And no "lambda" "invocation" "slot" was "available"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Then the operation is rejected
