@secretsmanagerevents @generated
Feature: SecretsmanagerEvents - Action Sequences

  # Generated from FizzBee spec: secretsmanager_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingSecret, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then an "eventbridge" "bus" is created
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When an "eventbridge" "bus" is created
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then the "eventbridge" "bus" is deleted
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then an "eventbridge" "bus" is created
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then the "eventbridge" "bus" is deleted
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then an "eventbridge" "bus" is created
    Given sid in secret_status
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When an "eventbridge" "bus" is created
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then the "eventbridge" "bus" is deleted
    Given sid in secret_status
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid in secret_status
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then an "eventbridge" "bus" is created
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When an "eventbridge" "bus" is created
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then the "eventbridge" "bus" is deleted
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then an "eventbridge" "bus" is created
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then the "eventbridge" "bus" is deleted then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When the "eventbridge" "bus" is deleted
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then the "eventbridge" "bus" is deleted
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then an "eventbridge" "bus" is created then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When an "eventbridge" "bus" is created
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then the "eventbridge" "bus" is deleted then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When the "eventbridge" "bus" is deleted
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then an "eventbridge" "bus" is created
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When an "eventbridge" "bus" is created
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then an "eventbridge" "bus" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When an "eventbridge" "bus" is created
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then an "eventbridge" "bus" is created
    Given sid in secret_status
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given sid in secret_status
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then the "eventbridge" "bus" is deleted then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid in secret_status
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When the "eventbridge" "bus" is deleted
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then an "eventbridge" "bus" is created
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When an "eventbridge" "bus" is created
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted then the "eventbridge" "bus" is deleted
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then an "eventbridge" "bus" is created then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When an "eventbridge" "bus" is created
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then the "eventbridge" "bus" is deleted then a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When the "eventbridge" "bus" is deleted
    When a "secretsmanager" "secret" is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a "secretsmanager" "secret" is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "secretsmanager" "secret" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists
