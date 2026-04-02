@fake @generated
Feature: Fake - A "Fake" "Server" Is Deleted

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @delete_server
  Scenario: a "fake" "server" is deleted
    Given the "fake" "server" existed
    And the "fake" "server" was "ACTIVE"
    When a "fake" "server" is deleted
    Then the "fake" "server" will be deleted and its "route"s will be removed
    And every "ACTIVE" "route" belongs to an "ACTIVE" "fake" "server"
    And every "fake" "server" has a valid protocol

  @guard @negative @delete_server
  Scenario: a "fake" "server" is deleted fails when the "fake" "server" did not exist
    Given the "fake" "server" did not exist
    When a "fake" "server" is deleted
    Then the operation is rejected

  @guard @negative @delete_server
  Scenario: a "fake" "server" is deleted fails when the "fake" "server" was not "ACTIVE"
    Given the "fake" "server" existed
    And the "fake" "server" was not "ACTIVE"
    When a "fake" "server" is deleted
    Then the operation is rejected
