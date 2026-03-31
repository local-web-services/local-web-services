@secretsmanagerevents @generated
Feature: SecretsmanagerEvents - A "Secretsmanager" "Secret" Rotation Occurs And Secrets Manager Delivers A Rotated Event To The Bus

  # Generated from FizzBee spec: secretsmanager_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingSecret, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @rotate_secret_event_delivered @internal
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given the secrets manager secret existed and was "ACTIVE"
    And the bus was "ACTIVE"
    And an event slot is available
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Then the "secrets manager" "secret" will be "ACTIVE" with a new version and the "ROTATED" event will be "DELIVERED"
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @rotate_secret_event_delivered @internal
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus fails when the secrets manager secret did not exist or was "ACTIVE"
    Given the secrets manager secret did not exist or was "ACTIVE"
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Then the operation is rejected

  @guard @negative @rotate_secret_event_delivered @internal
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus fails when the bus was "DELETED"
    Given the secrets manager secret existed and was "ACTIVE"
    And the bus was "DELETED"
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Then the operation is rejected

  @guard @negative @rotate_secret_event_delivered @internal
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus fails when no event slot is available
    Given the secrets manager secret existed and was "ACTIVE"
    And the bus was "ACTIVE"
    And no event slot is available
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Then the operation is rejected
