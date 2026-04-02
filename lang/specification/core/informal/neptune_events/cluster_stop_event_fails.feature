@neptuneevents @generated
Feature: NeptuneEvents - The "Neptune" "Cluster" Stops But Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: neptune_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @cluster_stop_event_fails @internal
  Scenario: the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Given the "neptune" "cluster" was "AVAILABLE"
    And the "eventbridge" "bus" was "DELETED"
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Then the "neptune" "cluster" will be "STOPPING" but no event will be delivered
    And every "DELIVERED" "eventbridge" "event" references a "neptune" "cluster" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @cluster_stop_event_fails @internal
  Scenario: the "neptune" "cluster" stops but event delivery fails because the bus is deleted fails when the "neptune" "cluster" was not "AVAILABLE"
    Given the "neptune" "cluster" was not "AVAILABLE"
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Then the operation is rejected

  @guard @negative @cluster_stop_event_fails @internal
  Scenario: the "neptune" "cluster" stops but event delivery fails because the bus is deleted fails when the "eventbridge" "bus" was not "DELETED"
    Given the "neptune" "cluster" was "AVAILABLE"
    And the "eventbridge" "bus" was not "DELETED"
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Then the operation is rejected
