@snslambda @generated
Feature: SnsLambda - A Lambda Function Subscribes To An Sns Topic

  # Generated from FizzBee spec: sns_lambda.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, InvocationRequiresActiveFunction, InvocationRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @subscribe_function_to_topic
  Scenario: a Lambda function subscribes to an "SNS" topic
    Given the topic exists
    And the topic is "ACTIVE"
    And the function exists
    And the function is "ACTIVE"
    And the subscription slot is available
    When a Lambda function subscribes to an "SNS" topic
    Then the subscription is "CONFIRMED" and the function will be invoked on published messages
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @standard @negative @subscribe_function_to_topic
  Scenario: a Lambda function subscribes to an "SNS" topic fails when the topic does not exist
    Given the topic does not exist
    When a Lambda function subscribes to an "SNS" topic
    Then the operation is rejected

  @standard @negative @subscribe_function_to_topic @lifecycle
  Scenario: a Lambda function subscribes to an "SNS" topic fails when the topic is not "ACTIVE"
    Given the topic exists
    And the topic is not "ACTIVE"
    When a Lambda function subscribes to an "SNS" topic
    Then the operation is rejected

  @standard @negative @subscribe_function_to_topic
  Scenario: a Lambda function subscribes to an "SNS" topic fails when the function does not exist
    Given the topic exists
    And the topic is "ACTIVE"
    And the function does not exist
    When a Lambda function subscribes to an "SNS" topic
    Then the operation is rejected

  @standard @negative @subscribe_function_to_topic @lifecycle
  Scenario: a Lambda function subscribes to an "SNS" topic fails when the function is not "ACTIVE"
    Given the topic exists
    And the topic is "ACTIVE"
    And the function exists
    And the function is not "ACTIVE"
    When a Lambda function subscribes to an "SNS" topic
    Then the operation is rejected

  @standard @negative @subscribe_function_to_topic @capacity
  Scenario: a Lambda function subscribes to an "SNS" topic fails when the subscription slot is not available
    Given the topic exists
    And the topic is "ACTIVE"
    And the function exists
    And the function is "ACTIVE"
    And the subscription slot is not available
    When a Lambda function subscribes to an "SNS" topic
    Then the operation is rejected
