@memorydb @generated
Feature: Memorydb - A "Memorydb" "Snapshot" Is Deleted

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @delete_snapshot
  Scenario: a "memorydb" "snapshot" is deleted
    Given the "memorydb" "snapshot" existed
    And the "memorydb" "snapshot" was "AVAILABLE"
    When a "memorydb" "snapshot" is deleted
    Then the "memorydb" "snapshot" will be in "DELETING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no user in "DELETING" state is currently a member of an "memorydb" "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @delete_snapshot
  Scenario: a "memorydb" "snapshot" is deleted fails when the "memorydb" "snapshot" did not exist
    Given the "memorydb" "snapshot" did not exist
    When a "memorydb" "snapshot" is deleted
    Then the operation is rejected

  @guard @negative @delete_snapshot @lifecycle
  Scenario: a "memorydb" "snapshot" is deleted fails when the "memorydb" "snapshot" was not "AVAILABLE"
    Given the "memorydb" "snapshot" existed
    And the "memorydb" "snapshot" was not "AVAILABLE"
    When a "memorydb" "snapshot" is deleted
    Then the operation is rejected
