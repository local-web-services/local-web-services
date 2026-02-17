@mock @list @controlplane
Feature: Mock List Servers

  @happy
  Scenario: List mock servers when none exist
    When I list mock servers
    Then the command will succeed
    And the output will show 0 servers

  @happy
  Scenario: List mock servers after creating one
    Given a mock server "e2e-mock-list-single" was created
    When I list mock servers
    Then the command will succeed
    And the output will contain mock server "e2e-mock-list-single"
    And the output will show 1 server(s)

  @happy
  Scenario: List mock servers after creating multiple
    Given a mock server "e2e-mock-list-alpha" was created
    And a mock server "e2e-mock-list-beta" was created
    When I list mock servers
    Then the command will succeed
    And the output will show 2 server(s)
    And the output will contain mock server "e2e-mock-list-alpha"
    And the output will contain mock server "e2e-mock-list-beta"
