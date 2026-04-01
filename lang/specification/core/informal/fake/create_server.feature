@fake @generated
Feature: Fake - A "Fake" "Server" Is Created

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @create_server
  Scenario: a "fake" "server" is created
    Given the "fake" "server" did not already exist
    When a "fake" "server" is created
    Then the "fake" "server" will be "ACTIVE" with chaos disabled by default
    And every "ACTIVE" "route" belongs to an "ACTIVE" "fake" "server"
    And every "fake" "server" has a valid protocol

  @guard @negative @create_server
  Scenario: a "fake" "server" is created fails when the "fake" "server" already existed
    Given the "fake" "server" already existed
    When a "fake" "server" is created
    Then the operation is rejected
