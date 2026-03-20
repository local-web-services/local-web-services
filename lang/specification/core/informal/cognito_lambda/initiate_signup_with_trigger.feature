@cognitolambda @generated
Feature: CognitoLambda - A User Initiates Signup To A Pool That Has A Pre-Signup Trigger Configured

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @minimal @happy @initiate_signup_with_trigger
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured
    Given the pool exists
    And the pool is "ACTIVE"
    And the pool has a pre-signup trigger configured
    And the trigger function is "ACTIVE"
    And the user slot is available
    And an invocation slot is available
    When a user initiates signup to a pool that has a pre-signup trigger configured
    Then the user is "PENDING" and the trigger Lambda is invoked synchronously
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @standard @negative @initiate_signup_with_trigger
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured fails when the pool does not exist
    Given the pool does not exist
    When a user initiates signup to a pool that has a pre-signup trigger configured
    Then the operation is rejected

  @standard @negative @initiate_signup_with_trigger @lifecycle
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured fails when the pool is not "ACTIVE"
    Given the pool exists
    And the pool is not "ACTIVE"
    When a user initiates signup to a pool that has a pre-signup trigger configured
    Then the operation is rejected

  @standard @negative @initiate_signup_with_trigger
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured fails when the pool has no pre-signup trigger configured
    Given the pool exists
    And the pool is "ACTIVE"
    And the pool has no pre-signup trigger configured
    When a user initiates signup to a pool that has a pre-signup trigger configured
    Then the operation is rejected

  @standard @negative @initiate_signup_with_trigger @lifecycle
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured fails when the trigger function is not "ACTIVE"
    Given the pool exists
    And the pool is "ACTIVE"
    And the pool has a pre-signup trigger configured
    And the trigger function is not "ACTIVE"
    When a user initiates signup to a pool that has a pre-signup trigger configured
    Then the operation is rejected

  @standard @negative @initiate_signup_with_trigger @capacity
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured fails when no user slot is available
    Given the pool exists
    And the pool is "ACTIVE"
    And the pool has a pre-signup trigger configured
    And the trigger function is "ACTIVE"
    And no user slot is available
    When a user initiates signup to a pool that has a pre-signup trigger configured
    Then the operation is rejected

  @standard @negative @initiate_signup_with_trigger @capacity
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured fails when no invocation slot is available
    Given the pool exists
    And the pool is "ACTIVE"
    And the pool has a pre-signup trigger configured
    And the trigger function is "ACTIVE"
    And the user slot is available
    And no invocation slot is available
    When a user initiates signup to a pool that has a pre-signup trigger configured
    Then the operation is rejected
