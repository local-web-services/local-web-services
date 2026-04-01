@docdbevents @generated
Feature: DocdbEvents - Action Sequences

  # Generated from FizzBee spec: docdb_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "documentdb" "cluster" is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created and becomes "AVAILABLE" then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created and becomes "AVAILABLE" then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created and becomes "AVAILABLE" then the "documentdb" "cluster" modification completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When the "documentdb" "cluster" modification completes
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "documentdb" "cluster" is created and becomes "AVAILABLE"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "documentdb" "cluster" modification completes
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "documentdb" "cluster" modification completes
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "documentdb" "cluster" is created and becomes "AVAILABLE"
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "documentdb" "cluster" modification completes
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "documentdb" "cluster" modification completes
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then a "documentdb" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then an EventBridge event bus is created
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then the EventBridge event bus is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then the "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When the "documentdb" "cluster" modification completes
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then a "documentdb" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then the "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When the "documentdb" "cluster" modification completes
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "documentdb" "cluster" modification completes then a "documentdb" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "documentdb" "cluster" modification completes then an EventBridge event bus is created
    Given cid in cluster_status
    When the "documentdb" "cluster" modification completes
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "documentdb" "cluster" modification completes then the EventBridge event bus is deleted
    Given cid in cluster_status
    When the "documentdb" "cluster" modification completes
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "documentdb" "cluster" modification completes then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid in cluster_status
    When the "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "documentdb" "cluster" modification completes then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Given cid in cluster_status
    When the "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created and becomes "AVAILABLE" then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created and becomes "AVAILABLE" then the EventBridge event bus is deleted then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When the EventBridge event bus is deleted
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created and becomes "AVAILABLE" then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created and becomes "AVAILABLE" then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then the "documentdb" "cluster" modification completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When the "documentdb" "cluster" modification completes
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created and becomes "AVAILABLE" then the "documentdb" "cluster" modification completes then an EventBridge event bus is created
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When the "documentdb" "cluster" modification completes
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "documentdb" "cluster" is created and becomes "AVAILABLE" then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then the "documentdb" "cluster" modification completes
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When the "documentdb" "cluster" modification completes
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then a "documentdb" "cluster" is created and becomes "AVAILABLE"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "documentdb" "cluster" modification completes then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "documentdb" "cluster" modification completes
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "documentdb" "cluster" is created and becomes "AVAILABLE" then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then the "documentdb" "cluster" modification completes
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When the "documentdb" "cluster" modification completes
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then a "documentdb" "cluster" is created and becomes "AVAILABLE"
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "documentdb" "cluster" modification completes then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then a "documentdb" "cluster" is created and becomes "AVAILABLE" then the "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When the "documentdb" "cluster" modification completes
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then an EventBridge event bus is created then a "documentdb" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then the "documentdb" "cluster" modification completes then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When the "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then a "documentdb" "cluster" is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then the EventBridge event bus is deleted then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then the "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When the "documentdb" "cluster" modification completes
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then the "documentdb" "cluster" modification completes then a "documentdb" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When the "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "documentdb" "cluster" modification completes then a "documentdb" "cluster" is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given cid in cluster_status
    When the "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "documentdb" "cluster" modification completes then an EventBridge event bus is created then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid in cluster_status
    When the "documentdb" "cluster" modification completes
    When an EventBridge event bus is created
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "documentdb" "cluster" modification completes then the EventBridge event bus is deleted then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    Given cid in cluster_status
    When the "documentdb" "cluster" modification completes
    When the EventBridge event bus is deleted
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "documentdb" "cluster" modification completes then a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus then a "documentdb" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus
    When a "documentdb" "cluster" is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "documentdb" "cluster" modification completes then a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    When the "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "documentdb" "cluster" that exists
    And every "DELIVERED" event references a bus that exists
