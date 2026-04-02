@chaos @generated
Feature: Chaos - Chaos Was "Disabled" For A Service

  # Generated from FizzBee spec: chaos.fizz
  # Safety invariants: ChaosConfigOnlyForKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @disable_chaos
  Scenario: chaos was "DISABLED" for a service
    Given chaos was "ENABLED" for the service
    When chaos was "DISABLED" for a service
    Then "chaos" will be disabled for the "service"
    And every "chaos"-configured "service" is a known "service"

  @guard @negative @disable_chaos
  Scenario: chaos was "DISABLED" for a service fails when chaos was not "ENABLED" for the service
    Given chaos was not "ENABLED" for the service
    When chaos was "DISABLED" for a service
    Then the operation is rejected
