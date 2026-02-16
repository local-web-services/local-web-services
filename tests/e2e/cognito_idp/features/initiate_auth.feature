@cognito_idp @initiate_auth @happy @dataplane
Feature: Cognito InitiateAuth

  Scenario: Authenticate a confirmed user
    Given a user pool named "e2e-auth-pool" was created
    And a confirmed user "e2e-authuser" existed in pool "e2e-auth-pool" with password "P@ssw0rd!123"
    When I initiate auth for user "e2e-authuser" in pool "e2e-auth-pool" with password "P@ssw0rd!123"
    Then the command will succeed
    And the output will contain an AuthenticationResult
