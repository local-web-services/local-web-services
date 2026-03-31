@fake @generated
Feature: Fake - A Fake Server Is Deleted

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @delete_server
  Scenario: a fake server is deleted
    Given the server existed
    And the server was "ACTIVE"
    When a fake server is deleted
    Then the server will be deleted and its routes will be removed
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @guard @negative @delete_server
  Scenario: a fake server is deleted fails when the server did not exist
    Given the server did not exist
    When a fake server is deleted
    Then the operation is rejected

  @guard @negative @delete_server
  Scenario: a fake server is deleted fails when the server was not "ACTIVE"
    Given the server existed
    And the server was not "ACTIVE"
    When a fake server is deleted
    Then the operation is rejected
