@apigatewaycognito @generated
Feature: ApigatewayCognito - Action Sequences

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "REST" "API" is created then a Cognito User Pool is created
    Given aid not in api_status
    Given a "REST" "API" has been created
    When a Cognito User Pool is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a "REST" "API" is created then a Cognito User Pool authorizer is configured on the "REST" "API"
    Given aid not in api_status
    Given a "REST" "API" has been created
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a "REST" "API" is created then a user is confirmed in a Cognito User Pool
    Given aid not in api_status
    Given a "REST" "API" has been created
    When a user is confirmed in a Cognito User Pool
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a "REST" "API" is created then Cognito issues a "JWT" token for a confirmed user
    Given aid not in api_status
    Given a "REST" "API" has been created
    When Cognito issues a "JWT" token for a confirmed user
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a "REST" "API" is created then a request with a valid token from a user in the "API"'s configured pool is authorized
    Given aid not in api_status
    Given a "REST" "API" has been created
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a "REST" "API" is created then a request with a valid token from a user in a different pool is rejected
    Given aid not in api_status
    Given a "REST" "API" has been created
    When a request with a valid token from a user in a different pool is rejected
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool is created then a "REST" "API" is created
    Given pid not in pool_status
    Given a Cognito User Pool has been created
    When a "REST" "API" is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool is created then a Cognito User Pool authorizer is configured on the "REST" "API"
    Given pid not in pool_status
    Given a Cognito User Pool has been created
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool is created then a user is confirmed in a Cognito User Pool
    Given pid not in pool_status
    Given a Cognito User Pool has been created
    When a user is confirmed in a Cognito User Pool
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool is created then Cognito issues a "JWT" token for a confirmed user
    Given pid not in pool_status
    Given a Cognito User Pool has been created
    When Cognito issues a "JWT" token for a confirmed user
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool is created then a request with a valid token from a user in the "API"'s configured pool is authorized
    Given pid not in pool_status
    Given a Cognito User Pool has been created
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool is created then a request with a valid token from a user in a different pool is rejected
    Given pid not in pool_status
    Given a Cognito User Pool has been created
    When a request with a valid token from a user in a different pool is rejected
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" then a "REST" "API" is created
    Given aid in api_status
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    When a "REST" "API" is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" then a Cognito User Pool is created
    Given aid in api_status
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    When a Cognito User Pool is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" then a user is confirmed in a Cognito User Pool
    Given aid in api_status
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    When a user is confirmed in a Cognito User Pool
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" then Cognito issues a "JWT" token for a confirmed user
    Given aid in api_status
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    When Cognito issues a "JWT" token for a confirmed user
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" then a request with a valid token from a user in the "API"'s configured pool is authorized
    Given aid in api_status
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" then a request with a valid token from a user in a different pool is rejected
    Given aid in api_status
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    When a request with a valid token from a user in a different pool is rejected
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a user is confirmed in a Cognito User Pool then a "REST" "API" is created
    Given pid in pool_status
    Given a user has been confirmed in a Cognito User Pool
    When a "REST" "API" is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a user is confirmed in a Cognito User Pool then a Cognito User Pool is created
    Given pid in pool_status
    Given a user has been confirmed in a Cognito User Pool
    When a Cognito User Pool is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a user is confirmed in a Cognito User Pool then a Cognito User Pool authorizer is configured on the "REST" "API"
    Given pid in pool_status
    Given a user has been confirmed in a Cognito User Pool
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a user is confirmed in a Cognito User Pool then Cognito issues a "JWT" token for a confirmed user
    Given pid in pool_status
    Given a user has been confirmed in a Cognito User Pool
    When Cognito issues a "JWT" token for a confirmed user
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a user is confirmed in a Cognito User Pool then a request with a valid token from a user in the "API"'s configured pool is authorized
    Given pid in pool_status
    Given a user has been confirmed in a Cognito User Pool
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a user is confirmed in a Cognito User Pool then a request with a valid token from a user in a different pool is rejected
    Given pid in pool_status
    Given a user has been confirmed in a Cognito User Pool
    When a request with a valid token from a user in a different pool is rejected
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a "REST" "API" is created
    Given uid in user_status
    Given Cognito has issued a "JWT" token for a confirmed user
    When a "REST" "API" is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a Cognito User Pool is created
    Given uid in user_status
    Given Cognito has issued a "JWT" token for a confirmed user
    When a Cognito User Pool is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a Cognito User Pool authorizer is configured on the "REST" "API"
    Given uid in user_status
    Given Cognito has issued a "JWT" token for a confirmed user
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a user is confirmed in a Cognito User Pool
    Given uid in user_status
    Given Cognito has issued a "JWT" token for a confirmed user
    When a user is confirmed in a Cognito User Pool
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a user in the "API"'s configured pool is authorized
    Given uid in user_status
    Given Cognito has issued a "JWT" token for a confirmed user
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a user in a different pool is rejected
    Given uid in user_status
    Given Cognito has issued a "JWT" token for a confirmed user
    When a request with a valid token from a user in a different pool is rejected
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized then a "REST" "API" is created
    Given rid not in req_status
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    When a "REST" "API" is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized then a Cognito User Pool is created
    Given rid not in req_status
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    When a Cognito User Pool is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized then a Cognito User Pool authorizer is configured on the "REST" "API"
    Given rid not in req_status
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized then a user is confirmed in a Cognito User Pool
    Given rid not in req_status
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    When a user is confirmed in a Cognito User Pool
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized then Cognito issues a "JWT" token for a confirmed user
    Given rid not in req_status
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    When Cognito issues a "JWT" token for a confirmed user
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized then a request with a valid token from a user in a different pool is rejected
    Given rid not in req_status
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    When a request with a valid token from a user in a different pool is rejected
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in a different pool is rejected then a "REST" "API" is created
    Given rid not in req_status
    Given a request with a valid token from a user in a different pool has been rejected
    When a "REST" "API" is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in a different pool is rejected then a Cognito User Pool is created
    Given rid not in req_status
    Given a request with a valid token from a user in a different pool has been rejected
    When a Cognito User Pool is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in a different pool is rejected then a Cognito User Pool authorizer is configured on the "REST" "API"
    Given rid not in req_status
    Given a request with a valid token from a user in a different pool has been rejected
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in a different pool is rejected then a user is confirmed in a Cognito User Pool
    Given rid not in req_status
    Given a request with a valid token from a user in a different pool has been rejected
    When a user is confirmed in a Cognito User Pool
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in a different pool is rejected then Cognito issues a "JWT" token for a confirmed user
    Given rid not in req_status
    Given a request with a valid token from a user in a different pool has been rejected
    When Cognito issues a "JWT" token for a confirmed user
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in a different pool is rejected then a request with a valid token from a user in the "API"'s configured pool is authorized
    Given rid not in req_status
    Given a request with a valid token from a user in a different pool has been rejected
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a "REST" "API" is created then a Cognito User Pool is created then a Cognito User Pool authorizer is configured on the "REST" "API"
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given a Cognito User Pool has been created
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a "REST" "API" is created then a Cognito User Pool authorizer is configured on the "REST" "API" then a user is confirmed in a Cognito User Pool
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    When a user is confirmed in a Cognito User Pool
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a "REST" "API" is created then a user is confirmed in a Cognito User Pool then Cognito issues a "JWT" token for a confirmed user
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given a user has been confirmed in a Cognito User Pool
    When Cognito issues a "JWT" token for a confirmed user
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a "REST" "API" is created then Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a user in the "API"'s configured pool is authorized
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given Cognito has issued a "JWT" token for a confirmed user
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a "REST" "API" is created then a request with a valid token from a user in the "API"'s configured pool is authorized then a request with a valid token from a user in a different pool is rejected
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    When a request with a valid token from a user in a different pool is rejected
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a "REST" "API" is created then a request with a valid token from a user in a different pool is rejected then a Cognito User Pool is created
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given a request with a valid token from a user in a different pool has been rejected
    When a Cognito User Pool is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool is created then a "REST" "API" is created then a user is confirmed in a Cognito User Pool
    Given pid not in pool_status
    Given a Cognito User Pool has been created
    Given a "REST" "API" has been created
    When a user is confirmed in a Cognito User Pool
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool is created then a Cognito User Pool authorizer is configured on the "REST" "API" then Cognito issues a "JWT" token for a confirmed user
    Given pid not in pool_status
    Given a Cognito User Pool has been created
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    When Cognito issues a "JWT" token for a confirmed user
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool is created then a user is confirmed in a Cognito User Pool then a request with a valid token from a user in the "API"'s configured pool is authorized
    Given pid not in pool_status
    Given a Cognito User Pool has been created
    Given a user has been confirmed in a Cognito User Pool
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool is created then Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a user in a different pool is rejected
    Given pid not in pool_status
    Given a Cognito User Pool has been created
    Given Cognito has issued a "JWT" token for a confirmed user
    When a request with a valid token from a user in a different pool is rejected
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool is created then a request with a valid token from a user in the "API"'s configured pool is authorized then a "REST" "API" is created
    Given pid not in pool_status
    Given a Cognito User Pool has been created
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    When a "REST" "API" is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool is created then a request with a valid token from a user in a different pool is rejected then a Cognito User Pool authorizer is configured on the "REST" "API"
    Given pid not in pool_status
    Given a Cognito User Pool has been created
    Given a request with a valid token from a user in a different pool has been rejected
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" then a "REST" "API" is created then Cognito issues a "JWT" token for a confirmed user
    Given aid in api_status
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    Given a "REST" "API" has been created
    When Cognito issues a "JWT" token for a confirmed user
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" then a Cognito User Pool is created then a request with a valid token from a user in the "API"'s configured pool is authorized
    Given aid in api_status
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    Given a Cognito User Pool has been created
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" then a user is confirmed in a Cognito User Pool then a request with a valid token from a user in a different pool is rejected
    Given aid in api_status
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    Given a user has been confirmed in a Cognito User Pool
    When a request with a valid token from a user in a different pool is rejected
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" then Cognito issues a "JWT" token for a confirmed user then a "REST" "API" is created
    Given aid in api_status
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    Given Cognito has issued a "JWT" token for a confirmed user
    When a "REST" "API" is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" then a request with a valid token from a user in the "API"'s configured pool is authorized then a Cognito User Pool is created
    Given aid in api_status
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    When a Cognito User Pool is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a Cognito User Pool authorizer is configured on the "REST" "API" then a request with a valid token from a user in a different pool is rejected then a user is confirmed in a Cognito User Pool
    Given aid in api_status
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    Given a request with a valid token from a user in a different pool has been rejected
    When a user is confirmed in a Cognito User Pool
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a user is confirmed in a Cognito User Pool then a "REST" "API" is created then a request with a valid token from a user in the "API"'s configured pool is authorized
    Given pid in pool_status
    Given a user has been confirmed in a Cognito User Pool
    Given a "REST" "API" has been created
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a user is confirmed in a Cognito User Pool then a Cognito User Pool is created then a request with a valid token from a user in a different pool is rejected
    Given pid in pool_status
    Given a user has been confirmed in a Cognito User Pool
    Given a Cognito User Pool has been created
    When a request with a valid token from a user in a different pool is rejected
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a user is confirmed in a Cognito User Pool then a Cognito User Pool authorizer is configured on the "REST" "API" then a "REST" "API" is created
    Given pid in pool_status
    Given a user has been confirmed in a Cognito User Pool
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    When a "REST" "API" is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a user is confirmed in a Cognito User Pool then Cognito issues a "JWT" token for a confirmed user then a Cognito User Pool is created
    Given pid in pool_status
    Given a user has been confirmed in a Cognito User Pool
    Given Cognito has issued a "JWT" token for a confirmed user
    When a Cognito User Pool is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a user is confirmed in a Cognito User Pool then a request with a valid token from a user in the "API"'s configured pool is authorized then a Cognito User Pool authorizer is configured on the "REST" "API"
    Given pid in pool_status
    Given a user has been confirmed in a Cognito User Pool
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a user is confirmed in a Cognito User Pool then a request with a valid token from a user in a different pool is rejected then Cognito issues a "JWT" token for a confirmed user
    Given pid in pool_status
    Given a user has been confirmed in a Cognito User Pool
    Given a request with a valid token from a user in a different pool has been rejected
    When Cognito issues a "JWT" token for a confirmed user
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a "REST" "API" is created then a request with a valid token from a user in a different pool is rejected
    Given uid in user_status
    Given Cognito has issued a "JWT" token for a confirmed user
    Given a "REST" "API" has been created
    When a request with a valid token from a user in a different pool is rejected
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a Cognito User Pool is created then a "REST" "API" is created
    Given uid in user_status
    Given Cognito has issued a "JWT" token for a confirmed user
    Given a Cognito User Pool has been created
    When a "REST" "API" is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a Cognito User Pool authorizer is configured on the "REST" "API" then a Cognito User Pool is created
    Given uid in user_status
    Given Cognito has issued a "JWT" token for a confirmed user
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    When a Cognito User Pool is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a user is confirmed in a Cognito User Pool then a Cognito User Pool authorizer is configured on the "REST" "API"
    Given uid in user_status
    Given Cognito has issued a "JWT" token for a confirmed user
    Given a user has been confirmed in a Cognito User Pool
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a user in the "API"'s configured pool is authorized then a user is confirmed in a Cognito User Pool
    Given uid in user_status
    Given Cognito has issued a "JWT" token for a confirmed user
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    When a user is confirmed in a Cognito User Pool
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a user in a different pool is rejected then a request with a valid token from a user in the "API"'s configured pool is authorized
    Given uid in user_status
    Given Cognito has issued a "JWT" token for a confirmed user
    Given a request with a valid token from a user in a different pool has been rejected
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized then a "REST" "API" is created then a Cognito User Pool is created
    Given rid not in req_status
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    Given a "REST" "API" has been created
    When a Cognito User Pool is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized then a Cognito User Pool is created then a Cognito User Pool authorizer is configured on the "REST" "API"
    Given rid not in req_status
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    Given a Cognito User Pool has been created
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized then a Cognito User Pool authorizer is configured on the "REST" "API" then a user is confirmed in a Cognito User Pool
    Given rid not in req_status
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    When a user is confirmed in a Cognito User Pool
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized then a user is confirmed in a Cognito User Pool then Cognito issues a "JWT" token for a confirmed user
    Given rid not in req_status
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    Given a user has been confirmed in a Cognito User Pool
    When Cognito issues a "JWT" token for a confirmed user
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized then Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a user in a different pool is rejected
    Given rid not in req_status
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    Given Cognito has issued a "JWT" token for a confirmed user
    When a request with a valid token from a user in a different pool is rejected
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in the "API"'s configured pool is authorized then a request with a valid token from a user in a different pool is rejected then a "REST" "API" is created
    Given rid not in req_status
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    Given a request with a valid token from a user in a different pool has been rejected
    When a "REST" "API" is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in a different pool is rejected then a "REST" "API" is created then a Cognito User Pool authorizer is configured on the "REST" "API"
    Given rid not in req_status
    Given a request with a valid token from a user in a different pool has been rejected
    Given a "REST" "API" has been created
    When a Cognito User Pool authorizer is configured on the "REST" "API"
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in a different pool is rejected then a Cognito User Pool is created then a user is confirmed in a Cognito User Pool
    Given rid not in req_status
    Given a request with a valid token from a user in a different pool has been rejected
    Given a Cognito User Pool has been created
    When a user is confirmed in a Cognito User Pool
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in a different pool is rejected then a Cognito User Pool authorizer is configured on the "REST" "API" then Cognito issues a "JWT" token for a confirmed user
    Given rid not in req_status
    Given a request with a valid token from a user in a different pool has been rejected
    Given a Cognito User Pool authorizer has been configured on the "REST" "API"
    When Cognito issues a "JWT" token for a confirmed user
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in a different pool is rejected then a user is confirmed in a Cognito User Pool then a request with a valid token from a user in the "API"'s configured pool is authorized
    Given rid not in req_status
    Given a request with a valid token from a user in a different pool has been rejected
    Given a user has been confirmed in a Cognito User Pool
    When a request with a valid token from a user in the "API"'s configured pool is authorized
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in a different pool is rejected then Cognito issues a "JWT" token for a confirmed user then a "REST" "API" is created
    Given rid not in req_status
    Given a request with a valid token from a user in a different pool has been rejected
    Given Cognito has issued a "JWT" token for a confirmed user
    When a "REST" "API" is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a user in a different pool is rejected then a request with a valid token from a user in the "API"'s configured pool is authorized then a Cognito User Pool is created
    Given rid not in req_status
    Given a request with a valid token from a user in a different pool has been rejected
    Given a request with a valid token from a user in the "API"'s configured pool has been authorized
    When a Cognito User Pool is created
    Then every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool
    And every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer
