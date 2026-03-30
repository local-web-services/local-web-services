@cognitolambda @generated
Feature: CognitoLambda - A Cognito User Pool Is Created

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @minimal @happy @create_user_pool
  Scenario: a Cognito User Pool is created
    Given the pool does not already exist
    When a Cognito User Pool is created
    Then the pool is "ACTIVE" with no pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @guard @negative @create_user_pool
  Scenario: a Cognito User Pool is created fails when the pool already exists
    Given the pool already exists
    When a Cognito User Pool is created
    Then the operation is rejected
