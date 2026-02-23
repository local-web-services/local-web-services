@glacier @list_vaults @controlplane
Feature: Glacier ListVaults

  @happy
  Scenario: List vaults includes a created vault
    Given a vault "e2e-list-vaults" was created
    When I list vaults
    Then the command will succeed
    And the vault list will include "e2e-list-vaults"
