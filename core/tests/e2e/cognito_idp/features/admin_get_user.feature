@cognito_idp @admin_get_user @happy @controlplane
Feature: Cognito AdminGetUser

  Scenario: Admin-get a confirmed user
    Given a user pool named "e2e-admin-get-pool" was created
    And a confirmed user "e2e-admin-get-user" existed in pool "e2e-admin-get-pool" with password "P@ssw0rd!123"
    When I admin-get user "e2e-admin-get-user" from pool "e2e-admin-get-pool"
    Then the command will succeed
