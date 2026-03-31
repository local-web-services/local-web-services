@fake @generated
Feature: Fake - A Route Is Removed From A Fake Server

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @remove_route
  Scenario: a route is removed from a fake server
    Given the route existed
    And the route was "ACTIVE"
    When a route is removed from a fake server
    Then the route will be deleted
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @guard @negative @remove_route
  Scenario: a route is removed from a fake server fails when the route did not exist
    Given the route did not exist
    When a route is removed from a fake server
    Then the operation is rejected

  @guard @negative @remove_route
  Scenario: a route is removed from a fake server fails when the route was not "ACTIVE"
    Given the route existed
    And the route was not "ACTIVE"
    When a route is removed from a fake server
    Then the operation is rejected
