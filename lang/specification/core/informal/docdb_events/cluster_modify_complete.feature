@docdbevents @generated
Feature: DocdbEvents - The "Documentdb" "Cluster" Modification Completes

  # Generated from FizzBee spec: docdb_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modify_complete @internal
  Scenario: the "documentdb" "cluster" modification completes
    Given the "documentdb" "cluster" was "MODIFYING"
    When the "documentdb" "cluster" modification completes
    Then the "documentdb" "cluster" will be "AVAILABLE" again
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @cluster_modify_complete @internal
  Scenario: the "documentdb" "cluster" modification completes fails when the "documentdb" "cluster" was not "MODIFYING"
    Given the "documentdb" "cluster" was not "MODIFYING"
    When the "documentdb" "cluster" modification completes
    Then the operation is rejected
