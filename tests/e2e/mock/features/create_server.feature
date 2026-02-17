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
    And the config will have port 4100

  @happy
  Scenario: Create a mock server with a description
    When I create mock server "e2e-mock-create-desc" with description "My test API"
    Then the command will succeed
    And the config will have description "My test API"

  @happy
  Scenario: Create a mock server defaults to rest protocol
    When I create mock server "e2e-mock-create-default-proto"
    Then the command will succeed
    And the config will have protocol "rest"

  @happy
  Scenario: Create a mock server with chaos disabled by default
    When I create mock server "e2e-mock-create-chaos"
    Then the command will succeed
    And the config will have chaos disabled

  @error
  Scenario: Create a mock server that already exists
    Given a mock server "e2e-mock-create-dup" was created
    When I create mock server "e2e-mock-create-dup"
    Then the command will fail
    And the output will contain "already exists"
