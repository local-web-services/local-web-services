@fake @generated
Feature: Fake - Chaos Is Enabled Or Disabled For A Fake Server

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @set_chaos_enabled
  Scenario: chaos is enabled or disabled for a fake server
    Given the server exists
    And the server is "ACTIVE"
    When chaos is enabled or disabled for a fake server
    Then the chaos enabled flag is updated
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @standard @negative @set_chaos_enabled
  Scenario: chaos is enabled or disabled for a fake server fails when the server does not exist
    Given the server does not exist
    When chaos is enabled or disabled for a fake server
    Then the operation is rejected

  @standard @negative @set_chaos_enabled
  Scenario: chaos is enabled or disabled for a fake server fails when the server is not "ACTIVE"
    Given the server exists
    And the server is not "ACTIVE"
    When chaos is enabled or disabled for a fake server
    Then the operation is rejected
