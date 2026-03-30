@chaos @generated
Feature: Chaos - A Service Call Is Injected With A Chaos Error

  # Generated from FizzBee spec: chaos.fizz
  # Safety invariants: ChaosConfigOnlyForKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @inject_error
  Scenario: a service call is injected with a chaos error
    Given chaos is enabled for the service
    And the error rate is set to full for the service
    When a service call is injected with a chaos error
    Then the service call receives a chaos error response
    And every chaos-configured service is a known service

  @guard @negative @inject_error
  Scenario: a service call is injected with a chaos error fails when chaos is not enabled for the service
    Given chaos is not enabled for the service
    When a service call is injected with a chaos error
    Then the operation is rejected

  @guard @negative @inject_error
  Scenario: a service call is injected with a chaos error fails when the error rate is not set to full for the service
    Given chaos is enabled for the service
    And the error rate is not set to full for the service
    When a service call is injected with a chaos error
    Then the operation is rejected
