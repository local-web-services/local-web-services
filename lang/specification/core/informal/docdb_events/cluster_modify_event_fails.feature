@docdbevents @generated
Feature: DocdbEvents - A "Documentdb" "Cluster" Modification Begins But Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: docdb_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modify_event_fails @internal
  Scenario: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Given the "documentdb" "cluster" was "AVAILABLE"
    And the bus was "DELETED"
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Then the "documentdb" "cluster" will be "MODIFYING" but no event will be delivered
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @cluster_modify_event_fails @internal
  Scenario: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted fails when the "documentdb" "cluster" was not "AVAILABLE"
    Given the "documentdb" "cluster" was not "AVAILABLE"
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Then the operation is rejected

  @guard @negative @cluster_modify_event_fails @internal
  Scenario: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted fails when the bus was not "DELETED"
    Given the "documentdb" "cluster" was "AVAILABLE"
    And the bus was not "DELETED"
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Then the operation is rejected
