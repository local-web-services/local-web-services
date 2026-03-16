@memorydb @generated
Feature: Memorydb - A Snapshot Is Deleted

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @delete_snapshot
  Scenario: a snapshot is deleted
    Given the snapshot exists
    And the snapshot is "AVAILABLE"
    When a snapshot is deleted
    Then the snapshot is in "DELETING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @delete_snapshot
  Scenario: a snapshot is deleted fails when the snapshot does not exist
    Given the snapshot does not exist
    When a snapshot is deleted
    Then the operation is rejected

  @standard @negative @delete_snapshot @lifecycle
  Scenario: a snapshot is deleted fails when the snapshot is not "AVAILABLE"
    Given the snapshot exists
    And the snapshot is not "AVAILABLE"
    When a snapshot is deleted
    Then the operation is rejected
