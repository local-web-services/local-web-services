@neptuneevents @generated
Feature: NeptuneEvents - The "Neptune" "Cluster" Finishes Stopping

  # Generated from FizzBee spec: neptune_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @cluster_stop_complete @internal
  Scenario: the "neptune" "cluster" finishes stopping
    Given the "neptune" "cluster" was "STOPPING"
    When the "neptune" "cluster" finishes stopping
    Then the "neptune" "cluster" will be "STOPPED"
    And every "DELIVERED" "eventbridge" "event" references a "neptune" "cluster" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @cluster_stop_complete @internal
  Scenario: the "neptune" "cluster" finishes stopping fails when the "neptune" "cluster" was not "STOPPING"
    Given the "neptune" "cluster" was not "STOPPING"
    When the "neptune" "cluster" finishes stopping
    Then the operation is rejected
