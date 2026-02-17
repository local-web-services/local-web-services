@mock @create @controlplane
Feature: Mock Create Server

  @happy
  Scenario: Create a new mock server
    When I create mock server "e2e-mock-create-test"
    Then the command will succeed
    And the mock server directory will exist

  @happy
  Scenario: Create a mock server with a fixed port
    When I create mock server "e2e-mock-create-port" with port 4100
    Then the command will succeed
    And the output will contain mock server "e2e-mock-create-port"
