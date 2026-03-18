@chaos @generated
Feature: Chaos - The Chaos Error Rate Is Configured For A Service

  # Generated from FizzBee spec: chaos.fizz
  # Safety invariants: ChaosConfigOnlyForKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @set_error_rate
  Scenario: the chaos error rate is configured for a service
    When the chaos error rate is configured for a service
    Then the error rate configuration is updated
    And every chaos-configured service is a known service
