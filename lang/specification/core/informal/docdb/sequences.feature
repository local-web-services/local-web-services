@docdb @generated
Feature: Docdb - Action Sequences

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" finishes creating
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" creation fails
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" configuration is modified
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" modification completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" is deleted
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" deletion completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "instance" finishes creating
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "instance" configuration is modified
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "instance" modification completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "instance" is deleted
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "instance" deletion completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" documentdb snapshot is created
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" is created
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" creation fails
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "instance" is created in an available documentdb cluster
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "instance" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "instance" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "instance" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "instance" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" documentdb snapshot is created
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" documentdb snapshot is deleted
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" is created
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" creation fails
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "instance" is created in an available documentdb cluster
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "instance" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "instance" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "instance" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "instance" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" documentdb snapshot is created
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" documentdb snapshot is deleted
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" is created
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" creation fails
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "instance" is created in an available documentdb cluster
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "instance" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "instance" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "instance" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "instance" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" documentdb snapshot is created
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" documentdb snapshot is deleted
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" is created
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" creation fails
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "instance" is created in an available documentdb cluster
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "instance" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "instance" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "instance" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "instance" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" documentdb snapshot is created
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" documentdb snapshot is deleted
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" is created
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" creation fails
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "instance" is created in an available documentdb cluster
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "instance" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "instance" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "instance" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "instance" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot is created
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot is deleted
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" creation fails
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" is created in an available documentdb cluster
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" documentdb snapshot is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" documentdb snapshot is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" creation fails
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" is created in an available documentdb cluster
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" documentdb snapshot is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" creation fails
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" is created in an available documentdb cluster
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" documentdb snapshot is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" documentdb snapshot is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" creation fails
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" is created in an available documentdb cluster
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" documentdb snapshot is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" documentdb snapshot is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" creation fails
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" creation fails then a "documentdb" "cluster" configuration is modified
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" modification completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" is deleted
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" deletion completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" deletion completes then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" finishes creating
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "instance" finishes creating then a "documentdb" "instance" configuration is modified
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "instance" configuration is modified then a "documentdb" "instance" modification completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "instance" modification completes then a "documentdb" "instance" is deleted
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "instance" is deleted then a "documentdb" "instance" deletion completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot is created
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" finishes creating
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" is created then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" creation fails then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" is deleted then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" deletion completes then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "instance" finishes creating then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "instance" configuration is modified then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "instance" modification completes then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "instance" is deleted then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" is created then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" modification completes then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" is deleted then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" deletion completes then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "instance" finishes creating then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "instance" configuration is modified then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "instance" modification completes then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "instance" is deleted then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" creation fails then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" is created then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" creation fails then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" modification completes then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" is deleted then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" deletion completes then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" finishes creating then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" modification completes then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" is deleted then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" is created then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" finishes creating then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" creation fails then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" is deleted then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" deletion completes then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "instance" finishes creating then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "instance" modification completes then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "instance" is deleted then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" modification completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" is created then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" finishes creating then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" creation fails then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" modification completes then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" deletion completes then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "instance" finishes creating then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "instance" modification completes then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "instance" is deleted then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is deleted then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" is created then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" finishes creating then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" creation fails then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" modification completes then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "instance" finishes creating then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "instance" modification completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "instance" is deleted then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" is created then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" finishes creating then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" creation fails then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" configuration is modified then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" finishes creating then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" modification completes then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" is deleted then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" is created then a "documentdb" "instance" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" finishes creating then a "documentdb" "instance" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" creation fails then a "documentdb" "instance" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" documentdb snapshot is created
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" documentdb snapshot is deleted
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "instance" modification completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "instance" is deleted then a "documentdb" "cluster" is created
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" creation fails
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" is created in an available documentdb cluster
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" finishes creating then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" is created then a "documentdb" "instance" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" finishes creating then a "documentdb" "instance" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" creation fails then a "documentdb" "cluster" documentdb snapshot is created
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" documentdb snapshot is deleted
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "instance" finishes creating then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "instance" modification completes then a "documentdb" "cluster" is created
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "instance" is deleted then a "documentdb" "cluster" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" creation fails
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" is created in an available documentdb cluster
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" is created then a "documentdb" "instance" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" is created
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" documentdb snapshot is created
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" creation fails then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" documentdb snapshot is deleted
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "instance" finishes creating then a "documentdb" "cluster" is created
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "instance" is deleted then a "documentdb" "cluster" creation fails
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" is created in an available documentdb cluster
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" modification completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" is created then a "documentdb" "cluster" documentdb snapshot is created
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" creation fails then a "documentdb" "cluster" documentdb snapshot is deleted
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" is created
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "instance" finishes creating then a "documentdb" "cluster" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" creation fails
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "instance" modification completes then a "documentdb" "cluster" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" is created in an available documentdb cluster
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" is deleted then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" is created then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" documentdb snapshot is deleted
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" creation fails then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" is created
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "instance" finishes creating then a "documentdb" "cluster" creation fails
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "instance" modification completes then a "documentdb" "cluster" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "instance" is deleted then a "documentdb" "cluster" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" deletion completes
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" is created in an available documentdb cluster
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" finishes creating
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" configuration is modified
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" modification completes
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" is deleted
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "instance" deletion completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" documentdb snapshot is created
    Given iid in instance_status
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" is created then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" creation fails then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" finishes creating then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" modification completes then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" is deleted then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" deletion completes then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" is created then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" creation fails then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" creation fails
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" finishes creating then a "documentdb" "cluster" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" modification completes then a "documentdb" "cluster" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" modification completes
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" is deleted then a "documentdb" "instance" is created in an available documentdb cluster
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" deletion completes then a "documentdb" "instance" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" documentdb snapshot is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" documentdb snapshot is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" is created then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" creation fails then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" creation fails
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" finishes creating then a "documentdb" "cluster" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" configuration is modified then a "documentdb" "cluster" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" modification completes then a "documentdb" "instance" is created in an available documentdb cluster
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" is deleted then a "documentdb" "instance" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "instance" deletion completes then a "documentdb" "instance" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" documentdb snapshot is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" is created then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" creation fails then a "documentdb" "cluster" is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" creation fails
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" finishes creating then a "documentdb" "cluster" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" configuration is modified then a "documentdb" "instance" is created in an available documentdb cluster
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" modification completes then a "documentdb" "instance" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" is deleted then a "documentdb" "instance" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "instance" deletion completes then a "documentdb" "instance" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "instance" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" documentdb snapshot is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" documentdb snapshot is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given sid in snapshot_status
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" is created then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" creation fails then a "documentdb" "cluster" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" creation fails
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" deletion completes then a "documentdb" "cluster" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "cluster" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" finishes creating then a "documentdb" "instance" is created in an available documentdb cluster
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" configuration is modified then a "documentdb" "instance" finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" modification completes then a "documentdb" "instance" configuration is modified
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" is deleted then a "documentdb" "instance" modification completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "instance" deletion completes then a "documentdb" "instance" is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "instance" deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" documentdb snapshot is created
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" documentdb snapshot is deleted
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given sid in snapshot_status
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" is created then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" creation fails then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" is deleted then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" deletion completes then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" finishes creating then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" configuration is modified then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" modification completes then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" is deleted then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" is deleted
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" is created then a "documentdb" "cluster" creation fails
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" is created
    When a "documentdb" "cluster" creation fails
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" finishes creating then a "documentdb" "cluster" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" finishes creating
    When a "documentdb" "cluster" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" creation fails then a "documentdb" "cluster" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" creation fails
    When a "documentdb" "cluster" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" configuration is modified then a "documentdb" "cluster" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" configuration is modified
    When a "documentdb" "cluster" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" modification completes then a "documentdb" "cluster" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" modification completes
    When a "documentdb" "cluster" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" is deleted then a "documentdb" "instance" is created in an available documentdb cluster
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" is deleted
    When a "documentdb" "instance" is created in an available documentdb cluster
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" deletion completes then a "documentdb" "instance" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" deletion completes
    When a "documentdb" "instance" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" is created in an available documentdb cluster then a "documentdb" "instance" configuration is modified
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" is created in an available documentdb cluster
    When a "documentdb" "instance" configuration is modified
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" finishes creating then a "documentdb" "instance" modification completes
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" finishes creating
    When a "documentdb" "instance" modification completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" configuration is modified then a "documentdb" "instance" is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" configuration is modified
    When a "documentdb" "instance" is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" modification completes then a "documentdb" "instance" deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" modification completes
    When a "documentdb" "instance" deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" is deleted then a "documentdb" "cluster" documentdb snapshot is created
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" is deleted
    When a "documentdb" "cluster" documentdb snapshot is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "instance" deletion completes then a "documentdb" "cluster" documentdb snapshot finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "instance" deletion completes
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" documentdb snapshot is created then a "documentdb" "cluster" documentdb snapshot is deleted
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" documentdb snapshot is created
    When a "documentdb" "cluster" documentdb snapshot is deleted
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" documentdb snapshot finishes creating then a "documentdb" "cluster" documentdb snapshot deletion completes
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" documentdb snapshot is deleted then a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" documentdb snapshot is deleted
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" documentdb snapshot deletion completes then a "documentdb" "cluster" restore from documentdb snapshot completes
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" is restored from a "documentdb" "snapshot" then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    When a "documentdb" "cluster" is created
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @sequence
  Scenario: a "documentdb" "cluster" failover is triggered and a replica is promoted to primary then a "documentdb" "cluster" restore from documentdb snapshot completes then a "documentdb" "cluster" finishes creating
    Given cid in cluster_status
    When a "documentdb" "cluster" failover is triggered and a replica is promoted to primary
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    When a "documentdb" "cluster" finishes creating
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted
