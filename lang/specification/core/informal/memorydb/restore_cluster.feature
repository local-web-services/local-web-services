@memorydb @generated
Feature: Memorydb - A Cluster Is Restored From A Snapshot

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @restore_cluster
  Scenario: a cluster is restored from a snapshot
    Given the snapshot exists
    And the snapshot is "AVAILABLE"
    And the target cluster slot is available
    When a cluster is restored from a snapshot
    Then the restored cluster is in "RESTORING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @restore_cluster
  Scenario: a cluster is restored from a snapshot fails when the snapshot does not exist
    Given the snapshot does not exist
    When a cluster is restored from a snapshot
    Then the operation is rejected

  @standard @negative @restore_cluster @lifecycle
  Scenario: a cluster is restored from a snapshot fails when the snapshot is not "AVAILABLE"
    Given the snapshot exists
    And the snapshot is not "AVAILABLE"
    When a cluster is restored from a snapshot
    Then the operation is rejected

  @standard @negative @restore_cluster
  Scenario: a cluster is restored from a snapshot fails when the target cluster slot is not available
    Given the snapshot exists
    And the snapshot is "AVAILABLE"
    And the target cluster slot is not available
    When a cluster is restored from a snapshot
    Then the operation is rejected
