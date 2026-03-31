@memorydb @generated
Feature: Memorydb - A "Memorydb" "Snapshot" Finishes Creating

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_creation @internal
  Scenario: a "memorydb" "snapshot" finishes creating
    Given the "memorydb" "snapshot" existed
    And the "memorydb" "snapshot" was "CREATING"
    And the "memorydb" "cluster" existed
    And the "memorydb" "snapshot" belongs to this "memorydb" "cluster"
    And the "memorydb" "cluster" was "SNAPSHOTTING"
    When a "memorydb" "snapshot" finishes creating
    Then the "memorydb" "snapshot" will be "AVAILABLE" and the "memorydb" "cluster" returns to "AVAILABLE" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no user in "DELETING" state is currently a member of an "memorydb" "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @complete_snapshot_creation @internal
  Scenario: a "memorydb" "snapshot" finishes creating fails when the "memorydb" "snapshot" did not exist
    Given the "memorydb" "snapshot" did not exist
    When a "memorydb" "snapshot" finishes creating
    Then the operation is rejected

  @guard @negative @complete_snapshot_creation @internal
  Scenario: a "memorydb" "snapshot" finishes creating fails when the "memorydb" "snapshot" was not "CREATING"
    Given the "memorydb" "snapshot" existed
    And the "memorydb" "snapshot" was not "CREATING"
    When a "memorydb" "snapshot" finishes creating
    Then the operation is rejected

  @guard @negative @complete_snapshot_creation @internal
  Scenario: a "memorydb" "snapshot" finishes creating fails when the "memorydb" "cluster" did not exist
    Given the "memorydb" "snapshot" existed
    And the "memorydb" "snapshot" was "CREATING"
    And the "memorydb" "cluster" did not exist
    When a "memorydb" "snapshot" finishes creating
    Then the operation is rejected

  @guard @negative @complete_snapshot_creation @internal
  Scenario: a "memorydb" "snapshot" finishes creating fails when the "memorydb" "snapshot" does not belong to this "memorydb" "cluster"
    Given the "memorydb" "snapshot" existed
    And the "memorydb" "snapshot" was "CREATING"
    And the "memorydb" "cluster" existed
    And the "memorydb" "snapshot" does not belong to this "memorydb" "cluster"
    When a "memorydb" "snapshot" finishes creating
    Then the operation is rejected

  @guard @negative @complete_snapshot_creation @internal
  Scenario: a "memorydb" "snapshot" finishes creating fails when the "memorydb" "cluster" was not "SNAPSHOTTING"
    Given the "memorydb" "snapshot" existed
    And the "memorydb" "snapshot" was "CREATING"
    And the "memorydb" "cluster" existed
    And the "memorydb" "snapshot" belongs to this "memorydb" "cluster"
    And the "memorydb" "cluster" was not "SNAPSHOTTING"
    When a "memorydb" "snapshot" finishes creating
    Then the operation is rejected
