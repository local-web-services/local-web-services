@fake @generated
Feature: Fake - Chaos Was "Enabled" Or Disabled For A Fake Server

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @set_chaos_enabled
  Scenario: chaos was "ENABLED" or disabled for a fake server
    Given the server existed
    And the server was "ACTIVE"
    When chaos was "ENABLED" or disabled for a fake server
    Then the chaos enabled flag will be updated
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @guard @negative @set_chaos_enabled
  Scenario: chaos was "ENABLED" or disabled for a fake server fails when the server did not exist
    Given the server did not exist
    When chaos was "ENABLED" or disabled for a fake server
    Then the operation is rejected

  @guard @negative @set_chaos_enabled
  Scenario: chaos was "ENABLED" or disabled for a fake server fails when the server was not "ACTIVE"
    Given the server existed
    And the server was not "ACTIVE"
    When chaos was "ENABLED" or disabled for a fake server
    Then the operation is rejected
