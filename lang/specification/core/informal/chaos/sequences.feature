@chaos @generated
Feature: Chaos - Action Sequences

  # Generated from FizzBee spec: chaos.fizz
  # Safety invariants: ChaosConfigOnlyForKnownServices

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then chaos is disabled for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then the chaos error rate is configured for a service
    When chaos is enabled for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then the chaos latency is configured for a service
    When chaos is enabled for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then the chaos status for all services is retrieved
    When chaos is enabled for a service
    When the chaos status for all services is retrieved
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then a service call is injected with a chaos error
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then chaos is enabled for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then the chaos status for all services is retrieved
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos status for all services is retrieved
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then a service call is injected with a chaos error
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then a service call is delayed by chaos latency injection
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then chaos is enabled for a service
    When the chaos error rate is configured for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then chaos is disabled for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then the chaos status for all services is retrieved
    When the chaos error rate is configured for a service
    When the chaos status for all services is retrieved
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then chaos is enabled for a service
    When the chaos latency is configured for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then chaos is disabled for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then the chaos status for all services is retrieved
    When the chaos latency is configured for a service
    When the chaos status for all services is retrieved
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then a service call is injected with a chaos error
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos status for all services is retrieved then chaos is enabled for a service
    When the chaos status for all services is retrieved
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos status for all services is retrieved then chaos is disabled for a service
    When the chaos status for all services is retrieved
    Given svc in chaos_enabled
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos status for all services is retrieved then the chaos error rate is configured for a service
    When the chaos status for all services is retrieved
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos status for all services is retrieved then the chaos latency is configured for a service
    When the chaos status for all services is retrieved
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos status for all services is retrieved then a service call is injected with a chaos error
    When the chaos status for all services is retrieved
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos status for all services is retrieved then a service call is delayed by chaos latency injection
    When the chaos status for all services is retrieved
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then chaos is disabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then the chaos status for all services is retrieved
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos status for all services is retrieved
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then a service call is delayed by chaos latency injection
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then chaos is disabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then the chaos status for all services is retrieved
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos status for all services is retrieved
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then a service call is injected with a chaos error
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then chaos is disabled for a service then the chaos error rate is configured for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then chaos is disabled for a service then the chaos latency is configured for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then chaos is disabled for a service then a service call is injected with a chaos error
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then chaos is disabled for a service then a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then the chaos error rate is configured for a service then chaos is disabled for a service
    When chaos is enabled for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then the chaos error rate is configured for a service then the chaos latency is configured for a service
    When chaos is enabled for a service
    When the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then the chaos error rate is configured for a service then a service call is injected with a chaos error
    When chaos is enabled for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then the chaos error rate is configured for a service then a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then the chaos latency is configured for a service then chaos is disabled for a service
    When chaos is enabled for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then the chaos latency is configured for a service then the chaos error rate is configured for a service
    When chaos is enabled for a service
    When the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then the chaos latency is configured for a service then a service call is injected with a chaos error
    When chaos is enabled for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then the chaos latency is configured for a service then a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then a service call is injected with a chaos error then chaos is disabled for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then a service call is injected with a chaos error then the chaos error rate is configured for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then a service call is injected with a chaos error then the chaos latency is configured for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then a service call is injected with a chaos error then a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then a service call is delayed by chaos latency injection then chaos is disabled for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then a service call is delayed by chaos latency injection then the chaos error rate is configured for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then a service call is delayed by chaos latency injection then the chaos latency is configured for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is enabled for a service then a service call is delayed by chaos latency injection then a service call is injected with a chaos error
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then chaos is enabled for a service then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When chaos is enabled for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then chaos is enabled for a service then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When chaos is enabled for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then chaos is enabled for a service then a service call is injected with a chaos error
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When chaos is enabled for a service
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then chaos is enabled for a service then a service call is delayed by chaos latency injection
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When chaos is enabled for a service
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then the chaos error rate is configured for a service then chaos is enabled for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos error rate is configured for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then the chaos error rate is configured for a service then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then the chaos error rate is configured for a service then a service call is injected with a chaos error
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos error rate is configured for a service
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then the chaos error rate is configured for a service then a service call is delayed by chaos latency injection
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos error rate is configured for a service
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then the chaos latency is configured for a service then chaos is enabled for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos latency is configured for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then the chaos latency is configured for a service then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then the chaos latency is configured for a service then a service call is injected with a chaos error
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos latency is configured for a service
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then the chaos latency is configured for a service then a service call is delayed by chaos latency injection
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos latency is configured for a service
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then a service call is injected with a chaos error then chaos is enabled for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is injected with a chaos error
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then a service call is injected with a chaos error then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then a service call is injected with a chaos error then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is injected with a chaos error
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then a service call is injected with a chaos error then a service call is delayed by chaos latency injection
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is injected with a chaos error
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then a service call is delayed by chaos latency injection then chaos is enabled for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then a service call is delayed by chaos latency injection then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then a service call is delayed by chaos latency injection then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: chaos is disabled for a service then a service call is delayed by chaos latency injection then a service call is injected with a chaos error
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is delayed by chaos latency injection
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then chaos is enabled for a service then chaos is disabled for a service
    When the chaos error rate is configured for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then chaos is enabled for a service then the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    When chaos is enabled for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then chaos is enabled for a service then a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then chaos is enabled for a service then a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then chaos is disabled for a service then chaos is enabled for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then chaos is disabled for a service then the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then chaos is disabled for a service then a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then chaos is disabled for a service then a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then the chaos latency is configured for a service then chaos is enabled for a service
    When the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then the chaos latency is configured for a service then chaos is disabled for a service
    When the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then the chaos latency is configured for a service then a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then the chaos latency is configured for a service then a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then a service call is injected with a chaos error then chaos is enabled for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then a service call is injected with a chaos error then chaos is disabled for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then a service call is injected with a chaos error then the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then a service call is injected with a chaos error then a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then a service call is delayed by chaos latency injection then chaos is enabled for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then a service call is delayed by chaos latency injection then chaos is disabled for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then a service call is delayed by chaos latency injection then the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos error rate is configured for a service then a service call is delayed by chaos latency injection then a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then chaos is enabled for a service then chaos is disabled for a service
    When the chaos latency is configured for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then chaos is enabled for a service then the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    When chaos is enabled for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then chaos is enabled for a service then a service call is injected with a chaos error
    When the chaos latency is configured for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then chaos is enabled for a service then a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    When chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then chaos is disabled for a service then chaos is enabled for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then chaos is disabled for a service then the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then chaos is disabled for a service then a service call is injected with a chaos error
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then chaos is disabled for a service then a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then the chaos error rate is configured for a service then chaos is enabled for a service
    When the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then the chaos error rate is configured for a service then chaos is disabled for a service
    When the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then the chaos error rate is configured for a service then a service call is injected with a chaos error
    When the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then the chaos error rate is configured for a service then a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then a service call is injected with a chaos error then chaos is enabled for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then a service call is injected with a chaos error then chaos is disabled for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then a service call is injected with a chaos error then the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then a service call is injected with a chaos error then a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then a service call is delayed by chaos latency injection then chaos is enabled for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then a service call is delayed by chaos latency injection then chaos is disabled for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then a service call is delayed by chaos latency injection then the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: the chaos latency is configured for a service then a service call is delayed by chaos latency injection then a service call is injected with a chaos error
    When the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then chaos is enabled for a service then chaos is disabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is enabled for a service
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then chaos is enabled for a service then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is enabled for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then chaos is enabled for a service then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is enabled for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then chaos is enabled for a service then a service call is delayed by chaos latency injection
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is enabled for a service
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then chaos is disabled for a service then chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is disabled for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then chaos is disabled for a service then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is disabled for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then chaos is disabled for a service then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is disabled for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then chaos is disabled for a service then a service call is delayed by chaos latency injection
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When chaos is disabled for a service
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then the chaos error rate is configured for a service then chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then the chaos error rate is configured for a service then chaos is disabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then the chaos error rate is configured for a service then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then the chaos error rate is configured for a service then a service call is delayed by chaos latency injection
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then the chaos latency is configured for a service then chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos latency is configured for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then the chaos latency is configured for a service then chaos is disabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos latency is configured for a service
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then the chaos latency is configured for a service then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then the chaos latency is configured for a service then a service call is delayed by chaos latency injection
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When the chaos latency is configured for a service
    When a service call is delayed by chaos latency injection
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then a service call is delayed by chaos latency injection then chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then a service call is delayed by chaos latency injection then chaos is disabled for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When a service call is delayed by chaos latency injection
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then a service call is delayed by chaos latency injection then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is injected with a chaos error then a service call is delayed by chaos latency injection then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is injected with a chaos error
    When a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then chaos is enabled for a service then chaos is disabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then chaos is enabled for a service then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then chaos is enabled for a service then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then chaos is enabled for a service then a service call is injected with a chaos error
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is enabled for a service
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then chaos is disabled for a service then chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is disabled for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then chaos is disabled for a service then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is disabled for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then chaos is disabled for a service then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is disabled for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then chaos is disabled for a service then a service call is injected with a chaos error
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When chaos is disabled for a service
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then the chaos error rate is configured for a service then chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then the chaos error rate is configured for a service then chaos is disabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then the chaos error rate is configured for a service then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then the chaos error rate is configured for a service then a service call is injected with a chaos error
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos error rate is configured for a service
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then the chaos latency is configured for a service then chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then the chaos latency is configured for a service then chaos is disabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then the chaos latency is configured for a service then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then the chaos latency is configured for a service then a service call is injected with a chaos error
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When the chaos latency is configured for a service
    When a service call is injected with a chaos error
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then a service call is injected with a chaos error then chaos is enabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When a service call is injected with a chaos error
    When chaos is enabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then a service call is injected with a chaos error then chaos is disabled for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When a service call is injected with a chaos error
    When chaos is disabled for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then a service call is injected with a chaos error then the chaos error rate is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When a service call is injected with a chaos error
    When the chaos error rate is configured for a service
    And every chaos-configured service is a known service

  @exhaustive @sequence
  Scenario: a service call is delayed by chaos latency injection then a service call is injected with a chaos error then the chaos latency is configured for a service
    Given svc in chaos_enabled
    When a service call is delayed by chaos latency injection
    When a service call is injected with a chaos error
    When the chaos latency is configured for a service
    And every chaos-configured service is a known service
