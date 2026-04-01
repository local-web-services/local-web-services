@memorydb @generated
Feature: Memorydb - A "Memorydb" "Snapshot" Deletion Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_deletion @internal
  Scenario: a "memorydb" "snapshot" deletion completes
    Given the "memorydb" "snapshot" existed
    And the "memorydb" "snapshot" was "DELETING"
    When a "memorydb" "snapshot" deletion completes
    Then the "memorydb" "snapshot" will be "DELETED" and its tags will be removed
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no user in "DELETING" state is currently a member of an "memorydb" "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @complete_snapshot_deletion @internal
  Scenario: a "memorydb" "snapshot" deletion completes fails when the "memorydb" "snapshot" did not exist
    Given the "memorydb" "snapshot" did not exist
    When a "memorydb" "snapshot" deletion completes
    Then the operation is rejected

  @guard @negative @complete_snapshot_deletion @internal
  Scenario: a "memorydb" "snapshot" deletion completes fails when the "memorydb" "snapshot" was not "DELETING"
    Given the "memorydb" "snapshot" existed
    And the "memorydb" "snapshot" was not "DELETING"
    When a "memorydb" "snapshot" deletion completes
    Then the operation is rejected
