@apigatewaycognito @generated
Feature: ApigatewayCognito - A "Cognito" "User" Is Confirmed In A "Cognito" "User Pool"

  # Generated from FizzBee spec: apigateway_cognito.fizz
  # Safety invariants: AuthorizerRequiresActivePool, AuthorizedRequestRequiresValidToken, AuthorizedRequestRequiresPoolMembership, RejectedRequestHasMismatchedPool

  Background:
    Given the system is initialized

  @minimal @happy @confirm_user
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user" did not already exist
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    Then the "cognito" "user" will be "CONFIRMED" and can authenticate
    And every "api gateway" "API" with a configured authorizer references an "ACTIVE" "cognito" "user pool"
    And every "AUTHORIZED" "api gateway" "request" was validated against a "VALID" "token"
    And every "AUTHORIZED" request's token belongs to a "cognito" "user" in the "api gateway" "API"'s configured pool
    And every "REJECTED" request's token belongs to a "cognito" "user" in a different pool than the configured authorizer

  @guard @negative @confirm_user
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" fails when the "cognito" "user pool" did not exist
    Given the "cognito" "user pool" did not exist
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    Then the operation is rejected

  @guard @negative @confirm_user @lifecycle
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" fails when the "cognito" "user pool" was not "ACTIVE"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was not "ACTIVE"
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    Then the operation is rejected

  @guard @negative @confirm_user
  Scenario: a "cognito" "user" is confirmed in a "cognito" "user pool" fails when the "cognito" "user" already existed
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user" already existed
    When a "cognito" "user" is confirmed in a "cognito" "user pool"
    Then the operation is rejected
