Feature: Cognito - User Pool Management

  Background:
    Given the cognito system is initialized

  Scenario: a "cognito" "user pool" is created
    Given the "cognito" "user pool" did not already exist
    When a "cognito" "user pool" is created
    Then the "cognito" "user pool" will exist

  Scenario: a "cognito" "user" is created in a pool
    Given a "cognito" "user pool" existed
    When a "cognito" "user" is created in the pool
    Then the "cognito" "user" will exist in the pool

  Scenario: a "cognito" "user" can authenticate
    Given a "cognito" "user pool" existed
    And a "cognito" "app client" existed
    And a "cognito" "user" existed in the pool
    When a "cognito" "user" authenticates
    Then the authentication result will contain an access token
