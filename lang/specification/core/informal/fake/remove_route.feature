@fake @generated
Feature: Fake - A Route Is Removed From A Fake Server

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @remove_route
  Scenario: a route is removed from a fake server
    Given the route exists
    And the route is "ACTIVE"
    When a route is removed from a fake server
    Then the route is "DELETED"
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @standard @negative @remove_route
  Scenario: a route is removed from a fake server fails when the route does not exist
    Given the route does not exist
    When a route is removed from a fake server
    Then the operation is rejected

  @standard @negative @remove_route
  Scenario: a route is removed from a fake server fails when the route is not "ACTIVE"
    Given the route exists
    And the route is not "ACTIVE"
    When a route is removed from a fake server
    Then the operation is rejected
