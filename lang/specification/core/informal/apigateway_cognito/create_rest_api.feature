@apigatewaycognito @generated
Feature: ApigatewayCognito - A Rest Api Is Created

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_api
  Scenario: a "REST" "API" is created
    Given the "API" does not already exist
    When a "REST" "API" is created
    Then the "API" is "ACTIVE" with no Cognito authorizer configured
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @guard @negative @create_rest_api
  Scenario: a "REST" "API" is created fails when the "API" already exists
    Given the "API" already exists
    When a "REST" "API" is created
    Then the operation is rejected
