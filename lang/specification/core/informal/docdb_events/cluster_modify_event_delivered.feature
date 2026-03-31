@docdbevents @generated
Feature: DocdbEvents - A "Documentdb" "Cluster" Modification Begins And Documentdb Delivers The Event To The Eventbridge Bus

  # Generated from FizzBee spec: docdb_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modify_event_delivered @internal
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Given the "documentdb" "cluster" was "AVAILABLE"
    And the bus was "ACTIVE"
    And an event slot is available
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Then the "documentdb" "cluster" will be "MODIFYING" and the "MODIFIED" event will be "DELIVERED"
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @cluster_modify_event_delivered @internal
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus fails when the "documentdb" "cluster" was not "AVAILABLE"
    Given the "documentdb" "cluster" was not "AVAILABLE"
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @cluster_modify_event_delivered @internal
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus fails when the bus was "DELETED"
    Given the "documentdb" "cluster" was "AVAILABLE"
    And the bus was "DELETED"
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @cluster_modify_event_delivered @internal
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus fails when no event slot is available
    Given the "documentdb" "cluster" was "AVAILABLE"
    And the bus was "ACTIVE"
    And no event slot is available
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Then the operation is rejected
