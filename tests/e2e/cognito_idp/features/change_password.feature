@cognito_idp @change_password @happy @dataplane
Feature: Cognito ChangePassword

  Scenario: Change password via access token
    Given a user pool named "e2e-change-pw-pool" was created
    And an authenticated user "e2e-change-pw-user" existed in pool "e2e-change-pw-pool" with password "P@ssw0rd!123"
    When I change password from "P@ssw0rd!123" to "N3wP@ssw0rd!" using the access token
    Then the command will succeed
    And user "e2e-change-pw-user" will authenticate in pool "e2e-change-pw-pool" with password "N3wP@ssw0rd!"
