@fake @generated
Feature: Fake - A Fake Server Is Created

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @create_server
  Scenario: a fake server is created
    Given the server does not already exist
    When a fake server is created
    Then the server is "ACTIVE" with chaos disabled by default
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @standard @negative @create_server
  Scenario: a fake server is created fails when the server already exists
    Given the server already exists
    When a fake server is created
    Then the operation is rejected
