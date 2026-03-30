@apigatewaycognito @generated
Feature: ApigatewayCognito - A Cognito User Pool Authorizer Is Configured On The Rest Api

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @minimal @happy @configure_authorizer
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API"
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no authorizer configured
    And the pool exists
    And the pool is "ACTIVE"
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then the "API" will validate "JWT" tokens against the configured pool before routing requests
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @guard @negative @configure_authorizer
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" fails when the "API" does not exist
    Given the "API" does not exist
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then the operation is rejected

  @guard @negative @configure_authorizer @lifecycle
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" fails when the "API" is not "ACTIVE"
    Given the "API" exists
    And the "API" is not "ACTIVE"
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then the operation is rejected

  @guard @negative @configure_authorizer
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" fails when the "API" already has an authorizer configured
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" already has an authorizer configured
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then the operation is rejected

  @guard @negative @configure_authorizer
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" fails when the pool does not exist
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no authorizer configured
    And the pool does not exist
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then the operation is rejected

  @guard @negative @configure_authorizer @lifecycle
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" fails when the pool is not "ACTIVE"
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no authorizer configured
    And the pool exists
    And the pool is not "ACTIVE"
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then the operation is rejected
