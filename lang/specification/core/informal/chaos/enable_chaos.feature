@chaos @generated
Feature: Chaos - Chaos Is Enabled For A Service

  # Generated from FizzBee spec: chaos.fizz
  # Safety invariants: ChaosConfigOnlyForKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @enable_chaos
  Scenario: chaos is enabled for a service
    When chaos is enabled for a service
    Then chaos is enabled for the service
    And every chaos-configured service is a known service
