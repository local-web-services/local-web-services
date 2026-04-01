@neptune @generated
Feature: Neptune - A Replica "Neptune" "Instance" Is Promoted To Primary During Failover

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @promote_replica_to_primary @internal
  Scenario: a replica "neptune" "instance" is promoted to primary during failover
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "MODIFYING"
    And the new primary "neptune" "instance" existed
    And the "neptune" "instance" belongs to this neptune cluster
    And the "neptune" "instance" was not already the primary
    And the "neptune" "instance" was "AVAILABLE"
    When a replica "neptune" "instance" is promoted to primary during failover
    Then the "neptune" "cluster" returns to "AVAILABLE" with a new primary neptune instance
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @promote_replica_to_primary @internal
  Scenario: a replica "neptune" "instance" is promoted to primary during failover fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When a replica "neptune" "instance" is promoted to primary during failover
    Then the operation is rejected

  @guard @negative @promote_replica_to_primary @internal
  Scenario: a replica "neptune" "instance" is promoted to primary during failover fails when the "neptune" "cluster" was not "MODIFYING"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "MODIFYING"
    When a replica "neptune" "instance" is promoted to primary during failover
    Then the operation is rejected

  @guard @negative @promote_replica_to_primary @internal
  Scenario: a replica "neptune" "instance" is promoted to primary during failover fails when the new primary "neptune" "instance" did not exist
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "MODIFYING"
    And the new primary "neptune" "instance" did not exist
    When a replica "neptune" "instance" is promoted to primary during failover
    Then the operation is rejected

  @guard @negative @promote_replica_to_primary @internal
  Scenario: a replica "neptune" "instance" is promoted to primary during failover fails when the "neptune" "instance" does not belong to this neptune cluster
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "MODIFYING"
    And the new primary "neptune" "instance" existed
    And the "neptune" "instance" does not belong to this neptune cluster
    When a replica "neptune" "instance" is promoted to primary during failover
    Then the operation is rejected

  @guard @negative @promote_replica_to_primary @internal
  Scenario: a replica "neptune" "instance" is promoted to primary during failover fails when the "neptune" "instance" was already the primary
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "MODIFYING"
    And the new primary "neptune" "instance" existed
    And the "neptune" "instance" belongs to this neptune cluster
    And the "neptune" "instance" was already the primary
    When a replica "neptune" "instance" is promoted to primary during failover
    Then the operation is rejected

  @guard @negative @promote_replica_to_primary @internal
  Scenario: a replica "neptune" "instance" is promoted to primary during failover fails when the "neptune" "instance" was not "AVAILABLE"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "MODIFYING"
    And the new primary "neptune" "instance" existed
    And the "neptune" "instance" belongs to this neptune cluster
    And the "neptune" "instance" was not already the primary
    And the "neptune" "instance" was not "AVAILABLE"
    When a replica "neptune" "instance" is promoted to primary during failover
    Then the operation is rejected
