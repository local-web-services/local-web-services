@secretsmanagerevents @generated
Feature: SecretsmanagerEvents - The Eventbridge Event Bus Is Deleted

  # Generated from FizzBee spec: secretsmanager_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingSecret, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @delete_event_bus
  Scenario: the EventBridge event bus is deleted
    Given the bus exists
    And the bus is "ACTIVE"
    When the EventBridge event bus is deleted
    Then the bus is "DELETED" and Secrets Manager event delivery will fail
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @delete_event_bus
  Scenario: the EventBridge event bus is deleted fails when the bus does not exist
    Given the bus does not exist
    When the EventBridge event bus is deleted
    Then the operation is rejected

  @guard @negative @delete_event_bus @lifecycle
  Scenario: the EventBridge event bus is deleted fails when the bus is already "DELETED"
    Given the bus exists
    And the bus is already "DELETED"
    When the EventBridge event bus is deleted
    Then the operation is rejected
