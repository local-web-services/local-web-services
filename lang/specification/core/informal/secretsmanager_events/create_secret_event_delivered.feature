@secretsmanagerevents @generated
Feature: SecretsmanagerEvents - A "Secretsmanager" "Secret" Is Created And Secrets Manager Delivers A Created Event To The Eventbridge Bus

  # Generated from FizzBee spec: secretsmanager_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingSecret, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_secret_event_delivered @internal
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given the "secretsmanager" "secret" did not already exist
    And the "eventbridge" "bus" existed and was "ACTIVE"
    And an "eventbridge" "event" "slot" was "available"
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Then the "secrets manager" "secret" will be "ACTIVE" and the "CREATED" event will be "DELIVERED"
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @create_secret_event_delivered @internal
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus fails when the "secretsmanager" "secret" already existed
    Given the "secretsmanager" "secret" already existed
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @create_secret_event_delivered @internal
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus fails when the "eventbridge" "bus" did not exist or was "DELETED"
    Given the "secretsmanager" "secret" did not already exist
    And the "eventbridge" "bus" did not exist or was "DELETED"
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @create_secret_event_delivered @internal
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus fails when no "eventbridge" "event" "slot" was "available"
    Given the "secretsmanager" "secret" did not already exist
    And the "eventbridge" "bus" existed and was "ACTIVE"
    And no "eventbridge" "event" "slot" was "available"
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Then the operation is rejected
