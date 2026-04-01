@apigatewaycognito @generated
Feature: ApigatewayCognito - A Request With A Valid Token From A "Cognito" "User" In The "Api Gateway" "Api"'S Configured Pool Is Authorized

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @minimal @happy @authorize_request
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Cognito authorizer configured
    And a "VALID" token existed
    And the token belongs to a "CONFIRMED" user in the "api gateway" "API"'s configured pool
    And a request slot is available
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Then the request will be "AUTHORIZED" and routed to the backend
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @guard @negative @authorize_request
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized fails when the "api gateway" "API" did not exist
    Given the "api gateway" "API" did not exist
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Then the operation is rejected

  @guard @negative @authorize_request @lifecycle
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was not "ACTIVE"
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Then the operation is rejected

  @guard @negative @authorize_request
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized fails when the "api gateway" "api" has no Cognito authorizer configured
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no Cognito authorizer configured
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Then the operation is rejected

  @guard @negative @authorize_request @lifecycle
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized fails when no "VALID" token existed
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Cognito authorizer configured
    And no "VALID" token existed
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Then the operation is rejected

  @guard @negative @authorize_request @lifecycle
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized fails when the token does not belong to a "CONFIRMED" user in the configured pool
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Cognito authorizer configured
    And a "VALID" token existed
    And the token does not belong to a "CONFIRMED" user in the configured pool
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Then the operation is rejected

  @guard @negative @authorize_request @capacity
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized fails when no request slot is available
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Cognito authorizer configured
    And a "VALID" token existed
    And the token belongs to a "CONFIRMED" user in the "api gateway" "API"'s configured pool
    And no request slot is available
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Then the operation is rejected
