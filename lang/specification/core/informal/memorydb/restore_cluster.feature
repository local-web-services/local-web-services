@memorydb @generated
Feature: Memorydb - A "Memorydb" "Cluster" Is Restored From A "Memorydb" "Snapshot"

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @restore_cluster
  Scenario: a "memorydb" "cluster" is restored from a "memorydb" "snapshot"
    Given the "memorydb" "snapshot" existed
    And the "memorydb" "snapshot" was "AVAILABLE"
    And the target "memorydb" "cluster" slot is available
    When a "memorydb" "cluster" is restored from a "memorydb" "snapshot"
    Then the restored "memorydb" "cluster" will be in "RESTORING" state
    And every active "memorydb" "cluster" has write durability enabled
    And every snapshotting "memorydb" "cluster" has a corresponding in-progress "memorydb" "snapshot"
    And no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"
    And every active "memorydb" "cluster" and "snapshot" has tags

  @guard @negative @restore_cluster
  Scenario: a "memorydb" "cluster" is restored from a "memorydb" "snapshot" fails when the "memorydb" "snapshot" did not exist
    Given the "memorydb" "snapshot" did not exist
    When a "memorydb" "cluster" is restored from a "memorydb" "snapshot"
    Then the operation is rejected

  @guard @negative @restore_cluster @lifecycle
  Scenario: a "memorydb" "cluster" is restored from a "memorydb" "snapshot" fails when the "memorydb" "snapshot" was not "AVAILABLE"
    Given the "memorydb" "snapshot" existed
    And the "memorydb" "snapshot" was not "AVAILABLE"
    When a "memorydb" "cluster" is restored from a "memorydb" "snapshot"
    Then the operation is rejected

  @guard @negative @restore_cluster
  Scenario: a "memorydb" "cluster" is restored from a "memorydb" "snapshot" fails when the target "memorydb" "cluster" slot is not available
    Given the "memorydb" "snapshot" existed
    And the "memorydb" "snapshot" was "AVAILABLE"
    And the target "memorydb" "cluster" slot is not available
    When a "memorydb" "cluster" is restored from a "memorydb" "snapshot"
    Then the operation is rejected
