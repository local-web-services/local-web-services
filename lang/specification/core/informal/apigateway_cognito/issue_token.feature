@apigatewaycognito @generated
Feature: ApigatewayCognito - A "Cognito" "User" Receives A "Valid" "Jwt" Token From The "Cognito" "User Pool"

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @minimal @happy @issue_token
  Scenario: a "cognito" "user" receives a "VALID" "JWT" token from the "cognito" "user pool"
    Given the "cognito" "user" existed
    And the "cognito" "user" was "CONFIRMED"
    And a "cognito" "token" "slot" was "available"
    When a "cognito" "user" receives a "VALID" "JWT" token from the "cognito" "user pool"
    Then a "VALID" token will be issued that can be presented to "API" Gateway for authorization
    And every "api gateway" "API" with a configured authorizer references an "ACTIVE" "cognito" "user pool"
    And every "AUTHORIZED" "api gateway" "request" was validated against a "VALID" "token"
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @guard @negative @issue_token
  Scenario: a "cognito" "user" receives a "VALID" "JWT" token from the "cognito" "user pool" fails when the "cognito" "user" did not exist
    Given the "cognito" "user" did not exist
    When a "cognito" "user" receives a "VALID" "JWT" token from the "cognito" "user pool"
    Then the operation is rejected

  @guard @negative @issue_token @lifecycle
  Scenario: a "cognito" "user" receives a "VALID" "JWT" token from the "cognito" "user pool" fails when the "cognito" "user" was not "CONFIRMED"
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "CONFIRMED"
    When a "cognito" "user" receives a "VALID" "JWT" token from the "cognito" "user pool"
    Then the operation is rejected

  @guard @negative @issue_token @capacity
  Scenario: a "cognito" "user" receives a "VALID" "JWT" token from the "cognito" "user pool" fails when no "cognito" "token" "slot" was "available"
    Given the "cognito" "user" existed
    And the "cognito" "user" was "CONFIRMED"
    And no "cognito" "token" "slot" was "available"
    When a "cognito" "user" receives a "VALID" "JWT" token from the "cognito" "user pool"
    Then the operation is rejected
