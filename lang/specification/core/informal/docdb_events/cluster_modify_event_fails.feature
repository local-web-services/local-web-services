@docdbevents @generated
Feature: DocdbEvents - A Cluster Modification Begins But Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: docdb_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modify_event_fails @internal
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted
    Given the cluster is "AVAILABLE"
    And the bus is "DELETED"
    When a cluster modification begins but event delivery fails because the bus is deleted
    Then the cluster is "MODIFYING" but no event is delivered
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @cluster_modify_event_fails @internal
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted fails when the cluster is not "AVAILABLE"
    Given the cluster is not "AVAILABLE"
    When a cluster modification begins but event delivery fails because the bus is deleted
    Then the operation is rejected

  @standard @negative @cluster_modify_event_fails @internal
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted fails when the bus is not "DELETED"
    Given the cluster is "AVAILABLE"
    And the bus is not "DELETED"
    When a cluster modification begins but event delivery fails because the bus is deleted
    Then the operation is rejected
