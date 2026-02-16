@cognito_idp @delete_user_pool_client @happy @controlplane
Feature: Cognito DeleteUserPoolClient

  Scenario: Delete a user pool client
    Given a user pool named "e2e-del-upc-pool" was created
    And a user pool client named "e2e-del-client" was created in pool "e2e-del-upc-pool"
    When I delete the user pool client from pool "e2e-del-upc-pool"
    Then the command will succeed
