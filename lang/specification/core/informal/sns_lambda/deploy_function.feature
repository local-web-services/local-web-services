@snslambda @generated
Feature: SnsLambda - A Lambda Function Is Deployed

  # Generated from FizzBee spec: sns_lambda.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, InvocationRequiresActiveFunction, InvocationRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @deploy_function
  Scenario: a Lambda function is deployed
    Given the function does not already exist
    When a Lambda function is deployed
    Then the function is "ACTIVE"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @guard @negative @deploy_function
  Scenario: a Lambda function is deployed fails when the function already exists
    Given the function already exists
    When a Lambda function is deployed
    Then the operation is rejected
