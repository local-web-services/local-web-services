@cognitolambda @generated
Feature: CognitoLambda - A Lambda Pre-Signup Trigger Is Configured On The "Cognito" "User Pool"

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @minimal @happy @configure_trigger
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user pool" has no trigger configured
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Then all subsequent signups will synchronously invoke the function before confirming
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @guard @negative @configure_trigger
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" fails when the "cognito" "user pool" did not exist
    Given the "cognito" "user pool" did not exist
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Then the operation is rejected

  @guard @negative @configure_trigger @lifecycle
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" fails when the "cognito" "user pool" was not "ACTIVE"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was not "ACTIVE"
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Then the operation is rejected

  @guard @negative @configure_trigger
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" fails when the "cognito" "user pool" already has a trigger configured
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user pool" already has a trigger configured
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Then the operation is rejected

  @guard @negative @configure_trigger
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" fails when the "lambda" "function" did not exist
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user pool" has no trigger configured
    And the "lambda" "function" did not exist
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Then the operation is rejected

  @guard @negative @configure_trigger @lifecycle
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" fails when the "lambda" "function" was not "ACTIVE"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user pool" has no trigger configured
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Then the operation is rejected
