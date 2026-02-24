@cognito_idp @sign_up @happy @dataplane
Feature: Cognito SignUp

  Scenario: Sign up a new user
    Given a user pool named "e2e-signup-pool" was created
    When I sign up user "testuser" in pool "e2e-signup-pool" with password "P@ssw0rd!123"
    Then the command will succeed
    And the output will contain a UserConfirmed field
