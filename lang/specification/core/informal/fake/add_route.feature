@fake @generated
Feature: Fake - A Route Is Added To A Fake Server

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @add_route
  Scenario: a route is added to a fake server
    Given the server exists
    And the server is "ACTIVE"
    And a route slot is available
    When a route is added to a fake server
    Then the route is "ACTIVE" on the server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @guard @negative @add_route
  Scenario: a route is added to a fake server fails when the server does not exist
    Given the server does not exist
    When a route is added to a fake server
    Then the operation is rejected

  @guard @negative @add_route
  Scenario: a route is added to a fake server fails when the server is not "ACTIVE"
    Given the server exists
    And the server is not "ACTIVE"
    When a route is added to a fake server
    Then the operation is rejected

  @guard @negative @internal @add_route
  Scenario: a route is added to a fake server fails when no route slot is available
    Given the server exists
    And the server is "ACTIVE"
    And no route slot is available
    When a route is added to a fake server
    Then the operation is rejected
