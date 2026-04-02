@chaos @generated
Feature: Chaos - A "Service" Call Is Delayed By "Chaos" "Latency" Injection

  # Generated from FizzBee spec: chaos.fizz
  # Safety invariants: ChaosConfigOnlyForKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @inject_latency
  Scenario: a "service" call is delayed by "chaos" "latency" injection
    Given chaos was "ENABLED" for the service
    And "chaos" "latency" is configured for the "service"
    When a "service" call is delayed by "chaos" "latency" injection
    Then the "service" call takes at least the configured minimum "chaos" "latency"
    And every "chaos"-configured "service" is a known "service"

  @guard @negative @inject_latency
  Scenario: a "service" call is delayed by "chaos" "latency" injection fails when chaos was not "ENABLED" for the service
    Given chaos was not "ENABLED" for the service
    When a "service" call is delayed by "chaos" "latency" injection
    Then the operation is rejected

  @guard @negative @inject_latency
  Scenario: a "service" call is delayed by "chaos" "latency" injection fails when "chaos" "latency" is not configured for the "service"
    Given chaos was "ENABLED" for the service
    And "chaos" "latency" is not configured for the "service"
    When a "service" call is delayed by "chaos" "latency" injection
    Then the operation is rejected
