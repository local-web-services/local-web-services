@mock @delete @controlplane
Feature: Mock Delete Server

  @happy
  Scenario: Delete a mock server
    Given a mock server "e2e-mock-delete-test" was created
    When I delete mock server "e2e-mock-delete-test"
    Then the command will succeed
    And mock server "e2e-mock-delete-test" will not exist

  @error
  Scenario: Delete a mock server that does not exist
    When I delete mock server "e2e-mock-delete-nonexistent"
    Then the command will fail
    And the output will contain "not found"
