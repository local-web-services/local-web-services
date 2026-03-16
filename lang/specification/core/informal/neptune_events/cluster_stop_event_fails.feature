@neptuneevents @generated
Feature: NeptuneEvents - The Neptune Cluster Stops But Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: neptune_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @cluster_stop_event_fails @internal
  Scenario: the Neptune cluster stops but event delivery fails because the bus is deleted
    Given the cluster is "AVAILABLE"
    And the bus is "DELETED"
    When the Neptune cluster stops but event delivery fails because the bus is deleted
    Then the cluster is "STOPPING" but no event is delivered
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @cluster_stop_event_fails @internal
  Scenario: the Neptune cluster stops but event delivery fails because the bus is deleted fails when the cluster is not "AVAILABLE"
    Given the cluster is not "AVAILABLE"
    When the Neptune cluster stops but event delivery fails because the bus is deleted
    Then the operation is rejected

  @standard @negative @cluster_stop_event_fails @internal
  Scenario: the Neptune cluster stops but event delivery fails because the bus is deleted fails when the bus is not "DELETED"
    Given the cluster is "AVAILABLE"
    And the bus is not "DELETED"
    When the Neptune cluster stops but event delivery fails because the bus is deleted
    Then the operation is rejected
