@apigatewaycognito @generated
Feature: ApigatewayCognito - A Request With A Valid Token From A User In A Different Pool Is Rejected

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @minimal @happy @reject_request
  Scenario: a request with a valid token from a user in a different pool is rejected
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Cognito authorizer configured
    And a "VALID" token exists from a user in a different pool than the configured authorizer
    And a request slot is available
    When a request with a valid token from a user in a different pool is rejected
    Then the request is "REJECTED" because the token's issuing pool does not match the configured authorizer
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @standard @negative @reject_request
  Scenario: a request with a valid token from a user in a different pool is rejected fails when the "API" does not exist
    Given the "API" does not exist
    When a request with a valid token from a user in a different pool is rejected
    Then the operation is rejected

  @standard @negative @reject_request @lifecycle
  Scenario: a request with a valid token from a user in a different pool is rejected fails when the "API" is not "ACTIVE"
    Given the "API" exists
    And the "API" is not "ACTIVE"
    When a request with a valid token from a user in a different pool is rejected
    Then the operation is rejected

  @standard @negative @reject_request
  Scenario: a request with a valid token from a user in a different pool is rejected fails when the "API" has no Cognito authorizer configured
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no Cognito authorizer configured
    When a request with a valid token from a user in a different pool is rejected
    Then the operation is rejected

  @standard @negative @reject_request @lifecycle
  Scenario: a request with a valid token from a user in a different pool is rejected fails when no such mismatched token exists
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Cognito authorizer configured
    And no such mismatched token exists
    When a request with a valid token from a user in a different pool is rejected
    Then the operation is rejected

  @standard @negative @internal @reject_request @capacity
  Scenario: a request with a valid token from a user in a different pool is rejected fails when no request slot is available
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Cognito authorizer configured
    And a "VALID" token exists from a user in a different pool than the configured authorizer
    And no request slot is available
    When a request with a valid token from a user in a different pool is rejected
    Then the operation is rejected
