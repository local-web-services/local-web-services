@secretsmanagerevents @generated
Feature: SecretsmanagerEvents - A Secret Is Created But The Created Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: secretsmanager_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingSecret, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_secret_event_fails @internal
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given the secret does not already exist
    And the bus is "DELETED"
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Then the secret is "ACTIVE" but no event is delivered
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @create_secret_event_fails @internal
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted fails when the secret already exists
    Given the secret already exists
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Then the operation is rejected

  @guard @negative @create_secret_event_fails @internal
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted fails when the bus is not "DELETED"
    Given the secret does not already exist
    And the bus is not "DELETED"
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Then the operation is rejected
