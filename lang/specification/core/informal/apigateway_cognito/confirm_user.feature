@apigatewaycognito @generated
Feature: ApigatewayCognito - A User Is Confirmed In A Cognito User Pool

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @minimal @happy @confirm_user
  Scenario: a user is confirmed in a Cognito User Pool
    Given the pool exists
    And the pool is "ACTIVE"
    And the user does not already exist
    When a user is confirmed in a Cognito User Pool
    Then the user is "CONFIRMED" and can authenticate
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @standard @negative @confirm_user
  Scenario: a user is confirmed in a Cognito User Pool fails when the pool does not exist
    Given the pool does not exist
    When a user is confirmed in a Cognito User Pool
    Then the operation is rejected

  @standard @negative @confirm_user @lifecycle
  Scenario: a user is confirmed in a Cognito User Pool fails when the pool is not "ACTIVE"
    Given the pool exists
    And the pool is not "ACTIVE"
    When a user is confirmed in a Cognito User Pool
    Then the operation is rejected

  @standard @negative @confirm_user
  Scenario: a user is confirmed in a Cognito User Pool fails when the user already exists
    Given the pool exists
    And the pool is "ACTIVE"
    And the user already exists
    When a user is confirmed in a Cognito User Pool
    Then the operation is rejected
