@fake @generated
Feature: Fake - Chaos Was "Enabled" Or Disabled For A "Fake" "Server"

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @minimal @happy @set_chaos_enabled
  Scenario: chaos was "ENABLED" or disabled for a "fake" "server"
    Given the "fake" "server" existed
    And the "fake" "server" was "ACTIVE"
    When chaos was "ENABLED" or disabled for a "fake" "server"
    Then the "fake" "server" chaos enabled flag will be updated
    And every "ACTIVE" "route" belongs to an "ACTIVE" "fake" "server"
    And every "fake" "server" has a valid protocol

  @guard @negative @set_chaos_enabled
  Scenario: chaos was "ENABLED" or disabled for a "fake" "server" fails when the "fake" "server" did not exist
    Given the "fake" "server" did not exist
    When chaos was "ENABLED" or disabled for a "fake" "server"
    Then the operation is rejected

  @guard @negative @set_chaos_enabled
  Scenario: chaos was "ENABLED" or disabled for a "fake" "server" fails when the "fake" "server" was not "ACTIVE"
    Given the "fake" "server" existed
    And the "fake" "server" was not "ACTIVE"
    When chaos was "ENABLED" or disabled for a "fake" "server"
    Then the operation is rejected
