@fake @generated
Feature: Fake - The Status Of A Fake Server Is Retrieved

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @get_status
  Scenario: the status of a fake server is retrieved
    Given the server exists
    And the server is "ACTIVE"
    When the status of a fake server is retrieved
    Then the server name, protocol, and route count are returned
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @guard @negative @get_status
  Scenario: the status of a fake server is retrieved fails when the server does not exist
    Given the server does not exist
    When the status of a fake server is retrieved
    Then the operation is rejected

  @guard @negative @get_status
  Scenario: the status of a fake server is retrieved fails when the server is not "ACTIVE"
    Given the server exists
    And the server is not "ACTIVE"
    When the status of a fake server is retrieved
    Then the operation is rejected
