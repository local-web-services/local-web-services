@chaos @generated
Feature: Chaos - A Service Call Is Delayed By Chaos Latency Injection

  # Generated from FizzBee spec: chaos.fizz
  # Safety invariants: ChaosConfigOnlyForKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @inject_latency
  Scenario: a service call is delayed by chaos latency injection
    Given chaos is enabled for the service
    And latency is configured for the service
    When a service call is delayed by chaos latency injection
    Then the service call takes at least the configured minimum latency
    And every chaos-configured service is a known service

  @guard @negative @inject_latency
  Scenario: a service call is delayed by chaos latency injection fails when chaos is not enabled for the service
    Given chaos is not enabled for the service
    When a service call is delayed by chaos latency injection
    Then the operation is rejected

  @guard @negative @inject_latency
  Scenario: a service call is delayed by chaos latency injection fails when latency is not configured for the service
    Given chaos is enabled for the service
    And latency is not configured for the service
    When a service call is delayed by chaos latency injection
    Then the operation is rejected
