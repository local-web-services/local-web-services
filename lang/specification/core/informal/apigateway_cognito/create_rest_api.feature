@apigatewaycognito @generated
Feature: ApigatewayCognito - An "Api Gateway" "Api" Is Created

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_api
  Scenario: an "api gateway" "api" is created
    Given the "api gateway" "API" did not already exist
    When an "api gateway" "api" is created
    Then the "api gateway" "api" will be "ACTIVE" with no Cognito authorizer configured
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @guard @negative @create_rest_api
  Scenario: an "api gateway" "api" is created fails when the "api gateway" "API" already existed
    Given the "api gateway" "API" already existed
    When an "api gateway" "api" is created
    Then the operation is rejected
