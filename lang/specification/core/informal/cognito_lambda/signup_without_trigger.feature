@cognitolambda @generated
Feature: CognitoLambda - A User Signs Up To A Pool That Has No Pre-Signup Trigger Configured

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @minimal @happy @signup_without_trigger
  Scenario: a user signs up to a pool that has no pre-signup trigger configured
    Given the pool exists
    And the pool is "ACTIVE"
    And the pool has no pre-signup trigger configured
    And the user slot is available
    When a user signs up to a pool that has no pre-signup trigger configured
    Then the user is immediately "CONFIRMED"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @guard @negative @signup_without_trigger
  Scenario: a user signs up to a pool that has no pre-signup trigger configured fails when the pool does not exist
    Given the pool does not exist
    When a user signs up to a pool that has no pre-signup trigger configured
    Then the operation is rejected

  @guard @negative @signup_without_trigger @lifecycle
  Scenario: a user signs up to a pool that has no pre-signup trigger configured fails when the pool is not "ACTIVE"
    Given the pool exists
    And the pool is not "ACTIVE"
    When a user signs up to a pool that has no pre-signup trigger configured
    Then the operation is rejected

  @guard @negative @signup_without_trigger
  Scenario: a user signs up to a pool that has no pre-signup trigger configured fails when the pool has a pre-signup trigger configured
    Given the pool exists
    And the pool is "ACTIVE"
    And the pool has a pre-signup trigger configured
    When a user signs up to a pool that has no pre-signup trigger configured
    Then the operation is rejected

  @guard @negative @internal @signup_without_trigger @capacity
  Scenario: a user signs up to a pool that has no pre-signup trigger configured fails when no user slot is available
    Given the pool exists
    And the pool is "ACTIVE"
    And the pool has no pre-signup trigger configured
    And no user slot is available
    When a user signs up to a pool that has no pre-signup trigger configured
    Then the operation is rejected
