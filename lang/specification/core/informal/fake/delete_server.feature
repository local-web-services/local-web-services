@fake @generated
Feature: Fake - A Fake Server Is Deleted

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @delete_server
  Scenario: a fake server is deleted
    Given the server exists
    And the server is "ACTIVE"
    When a fake server is deleted
    Then the server is "DELETED" and its routes are removed
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @standard @negative @delete_server
  Scenario: a fake server is deleted fails when the server does not exist
    Given the server does not exist
    When a fake server is deleted
    Then the operation is rejected

  @standard @negative @delete_server
  Scenario: a fake server is deleted fails when the server is not "ACTIVE"
    Given the server exists
    And the server is not "ACTIVE"
    When a fake server is deleted
    Then the operation is rejected
