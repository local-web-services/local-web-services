@docdbevents @generated
Feature: DocdbEvents - A Cluster Modification Begins And Documentdb Delivers The Event To The Eventbridge Bus

  # Generated from FizzBee spec: docdb_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modify_event_delivered @internal
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given the cluster is "AVAILABLE"
    And the bus is "ACTIVE"
    And an event slot is available
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then the cluster is "MODIFYING" and the "MODIFIED" event is "DELIVERED"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @cluster_modify_event_delivered @internal
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus fails when the cluster is not "AVAILABLE"
    Given the cluster is not "AVAILABLE"
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @cluster_modify_event_delivered @internal
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus fails when the bus is "DELETED"
    Given the cluster is "AVAILABLE"
    And the bus is "DELETED"
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @cluster_modify_event_delivered @internal
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus fails when no event slot is available
    Given the cluster is "AVAILABLE"
    And the bus is "ACTIVE"
    And no event slot is available
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then the operation is rejected
