@neptuneevents @generated
Feature: NeptuneEvents - The Neptune Cluster Stops And Delivers The State Change Event To The Eventbridge Bus

  # Generated from FizzBee spec: neptune_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @cluster_stop_event_delivered @internal
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Given the cluster is "AVAILABLE"
    And the bus is "ACTIVE"
    And an event slot is available
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then the cluster is "STOPPING" and the "STOPPED" event is "DELIVERED"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @cluster_stop_event_delivered @internal
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus fails when the cluster is not "AVAILABLE"
    Given the cluster is not "AVAILABLE"
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @cluster_stop_event_delivered @internal
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus fails when the bus is "DELETED"
    Given the cluster is "AVAILABLE"
    And the bus is "DELETED"
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @cluster_stop_event_delivered @internal
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus fails when no event slot is available
    Given the cluster is "AVAILABLE"
    And the bus is "ACTIVE"
    And no event slot is available
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected
