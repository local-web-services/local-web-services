@mock @import_spec @controlplane
Feature: Mock Import Spec

  @happy
  Scenario: Delete a mock server
    Given a mock server "e2e-mock-delete-test" was created
    When I delete mock server "e2e-mock-delete-test"
    Then the command will succeed
    And mock server "e2e-mock-delete-test" will not exist
