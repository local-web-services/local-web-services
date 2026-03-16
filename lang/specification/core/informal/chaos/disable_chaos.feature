@chaos @generated
Feature: Chaos - Chaos Is Disabled For A Service

  # Generated from FizzBee spec: chaos.fizz
  # Safety invariants: ChaosConfigOnlyForKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @disable_chaos
  Scenario: chaos is disabled for a service
    Given chaos is enabled for the service
    When chaos is disabled for a service
    Then chaos is disabled for the service
    And every chaos-configured service is a known service

  @standard @negative @disable_chaos
  Scenario: chaos is disabled for a service fails when chaos is not enabled for the service
    Given chaos is not enabled for the service
    When chaos is disabled for a service
    Then the operation is rejected
