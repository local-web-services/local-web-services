@cognito_idp @list_user_pool_clients @happy @controlplane
Feature: Cognito ListUserPoolClients

  Scenario: List user pool clients
    Given a user pool named "e2e-list-upc-pool" was created
    When I list user pool clients in pool "e2e-list-upc-pool"
    Then the command will succeed
