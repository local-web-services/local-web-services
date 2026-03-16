@memorydb @generated
Feature: Memorydb - A Snapshot Finishes Creating

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_creation @internal
  Scenario: a snapshot finishes creating
    Given the snapshot exists
    And the snapshot is "CREATING"
    And the cluster exists
    And the snapshot belongs to this cluster
    And the cluster is "SNAPSHOTTING"
    When a snapshot finishes creating
    Then the snapshot is "AVAILABLE" and the cluster returns to "AVAILABLE" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @complete_snapshot_creation @internal
  Scenario: a snapshot finishes creating fails when the snapshot does not exist
    Given the snapshot does not exist
    When a snapshot finishes creating
    Then the operation is rejected

  @standard @negative @complete_snapshot_creation @internal
  Scenario: a snapshot finishes creating fails when the snapshot is not "CREATING"
    Given the snapshot exists
    And the snapshot is not "CREATING"
    When a snapshot finishes creating
    Then the operation is rejected

  @standard @negative @complete_snapshot_creation @internal
  Scenario: a snapshot finishes creating fails when the cluster does not exist
    Given the snapshot exists
    And the snapshot is "CREATING"
    And the cluster does not exist
    When a snapshot finishes creating
    Then the operation is rejected

  @standard @negative @complete_snapshot_creation @internal
  Scenario: a snapshot finishes creating fails when the snapshot does not belong to this cluster
    Given the snapshot exists
    And the snapshot is "CREATING"
    And the cluster exists
    And the snapshot does not belong to this cluster
    When a snapshot finishes creating
    Then the operation is rejected

  @standard @negative @complete_snapshot_creation @internal
  Scenario: a snapshot finishes creating fails when the cluster is not "SNAPSHOTTING"
    Given the snapshot exists
    And the snapshot is "CREATING"
    And the cluster exists
    And the snapshot belongs to this cluster
    And the cluster is not "SNAPSHOTTING"
    When a snapshot finishes creating
    Then the operation is rejected
