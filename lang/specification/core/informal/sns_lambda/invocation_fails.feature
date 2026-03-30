@snslambda @generated
Feature: SnsLambda - The Lambda Invocation Fails

  # Generated from FizzBee spec: sns_lambda.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, InvocationRequiresActiveFunction, InvocationRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the Lambda invocation fails
    Given an invocation is "IN_PROGRESS"
    When the Lambda invocation fails
    Then the invocation is "FAILED"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @guard @negative @invocation_fails @internal
  Scenario: the Lambda invocation fails fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda invocation fails
    Then the operation is rejected
