@docdbevents @generated
Feature: DocdbEvents - Action Sequences

  # Generated from FizzBee spec: docdb_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then a cluster modification begins but event delivery fails because the bus is deleted
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    When a cluster modification begins but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then the cluster modification completes
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    When the cluster modification completes
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When a DocumentDB cluster is created and becomes "AVAILABLE"
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
  Scenario: an EventBridge event bus is created then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a cluster modification begins but event delivery fails because the bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When a cluster modification begins but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the cluster modification completes
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the cluster modification completes
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When a DocumentDB cluster is created and becomes "AVAILABLE"
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
  Scenario: the EventBridge event bus is deleted then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a cluster modification begins but event delivery fails because the bus is deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When a cluster modification begins but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the cluster modification completes
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When the cluster modification completes
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then an EventBridge event bus is created
    Given cid in cluster_status
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then the EventBridge event bus is deleted
    Given cid in cluster_status
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a cluster modification begins but event delivery fails because the bus is deleted
    Given cid in cluster_status
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    When a cluster modification begins but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then the cluster modification completes
    Given cid in cluster_status
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    When the cluster modification completes
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given cid in cluster_status
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid in cluster_status
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then the cluster modification completes
    Given cid in cluster_status
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    When the cluster modification completes
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given the cluster modification has completed
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then an EventBridge event bus is created
    Given cid in cluster_status
    Given the cluster modification has completed
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then the EventBridge event bus is deleted
    Given cid in cluster_status
    Given the cluster modification has completed
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid in cluster_status
    Given the cluster modification has completed
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster modification begins but event delivery fails because the bus is deleted
    Given cid in cluster_status
    Given the cluster modification has completed
    When a cluster modification begins but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then the EventBridge event bus is deleted then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    Given the EventBridge event bus has been deleted
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a cluster modification begins but event delivery fails because the bus is deleted
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    When a cluster modification begins but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then a cluster modification begins but event delivery fails because the bus is deleted then the cluster modification completes
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    When the cluster modification completes
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created and becomes "AVAILABLE" then the cluster modification completes then an EventBridge event bus is created
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    Given the cluster modification has completed
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a DocumentDB cluster is created and becomes "AVAILABLE" then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then a cluster modification begins but event delivery fails because the bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the EventBridge event bus has been deleted
    When a cluster modification begins but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then the cluster modification completes
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    When the cluster modification completes
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a cluster modification begins but event delivery fails because the bus is deleted then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the cluster modification completes then the EventBridge event bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the cluster modification has completed
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a DocumentDB cluster is created and becomes "AVAILABLE" then a cluster modification begins but event delivery fails because the bus is deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    When a cluster modification begins but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then the cluster modification completes
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given an EventBridge event bus has been created
    When the cluster modification completes
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a cluster modification begins but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the cluster modification completes then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given the cluster modification has completed
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a DocumentDB cluster is created and becomes "AVAILABLE" then the cluster modification completes
    Given cid in cluster_status
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    When the cluster modification completes
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then an EventBridge event bus is created then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    Given an EventBridge event bus has been created
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    Given the EventBridge event bus has been deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a cluster modification begins but event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given cid in cluster_status
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then the cluster modification completes then a cluster modification begins but event delivery fails because the bus is deleted
    Given cid in cluster_status
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    Given the cluster modification has completed
    When a cluster modification begins but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then a DocumentDB cluster is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given cid in cluster_status
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given cid in cluster_status
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then the EventBridge event bus is deleted then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid in cluster_status
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    Given the EventBridge event bus has been deleted
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then the cluster modification completes
    Given cid in cluster_status
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    When the cluster modification completes
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a cluster modification begins but event delivery fails because the bus is deleted then the cluster modification completes then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    Given the cluster modification has completed
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a DocumentDB cluster is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given cid in cluster_status
    Given the cluster modification has completed
    Given a DocumentDB cluster has been created and has become "AVAILABLE"
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then an EventBridge event bus is created then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Given cid in cluster_status
    Given the cluster modification has completed
    Given an EventBridge event bus has been created
    When a cluster modification begins and DocumentDB delivers the event to the EventBridge bus
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then the EventBridge event bus is deleted then a cluster modification begins but event delivery fails because the bus is deleted
    Given cid in cluster_status
    Given the cluster modification has completed
    Given the EventBridge event bus has been deleted
    When a cluster modification begins but event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster modification begins and DocumentDB delivers the event to the EventBridge bus then a DocumentDB cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given the cluster modification has completed
    Given a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus
    When a DocumentDB cluster is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster modification begins but event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given cid in cluster_status
    Given the cluster modification has completed
    Given a cluster modification has begun but event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists
