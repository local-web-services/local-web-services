@lambdasns @generated
Feature: LambdaSns - A "Sns" "Topic" Is Created

  # Generated from FizzBee spec: lambda_sns.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @create_topic
  Scenario: a "sns" "topic" is created
    Given the "sns" "topic" did not already exist
    When a "sns" "topic" is created
    Then the "sns" "topic" will be "ACTIVE"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And "sns" publishing requires an "ACTIVE" "sns" "topic" to be present

  @guard @negative @create_topic
  Scenario: a "sns" "topic" is created fails when the "sns" "topic" already existed
    Given the "sns" "topic" already existed
    When a "sns" "topic" is created
    Then the operation is rejected
