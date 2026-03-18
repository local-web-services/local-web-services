@apigatewaycognito @generated
Feature: ApigatewayCognito - A Cognito User Pool Is Created

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @minimal @happy @create_user_pool
  Scenario: a Cognito User Pool is created
    Given the pool does not already exist
    When a Cognito User Pool is created
    Then the pool is "ACTIVE"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @standard @negative @create_user_pool
  Scenario: a Cognito User Pool is created fails when the pool already exists
    Given the pool already exists
    When a Cognito User Pool is created
    Then the operation is rejected
