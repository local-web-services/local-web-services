@secretsmanagerevents @generated
Feature: SecretsmanagerEvents - Action Sequences

  # Generated from FizzBee spec: secretsmanager_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingSecret, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then an EventBridge event bus is created
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then the EventBridge event bus is deleted
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then an EventBridge event bus is created
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then the EventBridge event bus is deleted
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then an EventBridge event bus is created
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then the EventBridge event bus is deleted
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then an EventBridge event bus is created then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When an EventBridge event bus is created
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then an EventBridge event bus is created then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When an EventBridge event bus is created
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then an EventBridge event bus is created then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When an EventBridge event bus is created
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then the EventBridge event bus is deleted then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then the EventBridge event bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then the EventBridge event bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then an EventBridge event bus is created
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then the EventBridge event bus is deleted
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then an EventBridge event bus is created
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then the EventBridge event bus is deleted
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then an EventBridge event bus is created
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then the EventBridge event bus is deleted
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then an EventBridge event bus is created then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then an EventBridge event bus is created then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then an EventBridge event bus is created then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then an EventBridge event bus is created
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then the EventBridge event bus is deleted
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then an EventBridge event bus is created
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then the EventBridge event bus is deleted
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid not in secret_status
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is created but the "CREATED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is created but the "CREATED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then an EventBridge event bus is created
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then the EventBridge event bus is deleted
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then an EventBridge event bus is created then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When an EventBridge event bus is created
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then an EventBridge event bus is created then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When an EventBridge event bus is created
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then an EventBridge event bus is created then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When an EventBridge event bus is created
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then the EventBridge event bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When the EventBridge event bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then the EventBridge event bus is deleted then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When the EventBridge event bus is deleted
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then the EventBridge event bus is deleted then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When the EventBridge event bus is deleted
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then an EventBridge event bus is created
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then the EventBridge event bus is deleted
    Given sid in secret_status
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then an EventBridge event bus is created
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then the EventBridge event bus is deleted
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then an EventBridge event bus is created then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When an EventBridge event bus is created
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then an EventBridge event bus is created then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When an EventBridge event bus is created
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then an EventBridge event bus is created then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When an EventBridge event bus is created
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then the EventBridge event bus is deleted then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When the EventBridge event bus is deleted
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then the EventBridge event bus is deleted then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When the EventBridge event bus is deleted
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then the EventBridge event bus is deleted then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When the EventBridge event bus is deleted
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then a secret is created but the "CREATED" event delivery fails because the bus is deleted
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When a secret is created but the "CREATED" event delivery fails because the bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then an EventBridge event bus is created
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus then a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus then the EventBridge event bus is deleted
    Given sid in secret_status
    When a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus
    When a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a secret that exists
    And every "DELIVERED" event references a bus that exists
