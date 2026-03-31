@docdbevents @generated
Feature: DocdbEvents - A "Documentdb" "Cluster" Is Created And Becomes Available

  # Generated from FizzBee spec: docdb_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a "documentdb" "cluster" is created and becomes "AVAILABLE"
    Given the "documentdb" "cluster" did not already exist
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    Then the "documentdb" "cluster" will be "AVAILABLE"
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @create_cluster
  Scenario: a "documentdb" "cluster" is created and becomes "AVAILABLE" fails when the "documentdb" "cluster" already existed
    Given the "documentdb" "cluster" already existed
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    Then the operation is rejected
