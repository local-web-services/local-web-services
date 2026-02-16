@cognito_idp @forgot_password @happy @dataplane
Feature: Cognito ForgotPassword

  Scenario: Initiate forgot password and confirm with bad code
    Given a user pool named "e2e-forgot-pw-pool" was created
    And a confirmed user "e2e-forgot-user" existed in pool "e2e-forgot-pw-pool" with password "P@ssw0rd!123"
    When I initiate forgot-password for user "e2e-forgot-user" in pool "e2e-forgot-pw-pool"
    Then the command will succeed
    And the output will contain CodeDeliveryDetails
    When I confirm forgot-password for user "e2e-forgot-user" in pool "e2e-forgot-pw-pool" with code "000000" and password "N3wP@ssw0rd!"
    Then the command will succeed
    And the output will contain a CodeMismatchException error
