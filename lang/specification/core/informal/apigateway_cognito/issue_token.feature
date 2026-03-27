@apigatewaycognito @generated
Feature: ApigatewayCognito - Cognito Issues A Jwt Token For A Confirmed User

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @minimal @happy @issue_token
  Scenario: Cognito issues a "JWT" token for a confirmed user
    Given the user exists
    And the user is "CONFIRMED"
    And a token slot is available
    When Cognito issues a "JWT" token for a confirmed user
    Then a "VALID" token is issued that can be presented to "API" Gateway for authorization
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @standard @negative @issue_token
  Scenario: Cognito issues a "JWT" token for a confirmed user fails when the user does not exist
    Given the user does not exist
    When Cognito issues a "JWT" token for a confirmed user
    Then the operation is rejected

  @standard @negative @issue_token @lifecycle
  Scenario: Cognito issues a "JWT" token for a confirmed user fails when the user is not "CONFIRMED"
    Given the user exists
    And the user is not "CONFIRMED"
    When Cognito issues a "JWT" token for a confirmed user
    Then the operation is rejected

  @standard @negative @internal @issue_token @capacity
  Scenario: Cognito issues a "JWT" token for a confirmed user fails when no token slot is available
    Given the user exists
    And the user is "CONFIRMED"
    And no token slot is available
    When Cognito issues a "JWT" token for a confirmed user
    Then the operation is rejected
