@neptuneevents @generated
Feature: NeptuneEvents - A "Neptune" "Cluster" Is Created And Becomes Available

  # Generated from FizzBee spec: neptune_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a "neptune" "cluster" is created and becomes "AVAILABLE"
    Given the cluster did not already exist
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    Then the "neptune" "cluster" will be "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @create_cluster
  Scenario: a "neptune" "cluster" is created and becomes "AVAILABLE" fails when the cluster already existed
    Given the cluster already existed
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    Then the operation is rejected
