@neptuneevents @generated
Feature: NeptuneEvents - The "Neptune" "Cluster" Stops And Delivers The State Change Event To The Eventbridge Bus

  # Generated from FizzBee spec: neptune_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @cluster_stop_event_delivered @internal
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Given the "neptune" "cluster" was "AVAILABLE"
    And the "eventbridge" "bus" was "ACTIVE"
    And an "event" "slot" was "available"
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Then the "neptune" "cluster" will be "STOPPING" and the "STOPPED" event will be "DELIVERED"
    And every "DELIVERED" "eventbridge" "event" references a "neptune" "cluster" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @cluster_stop_event_delivered @internal
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus fails when the "neptune" "cluster" was not "AVAILABLE"
    Given the "neptune" "cluster" was not "AVAILABLE"
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @cluster_stop_event_delivered @internal
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus fails when the "eventbridge" "bus" was "DELETED"
    Given the "neptune" "cluster" was "AVAILABLE"
    And the "eventbridge" "bus" was "DELETED"
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @cluster_stop_event_delivered @internal
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus fails when no "eventbridge" "event" "slot" was "available"
    Given the "neptune" "cluster" was "AVAILABLE"
    And the "eventbridge" "bus" was "ACTIVE"
    And no "eventbridge" "event" "slot" was "available"
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected
