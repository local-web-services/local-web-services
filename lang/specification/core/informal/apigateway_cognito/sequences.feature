@apigatewaycognito @generated
Feature: ApigatewayCognito - Action Sequences

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "api gateway" "api" is created then a "cognito" "user pool" is created
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "cognito" "user pool" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: an "api gateway" "api" is created then a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: an "api gateway" "api" is created then a "cognito" "user" is confirmed in a "cognito" "user pool"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: an "api gateway" "api" is created then Cognito issues a "JWT" token for a confirmed user
    Given aid not in api_status
    When an "api gateway" "api" is created
    When Cognito issues a "JWT" token for a confirmed user
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: an "api gateway" "api" is created then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: an "api gateway" "api" is created then a request with a valid token from a "cognito" "user" in a different pool is rejected
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" is created then an "api gateway" "api" is created
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When an "api gateway" "api" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" is confirmed in a "cognito" "user pool"
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" is created then Cognito issues a "JWT" token for a confirmed user
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When Cognito issues a "JWT" token for a confirmed user
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" is created then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" is created then a request with a valid token from a "cognito" "user" in a different pool is rejected
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then an "api gateway" "api" is created
    Given aid in api_status
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When an "api gateway" "api" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then a "cognito" "user pool" is created
    Given aid in api_status
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When a "cognito" "user pool" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then a "cognito" "user" is confirmed in a "cognito" "user pool"
    Given aid in api_status
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then Cognito issues a "JWT" token for a confirmed user
    Given aid in api_status
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When Cognito issues a "JWT" token for a confirmed user
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Given aid in api_status
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then a request with a valid token from a "cognito" "user" in a different pool is rejected
    Given aid in api_status
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" then an "api gateway" "api" is created
    Given pid in pool_status
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When an "api gateway" "api" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When a "cognito" "user pool" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" then a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Given pid in pool_status
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" then Cognito issues a "JWT" token for a confirmed user
    Given pid in pool_status
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When Cognito issues a "JWT" token for a confirmed user
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Given pid in pool_status
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" then a request with a valid token from a "cognito" "user" in a different pool is rejected
    Given pid in pool_status
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then an "api gateway" "api" is created
    Given uid in user_status
    When Cognito issues a "JWT" token for a confirmed user
    When an "api gateway" "api" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a "cognito" "user pool" is created
    Given uid in user_status
    When Cognito issues a "JWT" token for a confirmed user
    When a "cognito" "user pool" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Given uid in user_status
    When Cognito issues a "JWT" token for a confirmed user
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a "cognito" "user" is confirmed in a "cognito" "user pool"
    Given uid in user_status
    When Cognito issues a "JWT" token for a confirmed user
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Given uid in user_status
    When Cognito issues a "JWT" token for a confirmed user
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a "cognito" "user" in a different pool is rejected
    Given uid in user_status
    When Cognito issues a "JWT" token for a confirmed user
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then an "api gateway" "api" is created
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When an "api gateway" "api" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then a "cognito" "user pool" is created
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When a "cognito" "user pool" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then a "cognito" "user" is confirmed in a "cognito" "user pool"
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then Cognito issues a "JWT" token for a confirmed user
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When Cognito issues a "JWT" token for a confirmed user
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then a request with a valid token from a "cognito" "user" in a different pool is rejected
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected then an "api gateway" "api" is created
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When an "api gateway" "api" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected then a "cognito" "user pool" is created
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When a "cognito" "user pool" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected then a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected then a "cognito" "user" is confirmed in a "cognito" "user pool"
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected then Cognito issues a "JWT" token for a confirmed user
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When Cognito issues a "JWT" token for a confirmed user
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: an "api gateway" "api" is created then a "cognito" "user pool" is created then a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: an "api gateway" "api" is created then a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then a "cognito" "user" is confirmed in a "cognito" "user pool"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: an "api gateway" "api" is created then a "cognito" "user" is confirmed in a "cognito" "user pool" then Cognito issues a "JWT" token for a confirmed user
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When Cognito issues a "JWT" token for a confirmed user
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: an "api gateway" "api" is created then Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Given aid not in api_status
    When an "api gateway" "api" is created
    When Cognito issues a "JWT" token for a confirmed user
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: an "api gateway" "api" is created then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then a request with a valid token from a "cognito" "user" in a different pool is rejected
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: an "api gateway" "api" is created then a request with a valid token from a "cognito" "user" in a different pool is rejected then a "cognito" "user pool" is created
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When a "cognito" "user pool" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" is created then an "api gateway" "api" is created then a "cognito" "user" is confirmed in a "cognito" "user pool"
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When an "api gateway" "api" is created
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then Cognito issues a "JWT" token for a confirmed user
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When Cognito issues a "JWT" token for a confirmed user
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" is confirmed in a "cognito" "user pool" then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" is created then Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a "cognito" "user" in a different pool is rejected
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When Cognito issues a "JWT" token for a confirmed user
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" is created then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then an "api gateway" "api" is created
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When an "api gateway" "api" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" is created then a request with a valid token from a "cognito" "user" in a different pool is rejected then a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then an "api gateway" "api" is created then Cognito issues a "JWT" token for a confirmed user
    Given aid in api_status
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When an "api gateway" "api" is created
    When Cognito issues a "JWT" token for a confirmed user
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then a "cognito" "user pool" is created then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Given aid in api_status
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When a "cognito" "user pool" is created
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then a "cognito" "user" is confirmed in a "cognito" "user pool" then a request with a valid token from a "cognito" "user" in a different pool is rejected
    Given aid in api_status
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then Cognito issues a "JWT" token for a confirmed user then an "api gateway" "api" is created
    Given aid in api_status
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When Cognito issues a "JWT" token for a confirmed user
    When an "api gateway" "api" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then a "cognito" "user pool" is created
    Given aid in api_status
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When a "cognito" "user pool" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then a request with a valid token from a "cognito" "user" in a different pool is rejected then a "cognito" "user" is confirmed in a "cognito" "user pool"
    Given aid in api_status
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" then an "api gateway" "api" is created then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Given pid in pool_status
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When an "api gateway" "api" is created
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" then a "cognito" "user pool" is created then a request with a valid token from a "cognito" "user" in a different pool is rejected
    Given pid in pool_status
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When a "cognito" "user pool" is created
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" then a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then an "api gateway" "api" is created
    Given pid in pool_status
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When an "api gateway" "api" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" then Cognito issues a "JWT" token for a confirmed user then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When Cognito issues a "JWT" token for a confirmed user
    When a "cognito" "user pool" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Given pid in pool_status
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" then a request with a valid token from a "cognito" "user" in a different pool is rejected then Cognito issues a "JWT" token for a confirmed user
    Given pid in pool_status
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When Cognito issues a "JWT" token for a confirmed user
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then an "api gateway" "api" is created then a request with a valid token from a "cognito" "user" in a different pool is rejected
    Given uid in user_status
    When Cognito issues a "JWT" token for a confirmed user
    When an "api gateway" "api" is created
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a "cognito" "user pool" is created then an "api gateway" "api" is created
    Given uid in user_status
    When Cognito issues a "JWT" token for a confirmed user
    When a "cognito" "user pool" is created
    When an "api gateway" "api" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then a "cognito" "user pool" is created
    Given uid in user_status
    When Cognito issues a "JWT" token for a confirmed user
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When a "cognito" "user pool" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a "cognito" "user" is confirmed in a "cognito" "user pool" then a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Given uid in user_status
    When Cognito issues a "JWT" token for a confirmed user
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then a "cognito" "user" is confirmed in a "cognito" "user pool"
    Given uid in user_status
    When Cognito issues a "JWT" token for a confirmed user
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a "cognito" "user" in a different pool is rejected then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Given uid in user_status
    When Cognito issues a "JWT" token for a confirmed user
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then an "api gateway" "api" is created then a "cognito" "user pool" is created
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When an "api gateway" "api" is created
    When a "cognito" "user pool" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then a "cognito" "user pool" is created then a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then a "cognito" "user" is confirmed in a "cognito" "user pool"
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then a "cognito" "user" is confirmed in a "cognito" "user pool" then Cognito issues a "JWT" token for a confirmed user
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When Cognito issues a "JWT" token for a confirmed user
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then Cognito issues a "JWT" token for a confirmed user then a request with a valid token from a "cognito" "user" in a different pool is rejected
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When Cognito issues a "JWT" token for a confirmed user
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then a request with a valid token from a "cognito" "user" in a different pool is rejected then an "api gateway" "api" is created
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When an "api gateway" "api" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected then an "api gateway" "api" is created then a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When an "api gateway" "api" is created
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected then a "cognito" "user pool" is created then a "cognito" "user" is confirmed in a "cognito" "user pool"
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When a "cognito" "user pool" is created
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected then a "cognito" "user pool" authorizer is configured on the "api gateway" "api" then Cognito issues a "JWT" token for a confirmed user
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When a "cognito" "user pool" authorizer is configured on the "api gateway" "api"
    When Cognito issues a "JWT" token for a confirmed user
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected then a "cognito" "user" is confirmed in a "cognito" "user pool" then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected then Cognito issues a "JWT" token for a confirmed user then an "api gateway" "api" is created
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When Cognito issues a "JWT" token for a confirmed user
    When an "api gateway" "api" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @sequence
  Scenario: a request with a valid token from a "cognito" "user" in a different pool is rejected then a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized then a "cognito" "user pool" is created
    Given rid not in req_status
    When a request with a valid token from a "cognito" "user" in a different pool is rejected
    When a request with a valid token from a "cognito" "user" in the "api gateway" "API"'s configured pool is authorized
    When a "cognito" "user pool" is created
    And every "API" with a configured authorizer references an "ACTIVE" pool
    And every "AUTHORIZED" request was validated against a "VALID" token
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer
