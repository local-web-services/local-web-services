@fake @create @controlplane
Feature: Fake Create Server

  @happy
  Scenario: Create a new fake server
    When I create fake server "e2e-fake-create-test"
    Then the command will succeed
    And the fake server directory will exist

  @happy
  Scenario: Create a fake server with a fixed port
    When I create fake server "e2e-fake-create-port" with port 4100
    Then the command will succeed
    And the output will contain fake server "e2e-fake-create-port"
    And the config will have port 4100

  @happy
  Scenario: Create a fake server with a description
    When I create fake server "e2e-fake-create-desc" with description "My test API"
    Then the command will succeed
    And the config will have description "My test API"

  @happy
  Scenario: Create a fake server defaults to rest protocol
    When I create fake server "e2e-fake-create-default-proto"
    Then the command will succeed
    And the config will have protocol "rest"

  @happy
  Scenario: Create a fake server with chaos disabled by default
    When I create fake server "e2e-fake-create-chaos"
    Then the command will succeed
    And the config will have chaos disabled

  @error
  Scenario: Create a fake server that already exists
    Given a fake server "e2e-fake-create-dup" was created
    When I create fake server "e2e-fake-create-dup"
    Then the command will fail
    And the output will contain "already exists"
