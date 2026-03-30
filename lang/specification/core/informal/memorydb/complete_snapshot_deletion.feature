@memorydb @generated
Feature: Memorydb - A Snapshot Deletion Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_deletion @internal
  Scenario: a snapshot deletion completes
    Given the snapshot exists
    And the snapshot is "DELETING"
    When a snapshot deletion completes
    Then the snapshot is "DELETED" and its tags are removed
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @complete_snapshot_deletion @internal
  Scenario: a snapshot deletion completes fails when the snapshot does not exist
    Given the snapshot does not exist
    When a snapshot deletion completes
    Then the operation is rejected

  @guard @negative @complete_snapshot_deletion @internal
  Scenario: a snapshot deletion completes fails when the snapshot is not "DELETING"
    Given the snapshot exists
    And the snapshot is not "DELETING"
    When a snapshot deletion completes
    Then the operation is rejected
