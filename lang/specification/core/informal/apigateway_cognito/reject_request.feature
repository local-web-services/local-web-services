@apigatewaycognito @generated
Feature: ApigatewayCognito - A Request With A Valid Token From A "Cognito" "User" In A Different Pool Is Rejected

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @minimal @happy @reject_request
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Cognito authorizer configured
    And a "VALID" token existed from a "cognito" "user" in a different pool than the configured authorizer
    And a request slot is available
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    Then the request will be rejected because the token's issuing pool does not match the configured authorizer
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @guard @negative @reject_request
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected fails when the "api gateway" "API" did not exist
    Given the "api gateway" "API" did not exist
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    Then the operation is rejected

  @guard @negative @reject_request @lifecycle
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was not "ACTIVE"
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    Then the operation is rejected

  @guard @negative @reject_request
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected fails when the "api gateway" "api" has no Cognito authorizer configured
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no Cognito authorizer configured
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    Then the operation is rejected

  @guard @negative @reject_request @lifecycle
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected fails when no such mismatched token existed
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Cognito authorizer configured
    And no such mismatched token existed
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    Then the operation is rejected

  @guard @negative @reject_request @capacity
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected fails when no request slot is available
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Cognito authorizer configured
    And a "VALID" token existed from a "cognito" "user" in a different pool than the configured authorizer
    And no request slot is available
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    Then the operation is rejected
