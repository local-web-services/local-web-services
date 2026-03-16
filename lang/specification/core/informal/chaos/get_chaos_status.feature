@chaos @generated
Feature: Chaos - The Chaos Status For All Services Is Retrieved

  # Generated from FizzBee spec: chaos.fizz
  # Safety invariants: ChaosConfigOnlyForKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @get_chaos_status
  Scenario: the chaos status for all services is retrieved
    When the chaos status for all services is retrieved
    Then the chaos configuration for each service is returned
    And every chaos-configured service is a known service
