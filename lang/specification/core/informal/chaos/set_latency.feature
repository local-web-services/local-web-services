@chaos @generated
Feature: Chaos - The "Chaos" "Latency" Is Configured For A "Service"

  # Generated from FizzBee spec: chaos.fizz
  # Safety invariants: ChaosConfigOnlyForKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @set_latency
  Scenario: the "chaos" "latency" is configured for a "service"
    When the "chaos" "latency" is configured for a "service"
    Then the "chaos" "latency" configuration will be updated
    And every "chaos"-configured "service" is a known "service"
