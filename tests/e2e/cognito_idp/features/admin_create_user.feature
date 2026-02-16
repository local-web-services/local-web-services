@cognito_idp @admin_create_user @happy @controlplane
Feature: Cognito AdminCreateUser

  Scenario: Admin-create a user in a pool
    Given a user pool named "e2e-admin-create-pool" was created
    When I admin-create user "e2e-admin-user" in pool "e2e-admin-create-pool"
    Then the command will succeed
