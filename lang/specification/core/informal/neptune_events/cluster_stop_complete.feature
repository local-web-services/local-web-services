@neptuneevents @generated
Feature: NeptuneEvents - The Neptune Cluster Finishes Stopping

  # Generated from FizzBee spec: neptune_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @cluster_stop_complete @internal
  Scenario: the Neptune cluster finishes stopping
    Given the cluster is "STOPPING"
    When the Neptune cluster finishes stopping
    Then the cluster is "STOPPED"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @cluster_stop_complete @internal
  Scenario: the Neptune cluster finishes stopping fails when the cluster is not "STOPPING"
    Given the cluster is not "STOPPING"
    When the Neptune cluster finishes stopping
    Then the operation is rejected
