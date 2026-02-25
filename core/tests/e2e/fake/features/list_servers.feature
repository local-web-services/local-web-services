@fake @list @controlplane
Feature: Fake List Servers

  @happy
  Scenario: List fake servers when none exist
    When I list fake servers
    Then the command will succeed
    And the output will show 0 servers

  @happy
  Scenario: List fake servers after creating one
    Given a fake server "e2e-fake-list-single" was created
    When I list fake servers
    Then the command will succeed
    And the output will contain fake server "e2e-fake-list-single"
    And the output will show 1 server(s)

  @happy
  Scenario: List fake servers after creating multiple
    Given a fake server "e2e-fake-list-alpha" was created
    And a fake server "e2e-fake-list-beta" was created
    When I list fake servers
    Then the command will succeed
    And the output will show 2 server(s)
    And the output will contain fake server "e2e-fake-list-alpha"
    And the output will contain fake server "e2e-fake-list-beta"
