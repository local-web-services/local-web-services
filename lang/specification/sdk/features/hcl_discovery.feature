@sdk @hcl_discovery
Feature: HCL resource discovery

  @happy
  Scenario: Session started from HCL directory has declared resources available
    When I create a session from the "terraform" HCL directory
    Then the session is running
    And the resources declared in the HCL are available
