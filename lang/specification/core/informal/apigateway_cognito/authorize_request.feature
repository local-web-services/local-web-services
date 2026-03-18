@apigatewaycognito @generated
Feature: ApigatewayCognito - A Request With A Valid Token From A User In The Api'S Configured Pool Is Authorized

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @minimal @happy @authorize_request
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Cognito authorizer configured
    And a "VALID" token exists
    And the token belongs to a "CONFIRMED" user in the "API"'s configured pool
    And a request slot is available
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then the request is "AUTHORIZED" and routed to the backend
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @standard @negative @authorize_request
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized fails when the "API" does not exist
    Given the "API" does not exist
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then the operation is rejected

  @standard @negative @authorize_request @lifecycle
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized fails when the "API" is not "ACTIVE"
    Given the "API" exists
    And the "API" is not "ACTIVE"
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then the operation is rejected

  @standard @negative @authorize_request
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized fails when the "API" has no Cognito authorizer configured
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no Cognito authorizer configured
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then the operation is rejected

  @standard @negative @authorize_request @lifecycle
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized fails when no "VALID" token exists
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Cognito authorizer configured
    And no "VALID" token exists
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then the operation is rejected

  @standard @negative @authorize_request @lifecycle
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized fails when the token does not belong to a "CONFIRMED" user in the configured pool
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Cognito authorizer configured
    And a "VALID" token exists
    And the token does not belong to a "CONFIRMED" user in the configured pool
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then the operation is rejected

  @standard @negative @authorize_request @capacity
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized fails when no request slot is available
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Cognito authorizer configured
    And a "VALID" token exists
    And the token belongs to a "CONFIRMED" user in the "API"'s configured pool
    And no request slot is available
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then the operation is rejected
