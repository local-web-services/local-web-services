@cognito_idp @global_sign_out @happy @dataplane
Feature: Cognito GlobalSignOut

  Scenario: Global sign out with access token
    Given a user pool named "e2e-signout-pool" was created
    And an authenticated user "e2e-signout-user" existed in pool "e2e-signout-pool" with password "P@ssw0rd!123"
    When I global-sign-out using the access token
    Then the command will succeed
