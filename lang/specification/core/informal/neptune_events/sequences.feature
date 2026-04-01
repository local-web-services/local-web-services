@neptuneevents @generated
Feature: NeptuneEvents - Action Sequences

  # Generated from FizzBee spec: neptune_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "neptune" "cluster" is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given cid not in cluster_status
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "neptune" "cluster" is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given cid not in cluster_status
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "neptune" "cluster" is created and becomes "AVAILABLE" then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Given cid not in cluster_status
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "neptune" "cluster" is created and becomes "AVAILABLE" then the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Given cid not in cluster_status
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "neptune" "cluster" is created and becomes "AVAILABLE" then the "neptune" "cluster" finishes stopping
    Given cid not in cluster_status
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When the "neptune" "cluster" finishes stopping
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "neptune" "cluster" is created and becomes "AVAILABLE"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "neptune" "cluster" finishes stopping
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "neptune" "cluster" finishes stopping
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "neptune" "cluster" is created and becomes "AVAILABLE"
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "neptune" "cluster" finishes stopping
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "neptune" "cluster" finishes stopping
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then a "neptune" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then an EventBridge event bus is created
    Given cid in cluster_status
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then the EventBridge event bus is deleted
    Given cid in cluster_status
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Given cid in cluster_status
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then the "neptune" "cluster" finishes stopping
    Given cid in cluster_status
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When the "neptune" "cluster" finishes stopping
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops but event delivery fails because the bus is deleted then a "neptune" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops but event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given cid in cluster_status
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops but event delivery fails because the bus is deleted then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Given cid in cluster_status
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops but event delivery fails because the bus is deleted then the "neptune" "cluster" finishes stopping
    Given cid in cluster_status
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When the "neptune" "cluster" finishes stopping
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" finishes stopping then a "neptune" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the "neptune" "cluster" finishes stopping
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" finishes stopping then an EventBridge event bus is created
    Given cid in cluster_status
    When the "neptune" "cluster" finishes stopping
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" finishes stopping then the EventBridge event bus is deleted
    Given cid in cluster_status
    When the "neptune" "cluster" finishes stopping
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" finishes stopping then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Given cid in cluster_status
    When the "neptune" "cluster" finishes stopping
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" finishes stopping then the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Given cid in cluster_status
    When the "neptune" "cluster" finishes stopping
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "neptune" "cluster" is created and becomes "AVAILABLE" then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given cid not in cluster_status
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "neptune" "cluster" is created and becomes "AVAILABLE" then the EventBridge event bus is deleted then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Given cid not in cluster_status
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When the EventBridge event bus is deleted
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "neptune" "cluster" is created and becomes "AVAILABLE" then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Given cid not in cluster_status
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "neptune" "cluster" is created and becomes "AVAILABLE" then the "neptune" "cluster" stops but event delivery fails because the bus is deleted then the "neptune" "cluster" finishes stopping
    Given cid not in cluster_status
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When the "neptune" "cluster" finishes stopping
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "neptune" "cluster" is created and becomes "AVAILABLE" then the "neptune" "cluster" finishes stopping then an EventBridge event bus is created
    Given cid not in cluster_status
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When the "neptune" "cluster" finishes stopping
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "neptune" "cluster" is created and becomes "AVAILABLE" then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then the "neptune" "cluster" finishes stopping
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When the "neptune" "cluster" finishes stopping
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "neptune" "cluster" stops but event delivery fails because the bus is deleted then a "neptune" "cluster" is created and becomes "AVAILABLE"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "neptune" "cluster" finishes stopping then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "neptune" "cluster" finishes stopping
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "neptune" "cluster" is created and becomes "AVAILABLE" then the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then the "neptune" "cluster" finishes stopping
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When the "neptune" "cluster" finishes stopping
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then a "neptune" "cluster" is created and becomes "AVAILABLE"
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "neptune" "cluster" stops but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "neptune" "cluster" finishes stopping then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "neptune" "cluster" finishes stopping
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then a "neptune" "cluster" is created and becomes "AVAILABLE" then the "neptune" "cluster" finishes stopping
    Given cid in cluster_status
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When the "neptune" "cluster" finishes stopping
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then an EventBridge event bus is created then a "neptune" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When an EventBridge event bus is created
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then the "neptune" "cluster" stops but event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given cid in cluster_status
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then the "neptune" "cluster" finishes stopping then the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Given cid in cluster_status
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When the "neptune" "cluster" finishes stopping
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops but event delivery fails because the bus is deleted then a "neptune" "cluster" is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given cid in cluster_status
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops but event delivery fails because the bus is deleted then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given cid in cluster_status
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops but event delivery fails because the bus is deleted then the EventBridge event bus is deleted then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Given cid in cluster_status
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops but event delivery fails because the bus is deleted then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then the "neptune" "cluster" finishes stopping
    Given cid in cluster_status
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When the "neptune" "cluster" finishes stopping
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" stops but event delivery fails because the bus is deleted then the "neptune" "cluster" finishes stopping then a "neptune" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When the "neptune" "cluster" finishes stopping
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" finishes stopping then a "neptune" "cluster" is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given cid in cluster_status
    When the "neptune" "cluster" finishes stopping
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" finishes stopping then an EventBridge event bus is created then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    Given cid in cluster_status
    When the "neptune" "cluster" finishes stopping
    When an EventBridge event bus is created
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" finishes stopping then the EventBridge event bus is deleted then the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    Given cid in cluster_status
    When the "neptune" "cluster" finishes stopping
    When the EventBridge event bus is deleted
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" finishes stopping then the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus then a "neptune" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the "neptune" "cluster" finishes stopping
    When the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus
    When a "neptune" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "neptune" "cluster" finishes stopping then the "neptune" "cluster" stops but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    When the "neptune" "cluster" finishes stopping
    When the "neptune" "cluster" stops but event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists
