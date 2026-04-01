@fake @generated
Feature: Fake - A "Route" Is Removed From A "Fake" "Server"

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @remove_route
  Scenario: a "route" is removed from a "fake" "server"
    Given the "fake" "route" existed
    And the "fake" "route" was "ACTIVE"
    When a "route" is removed from a "fake" "server"
    Then the "fake" "route" will be deleted
    And every "ACTIVE" "route" belongs to an "ACTIVE" "fake" "server"
    And every "fake" "server" has a valid protocol

  @guard @negative @remove_route
  Scenario: a "route" is removed from a "fake" "server" fails when the "fake" "route" did not exist
    Given the "fake" "route" did not exist
    When a "route" is removed from a "fake" "server"
    Then the operation is rejected

  @guard @negative @remove_route
  Scenario: a "route" is removed from a "fake" "server" fails when the "fake" "route" was not "ACTIVE"
    Given the "fake" "route" existed
    And the "fake" "route" was not "ACTIVE"
    When a "route" is removed from a "fake" "server"
    Then the operation is rejected
