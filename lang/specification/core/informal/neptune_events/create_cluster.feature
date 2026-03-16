@neptuneevents @generated
Feature: NeptuneEvents - A Neptune Cluster Is Created And Becomes Available

  # Generated from FizzBee spec: neptune_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a Neptune cluster is created and becomes "AVAILABLE"
    Given the cluster does not already exist
    When a Neptune cluster is created and becomes "AVAILABLE"
    Then the cluster is "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @create_cluster
  Scenario: a Neptune cluster is created and becomes "AVAILABLE" fails when the cluster already exists
    Given the cluster already exists
    When a Neptune cluster is created and becomes "AVAILABLE"
    Then the operation is rejected
