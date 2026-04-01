@snslambda @generated
Feature: SnsLambda - A "Lambda" "Function" Subscribes To A "Sns" "Topic"

  # Generated from FizzBee spec: sns_lambda.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, InvocationRequiresActiveFunction, InvocationRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @subscribe_function_to_topic
  Scenario: a "lambda" "function" subscribes to a "sns" "topic"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And a "sns" "subscription" "slot" was "available"
    When a "lambda" "function" subscribes to a "sns" "topic"
    Then the "sns" "subscription" will be "CONFIRMED" and the "lambda" "function" will be invoked on published messages
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @guard @negative @subscribe_function_to_topic
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" fails when the "sns" "topic" did not exist
    Given the "sns" "topic" did not exist
    When a "lambda" "function" subscribes to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @subscribe_function_to_topic @lifecycle
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" fails when the "sns" "topic" was not "ACTIVE"
    Given the "sns" "topic" existed
    And the "sns" "topic" was not "ACTIVE"
    When a "lambda" "function" subscribes to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @subscribe_function_to_topic
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" fails when the "lambda" "function" did not exist
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And the "lambda" "function" did not exist
    When a "lambda" "function" subscribes to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @subscribe_function_to_topic @lifecycle
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" fails when the "lambda" "function" was not "ACTIVE"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a "lambda" "function" subscribes to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @subscribe_function_to_topic @capacity
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" fails when no "sns" "subscription" "slot" was "available"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And no "sns" "subscription" "slot" was "available"
    When a "lambda" "function" subscribes to a "sns" "topic"
    Then the operation is rejected
