@cognitolambda @generated
Feature: CognitoLambda - A "Cognito" "User" Signs Up To A "Cognito" "User Pool" That Has No Pre-Signup Trigger Configured

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @minimal @happy @signup_without_trigger
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user pool" has no pre-signup trigger configured
    And the "cognito" "user" slot is available
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Then the cognito user will be immediately "CONFIRMED"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @guard @negative @signup_without_trigger
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured fails when the "cognito" "user pool" did not exist
    Given the "cognito" "user pool" did not exist
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Then the operation is rejected

  @guard @negative @signup_without_trigger @lifecycle
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured fails when the "cognito" "user pool" was not "ACTIVE"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was not "ACTIVE"
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Then the operation is rejected

  @guard @negative @signup_without_trigger
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured fails when the "cognito" "user pool" has a pre-signup trigger configured
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user pool" has a pre-signup trigger configured
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Then the operation is rejected

  @guard @negative @signup_without_trigger @capacity
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured fails when no user slot is available
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user pool" has no pre-signup trigger configured
    And no user slot is available
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Then the operation is rejected
