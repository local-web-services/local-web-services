@fake @generated
Feature: Fake - The Status Of A "Fake" "Server" Is Retrieved

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @get_status
  Scenario: the status of a "fake" "server" is retrieved
    Given the "fake" "server" existed
    And the "fake" "server" was "ACTIVE"
    When the status of a "fake" "server" is retrieved
    Then the "fake" "server" name, protocol, and "route" count will be returned
    And every "ACTIVE" "route" belongs to an "ACTIVE" "fake" "server"
    And every "fake" "server" has a valid protocol

  @guard @negative @get_status
  Scenario: the status of a "fake" "server" is retrieved fails when the "fake" "server" did not exist
    Given the "fake" "server" did not exist
    When the status of a "fake" "server" is retrieved
    Then the operation is rejected

  @guard @negative @get_status
  Scenario: the status of a "fake" "server" is retrieved fails when the "fake" "server" was not "ACTIVE"
    Given the "fake" "server" existed
    And the "fake" "server" was not "ACTIVE"
    When the status of a "fake" "server" is retrieved
    Then the operation is rejected
