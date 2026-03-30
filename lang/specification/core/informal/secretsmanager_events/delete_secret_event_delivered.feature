@secretsmanagerevents @generated
Feature: SecretsmanagerEvents - A Secret Is Scheduled For Deletion And Secrets Manager Delivers A Deleted Event To The Bus

  # Generated from FizzBee spec: secretsmanager_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingSecret, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @delete_secret_event_delivered @internal
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given the secret exists and is "ACTIVE"
    And the bus is "ACTIVE"
    And an event slot is available
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Then the secret is "PENDING_DELETION" and the "DELETED" event is "DELIVERED"
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @delete_secret_event_delivered @internal
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus fails when the secret does not exist or is not "ACTIVE"
    Given the secret does not exist or is not "ACTIVE"
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Then the operation is rejected

  @guard @negative @delete_secret_event_delivered @internal
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus fails when the bus is "DELETED"
    Given the secret exists and is "ACTIVE"
    And the bus is "DELETED"
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Then the operation is rejected

  @guard @negative @delete_secret_event_delivered @internal
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus fails when no event slot is available
    Given the secret exists and is "ACTIVE"
    And the bus is "ACTIVE"
    And no event slot is available
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Then the operation is rejected
