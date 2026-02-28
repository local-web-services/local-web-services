@glacier @create_vault @controlplane
Feature: Glacier CreateVault

  @happy
  Scenario: Create a new vault
    When I create vault "e2e-create-vault"
    Then the command will succeed
    And vault "e2e-create-vault" will exist

  @happy
  Scenario: Create vault is idempotent
    Given a vault "e2e-idempotent-vault" was created
    When I create vault "e2e-idempotent-vault"
    Then the command will succeed
