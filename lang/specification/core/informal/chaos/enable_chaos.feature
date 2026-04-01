@chaos @generated
Feature: Chaos - Chaos Was "Enabled" For A Service

  # Generated from FizzBee spec: chaos.fizz
  # Safety invariants: ChaosConfigOnlyForKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @enable_chaos
  Scenario: chaos was "ENABLED" for a service
    When chaos was "ENABLED" for a service
    Then "chaos" will be enabled for the "service"
    And every "chaos"-configured "service" is a known "service"
