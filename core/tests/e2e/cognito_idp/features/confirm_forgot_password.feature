@cognito_idp @confirm_forgot_password @happy @dataplane
Feature: Cognito ConfirmForgotPassword

  Scenario: Confirm forgot password with bad code returns error
    Given a user pool named "e2e-cfp-pool" was created
    And a confirmed user "e2e-cfp-user" existed in pool "e2e-cfp-pool" with password "P@ssw0rd!123"
    When I confirm forgot-password for user "e2e-cfp-user" in pool "e2e-cfp-pool" with code "000000" and password "N3wP@ss!456"
    Then the command will succeed
    And the output will contain a CodeMismatchException error
