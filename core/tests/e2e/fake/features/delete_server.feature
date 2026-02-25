@fake @delete @controlplane
Feature: Fake Delete Server

  @happy
  Scenario: Delete a fake server
    Given a fake server "e2e-fake-delete-test" was created
    When I delete fake server "e2e-fake-delete-test"
    Then the command will succeed
    And fake server "e2e-fake-delete-test" will not exist

  @error
  Scenario: Delete a fake server that does not exist
    When I delete fake server "e2e-fake-delete-nonexistent"
    Then the command will fail
    And the output will contain "not found"
