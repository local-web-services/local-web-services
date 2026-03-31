@cognitolambda @generated
Feature: CognitoLambda - A "Cognito" "User" Initiates Signup To A "Cognito" "User Pool" That Has A Pre-Signup Trigger Configured

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @minimal @happy @initiate_signup_with_trigger
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user pool" has a pre-signup trigger configured
    And the trigger function was "ACTIVE"
    And the "cognito" "user" slot is available
    And a "lambda" "invocation" slot is available
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Then the "cognito" "user" will be "PENDING" and the trigger Lambda will be invoked synchronously
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @guard @negative @initiate_signup_with_trigger
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured fails when the "cognito" "user pool" did not exist
    Given the "cognito" "user pool" did not exist
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Then the operation is rejected

  @guard @negative @initiate_signup_with_trigger @lifecycle
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured fails when the "cognito" "user pool" was not "ACTIVE"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was not "ACTIVE"
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Then the operation is rejected

  @guard @negative @initiate_signup_with_trigger
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured fails when the "cognito" "user pool" has no pre-signup trigger configured
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user pool" has no pre-signup trigger configured
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Then the operation is rejected

  @guard @negative @initiate_signup_with_trigger @lifecycle
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured fails when the trigger function was not "ACTIVE"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user pool" has a pre-signup trigger configured
    And the trigger function was not "ACTIVE"
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Then the operation is rejected

  @guard @negative @initiate_signup_with_trigger @capacity
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured fails when no user slot is available
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user pool" has a pre-signup trigger configured
    And the trigger function was "ACTIVE"
    And no user slot is available
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Then the operation is rejected

  @guard @negative @initiate_signup_with_trigger @capacity
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured fails when no invocation slot is available
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user pool" has a pre-signup trigger configured
    And the trigger function was "ACTIVE"
    And the "cognito" "user" slot is available
    And no invocation slot is available
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Then the operation is rejected
