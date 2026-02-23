@cognito_idp @confirm_sign_up @happy @dataplane
Feature: Cognito ConfirmSignUp

  Scenario: Confirm a signed-up user
    Given a user pool named "e2e-confirm-pool" was created
    And user "e2e-confirmuser" was signed up in pool "e2e-confirm-pool" with password "P@ssw0rd!123"
    When I confirm sign-up for user "e2e-confirmuser" in pool "e2e-confirm-pool"
    Then the command will succeed
