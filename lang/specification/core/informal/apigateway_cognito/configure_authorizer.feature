@apigatewaycognito @generated
Feature: ApigatewayCognito - A "Cognito" "User Pool" Authorizer Is Configured On The "Api Gateway" "Api"

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @minimal @happy @configure_authorizer
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no authorizer configured
    And the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Then the "api gateway" "API" will validate "JWT" tokens against the configured pool before routing requests
    And every "api gateway" "API" with a configured authorizer references an "ACTIVE" "cognito" "user pool"
    And every "AUTHORIZED" "api gateway" "request" was validated against a "VALID" "token"
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @guard @negative @configure_authorizer
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" fails when the "api gateway" "API" did not exist
    Given the "api gateway" "API" did not exist
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_authorizer @lifecycle
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was not "ACTIVE"
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_authorizer
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" fails when the "api gateway" "API" already has an authorizer configured
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" already has an authorizer configured
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_authorizer
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" fails when the "cognito" "user pool" did not exist
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no authorizer configured
    And the "cognito" "user pool" did not exist
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_authorizer @lifecycle
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" fails when the "cognito" "user pool" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no authorizer configured
    And the "cognito" "user pool" existed
    And the "cognito" "user pool" was not "ACTIVE"
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Then the operation is rejected
