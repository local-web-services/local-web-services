@cognitolambda @generated
Feature: CognitoLambda - A Lambda Pre-Signup Trigger Is Configured On The Cognito User Pool

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @minimal @happy @configure_trigger
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool
    Given the pool exists
    And the pool is "ACTIVE"
    And the pool has no trigger configured
    And the function exists
    And the function is "ACTIVE"
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    Then all subsequent signups will synchronously invoke the function before confirming
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @guard @negative @configure_trigger
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool fails when the pool does not exist
    Given the pool does not exist
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    Then the operation is rejected

  @guard @negative @configure_trigger @lifecycle
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool fails when the pool is not "ACTIVE"
    Given the pool exists
    And the pool is not "ACTIVE"
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    Then the operation is rejected

  @guard @negative @configure_trigger
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool fails when the pool already has a trigger configured
    Given the pool exists
    And the pool is "ACTIVE"
    And the pool already has a trigger configured
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    Then the operation is rejected

  @guard @negative @configure_trigger
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool fails when the function does not exist
    Given the pool exists
    And the pool is "ACTIVE"
    And the pool has no trigger configured
    And the function does not exist
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    Then the operation is rejected

  @guard @negative @configure_trigger @lifecycle
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool fails when the function is not "ACTIVE"
    Given the pool exists
    And the pool is "ACTIVE"
    And the pool has no trigger configured
    And the function exists
    And the function is not "ACTIVE"
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    Then the operation is rejected
