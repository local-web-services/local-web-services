@secretsmanagerevents @generated
Feature: SecretsmanagerEvents - A "Secretsmanager" "Secret" Is Created But The Created Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: secretsmanager_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingSecret, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_secret_event_fails @internal
  Scenario: a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Given the "secretsmanager" "secret" did not already exist
    And the bus was "DELETED"
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Then the "secrets manager" "secret" will be "ACTIVE" but no event will be delivered
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @create_secret_event_fails @internal
  Scenario: a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted fails when the "secretsmanager" "secret" already existed
    Given the "secretsmanager" "secret" already existed
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Then the operation is rejected

  @guard @negative @create_secret_event_fails @internal
  Scenario: a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted fails when the bus was not "DELETED"
    Given the "secretsmanager" "secret" did not already exist
    And the bus was not "DELETED"
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Then the operation is rejected
