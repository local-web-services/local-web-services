@docdbevents @generated
Feature: DocdbEvents - Action Sequences

  # Generated from FizzBee spec: docdb_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given cid not in cluster_status
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given cid not in cluster_status
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid not in cluster_status
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then a cluster modification begins but event delivery fails because the bus is deleted
    Given cid not in cluster_status
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When a cluster modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then the cluster modification completes
    Given cid not in cluster_status
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When the cluster modification completes
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a cluster modification begins but event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a cluster modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the cluster modification completes
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the cluster modification completes
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a cluster modification begins but event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a cluster modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the cluster modification completes
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the cluster modification completes
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then an EventBridge event bus is created
    Given cid in cluster_status
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then the EventBridge event bus is deleted
    Given cid in cluster_status
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a cluster modification begins but event delivery fails because the bus is deleted
    Given cid in cluster_status
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When a cluster modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then the cluster modification completes
    Given cid in cluster_status
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When the cluster modification completes
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When a cluster modification begins but event delivery fails because the bus is deleted
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    When a cluster modification begins but event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given cid in cluster_status
    When a cluster modification begins but event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid in cluster_status
    When a cluster modification begins but event delivery fails because the bus is deleted
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then the cluster modification completes
    Given cid in cluster_status
    When a cluster modification begins but event delivery fails because the bus is deleted
    When the cluster modification completes
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the cluster modification completes
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then an EventBridge event bus is created
    Given cid in cluster_status
    When the cluster modification completes
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then the EventBridge event bus is deleted
    Given cid in cluster_status
    When the cluster modification completes
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid in cluster_status
    When the cluster modification completes
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster modification begins but event delivery fails because the bus is deleted
    Given cid in cluster_status
    When the cluster modification completes
    When a cluster modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given cid not in cluster_status
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then the EventBridge event bus is deleted then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid not in cluster_status
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When the EventBridge event bus is deleted
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a cluster modification begins but event delivery fails because the bus is deleted
    Given cid not in cluster_status
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When a cluster modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then a cluster modification begins but event delivery fails because the bus is deleted then the cluster modification completes
    Given cid not in cluster_status
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When a cluster modification begins but event delivery fails because the bus is deleted
    When the cluster modification completes
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then the cluster modification completes then an EventBridge event bus is created
    Given cid not in cluster_status
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When the cluster modification completes
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a DocumentDB cluster is created and becomes "AVAILABLE" then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then a cluster modification begins but event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When a cluster modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then the cluster modification completes
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When the cluster modification completes
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a cluster modification begins but event delivery fails because the bus is deleted then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a cluster modification begins but event delivery fails because the bus is deleted
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the cluster modification completes then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the cluster modification completes
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a DocumentDB cluster is created and becomes "AVAILABLE" then a cluster modification begins but event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When a cluster modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then the cluster modification completes
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When the cluster modification completes
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a cluster modification begins but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a cluster modification begins but event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the cluster modification completes then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the cluster modification completes
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a DocumentDB cluster is created and becomes "AVAILABLE" then the cluster modification completes
    Given cid in cluster_status
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When the cluster modification completes
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then an EventBridge event bus is created then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a cluster modification begins but event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given cid in cluster_status
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When a cluster modification begins but event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then the cluster modification completes then a cluster modification begins but event delivery fails because the bus is deleted
    Given cid in cluster_status
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When the cluster modification completes
    When a cluster modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then a DocumentDB cluster is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given cid in cluster_status
    When a cluster modification begins but event delivery fails because the bus is deleted
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given cid in cluster_status
    When a cluster modification begins but event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then the EventBridge event bus is deleted then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid in cluster_status
    When a cluster modification begins but event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then the cluster modification completes
    Given cid in cluster_status
    When a cluster modification begins but event delivery fails because the bus is deleted
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When the cluster modification completes
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then the cluster modification completes then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When a cluster modification begins but event delivery fails because the bus is deleted
    When the cluster modification completes
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a DocumentDB cluster is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given cid in cluster_status
    When the cluster modification completes
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then an EventBridge event bus is created then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid in cluster_status
    When the cluster modification completes
    When an EventBridge event bus is created
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then the EventBridge event bus is deleted then a cluster modification begins but event delivery fails because the bus is deleted
    Given cid in cluster_status
    When the cluster modification completes
    When the EventBridge event bus is deleted
    When a cluster modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the cluster modification completes
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster modification begins but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    When the cluster modification completes
    When a cluster modification begins but event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists
