@secretsmanagerevents @generated
Feature: SecretsmanagerEvents - A Secret Rotation Occurs And Secrets Manager Delivers A Rotated Event To The Bus

  # Generated from FizzBee spec: secretsmanager_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingSecret, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @rotate_secret_event_delivered @internal
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given the secret exists and is "ACTIVE"
    And the bus is "ACTIVE"
    And an event slot is available
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Then the secret is "ACTIVE" with a new version and the "ROTATED" event is "DELIVERED"
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @rotate_secret_event_delivered @internal
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus fails when the secret does not exist or is not "ACTIVE"
    Given the secret does not exist or is not "ACTIVE"
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Then the operation is rejected

  @guard @negative @rotate_secret_event_delivered @internal
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus fails when the bus is "DELETED"
    Given the secret exists and is "ACTIVE"
    And the bus is "DELETED"
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Then the operation is rejected

  @guard @negative @rotate_secret_event_delivered @internal
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus fails when no event slot is available
    Given the secret exists and is "ACTIVE"
    And the bus is "ACTIVE"
    And no event slot is available
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Then the operation is rejected
