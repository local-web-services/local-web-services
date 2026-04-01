@fake @generated
Feature: Fake - A "Route" Is Added To A "Fake" "Server"

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @add_route
  Scenario: a "route" is added to a "fake" "server"
    Given the "fake" "server" existed
    And the "fake" "server" was "ACTIVE"
    And a "route" "slot" was "available"
    When a "route" is added to a "fake" "server"
    Then the "fake" "route" will be "ACTIVE" on the "fake" "server"
    And every "ACTIVE" "route" belongs to an "ACTIVE" "fake" "server"
    And every "fake" "server" has a valid protocol

  @guard @negative @add_route
  Scenario: a "route" is added to a "fake" "server" fails when the "fake" "server" did not exist
    Given the "fake" "server" did not exist
    When a "route" is added to a "fake" "server"
    Then the operation is rejected

  @guard @negative @add_route
  Scenario: a "route" is added to a "fake" "server" fails when the "fake" "server" was not "ACTIVE"
    Given the "fake" "server" existed
    And the "fake" "server" was not "ACTIVE"
    When a "route" is added to a "fake" "server"
    Then the operation is rejected

  @guard @negative @add_route @capacity
  Scenario: a "route" is added to a "fake" "server" fails when no "route" "slot" was "available"
    Given the "fake" "server" existed
    And the "fake" "server" was "ACTIVE"
    And no "route" "slot" was "available"
    When a "route" is added to a "fake" "server"
    Then the operation is rejected
