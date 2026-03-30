@docdbevents @generated
Feature: DocdbEvents - The Cluster Modification Completes

  # Generated from FizzBee spec: docdb_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modify_complete @internal
  Scenario: the cluster modification completes
    Given the cluster is "MODIFYING"
    When the cluster modification completes
    Then the cluster is "AVAILABLE" again
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @cluster_modify_complete @internal
  Scenario: the cluster modification completes fails when the cluster is not "MODIFYING"
    Given the cluster is not "MODIFYING"
    When the cluster modification completes
    Then the operation is rejected
