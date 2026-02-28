@cognito_idp @admin_delete_user @happy @controlplane
Feature: Cognito AdminDeleteUser

  Scenario: Admin-delete a user from a pool
    Given a user pool named "e2e-admin-del-pool" was created
    And user "e2e-admin-del-user" was admin-created in pool "e2e-admin-del-pool"
    When I admin-delete user "e2e-admin-del-user" from pool "e2e-admin-del-pool"
    Then the command will succeed
