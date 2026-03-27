@neptuneevents @generated
Feature: NeptuneEvents - Action Sequences

  # Generated from FizzBee spec: neptune_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Neptune cluster is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given cid not in cluster_status
    Given a Neptune cluster has been created and has become "AVAILABLE"
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Neptune cluster is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given cid not in cluster_status
    Given a Neptune cluster has been created and has become "AVAILABLE"
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Neptune cluster is created and becomes "AVAILABLE" then the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Given cid not in cluster_status
    Given a Neptune cluster has been created and has become "AVAILABLE"
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Neptune cluster is created and becomes "AVAILABLE" then the Neptune cluster stops but event delivery fails because the bus is deleted
    Given cid not in cluster_status
    Given a Neptune cluster has been created and has become "AVAILABLE"
    When the Neptune cluster stops but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Neptune cluster is created and becomes "AVAILABLE" then the Neptune cluster finishes stopping
    Given cid not in cluster_status
    Given a Neptune cluster has been created and has become "AVAILABLE"
    When the Neptune cluster finishes stopping
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Neptune cluster is created and becomes "AVAILABLE"
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When a Neptune cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Neptune cluster stops but event delivery fails because the bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the Neptune cluster stops but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Neptune cluster finishes stopping
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the Neptune cluster finishes stopping
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a Neptune cluster is created and becomes "AVAILABLE"
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When a Neptune cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Neptune cluster stops but event delivery fails because the bus is deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When the Neptune cluster stops but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Neptune cluster finishes stopping
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When the Neptune cluster finishes stopping
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus then a Neptune cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    When a Neptune cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus then an EventBridge event bus is created
    Given cid in cluster_status
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus then the EventBridge event bus is deleted
    Given cid in cluster_status
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus then the Neptune cluster stops but event delivery fails because the bus is deleted
    Given cid in cluster_status
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    When the Neptune cluster stops but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus then the Neptune cluster finishes stopping
    Given cid in cluster_status
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    When the Neptune cluster finishes stopping
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops but event delivery fails because the bus is deleted then a Neptune cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    When a Neptune cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops but event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given cid in cluster_status
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops but event delivery fails because the bus is deleted then the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Given cid in cluster_status
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops but event delivery fails because the bus is deleted then the Neptune cluster finishes stopping
    Given cid in cluster_status
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    When the Neptune cluster finishes stopping
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster finishes stopping then a Neptune cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given the Neptune cluster has finished stopping
    When a Neptune cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster finishes stopping then an EventBridge event bus is created
    Given cid in cluster_status
    Given the Neptune cluster has finished stopping
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster finishes stopping then the EventBridge event bus is deleted
    Given cid in cluster_status
    Given the Neptune cluster has finished stopping
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster finishes stopping then the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Given cid in cluster_status
    Given the Neptune cluster has finished stopping
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster finishes stopping then the Neptune cluster stops but event delivery fails because the bus is deleted
    Given cid in cluster_status
    Given the Neptune cluster has finished stopping
    When the Neptune cluster stops but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Neptune cluster is created and becomes "AVAILABLE" then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given cid not in cluster_status
    Given a Neptune cluster has been created and has become "AVAILABLE"
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Neptune cluster is created and becomes "AVAILABLE" then the EventBridge event bus is deleted then the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Given cid not in cluster_status
    Given a Neptune cluster has been created and has become "AVAILABLE"
    Given the EventBridge event bus has been deleted
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Neptune cluster is created and becomes "AVAILABLE" then the Neptune cluster stops and delivers the state change event to the EventBridge bus then the Neptune cluster stops but event delivery fails because the bus is deleted
    Given cid not in cluster_status
    Given a Neptune cluster has been created and has become "AVAILABLE"
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    When the Neptune cluster stops but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Neptune cluster is created and becomes "AVAILABLE" then the Neptune cluster stops but event delivery fails because the bus is deleted then the Neptune cluster finishes stopping
    Given cid not in cluster_status
    Given a Neptune cluster has been created and has become "AVAILABLE"
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    When the Neptune cluster finishes stopping
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Neptune cluster is created and becomes "AVAILABLE" then the Neptune cluster finishes stopping then an EventBridge event bus is created
    Given cid not in cluster_status
    Given a Neptune cluster has been created and has become "AVAILABLE"
    Given the Neptune cluster has finished stopping
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Neptune cluster is created and becomes "AVAILABLE" then the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given a Neptune cluster has been created and has become "AVAILABLE"
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then the Neptune cluster stops but event delivery fails because the bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the EventBridge event bus has been deleted
    When the Neptune cluster stops but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Neptune cluster stops and delivers the state change event to the EventBridge bus then the Neptune cluster finishes stopping
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    When the Neptune cluster finishes stopping
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Neptune cluster stops but event delivery fails because the bus is deleted then a Neptune cluster is created and becomes "AVAILABLE"
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    When a Neptune cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Neptune cluster finishes stopping then the EventBridge event bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the Neptune cluster has finished stopping
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a Neptune cluster is created and becomes "AVAILABLE" then the Neptune cluster stops but event delivery fails because the bus is deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given a Neptune cluster has been created and has become "AVAILABLE"
    When the Neptune cluster stops but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then the Neptune cluster finishes stopping
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given an EventBridge event bus has been created
    When the Neptune cluster finishes stopping
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Neptune cluster stops and delivers the state change event to the EventBridge bus then a Neptune cluster is created and becomes "AVAILABLE"
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    When a Neptune cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Neptune cluster stops but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Neptune cluster finishes stopping then the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given the Neptune cluster has finished stopping
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus then a Neptune cluster is created and becomes "AVAILABLE" then the Neptune cluster finishes stopping
    Given cid in cluster_status
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    Given a Neptune cluster has been created and has become "AVAILABLE"
    When the Neptune cluster finishes stopping
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus then an EventBridge event bus is created then a Neptune cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    Given an EventBridge event bus has been created
    When a Neptune cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    Given the EventBridge event bus has been deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus then the Neptune cluster stops but event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given cid in cluster_status
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops and delivers the state change event to the EventBridge bus then the Neptune cluster finishes stopping then the Neptune cluster stops but event delivery fails because the bus is deleted
    Given cid in cluster_status
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    Given the Neptune cluster has finished stopping
    When the Neptune cluster stops but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops but event delivery fails because the bus is deleted then a Neptune cluster is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given cid in cluster_status
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    Given a Neptune cluster has been created and has become "AVAILABLE"
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops but event delivery fails because the bus is deleted then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given cid in cluster_status
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops but event delivery fails because the bus is deleted then the EventBridge event bus is deleted then the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Given cid in cluster_status
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    Given the EventBridge event bus has been deleted
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops but event delivery fails because the bus is deleted then the Neptune cluster stops and delivers the state change event to the EventBridge bus then the Neptune cluster finishes stopping
    Given cid in cluster_status
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    When the Neptune cluster finishes stopping
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster stops but event delivery fails because the bus is deleted then the Neptune cluster finishes stopping then a Neptune cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    Given the Neptune cluster has finished stopping
    When a Neptune cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster finishes stopping then a Neptune cluster is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given cid in cluster_status
    Given the Neptune cluster has finished stopping
    Given a Neptune cluster has been created and has become "AVAILABLE"
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster finishes stopping then an EventBridge event bus is created then the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Given cid in cluster_status
    Given the Neptune cluster has finished stopping
    Given an EventBridge event bus has been created
    When the Neptune cluster stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster finishes stopping then the EventBridge event bus is deleted then the Neptune cluster stops but event delivery fails because the bus is deleted
    Given cid in cluster_status
    Given the Neptune cluster has finished stopping
    Given the EventBridge event bus has been deleted
    When the Neptune cluster stops but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster finishes stopping then the Neptune cluster stops and delivers the state change event to the EventBridge bus then a Neptune cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given the Neptune cluster has finished stopping
    Given the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus
    When a Neptune cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Neptune cluster finishes stopping then the Neptune cluster stops but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    Given the Neptune cluster has finished stopping
    Given the Neptune cluster has stopped but event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists
