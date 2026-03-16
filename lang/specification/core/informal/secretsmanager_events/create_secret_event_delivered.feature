@secretsmanagerevents @generated
Feature: SecretsmanagerEvents - A Secret Is Created And Secrets Manager Delivers A Created Event To The Eventbridge Bus

  # Generated from FizzBee spec: secretsmanager_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingSecret, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_secret_event_delivered @internal
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given the secret does not already exist
    And the bus exists and is "ACTIVE"
    And an event slot is available
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Then the secret is "ACTIVE" and the "CREATED" event is "DELIVERED"
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @create_secret_event_delivered @internal
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus fails when the secret already exists
    Given the secret already exists
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @create_secret_event_delivered @internal
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus fails when the bus does not exist or is "DELETED"
    Given the secret does not already exist
    And the bus does not exist or is "DELETED"
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @create_secret_event_delivered @internal
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus fails when no event slot is available
    Given the secret does not already exist
    And the bus exists and is "ACTIVE"
    And no event slot is available
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Then the operation is rejected
