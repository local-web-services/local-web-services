@memorydb @generated
Feature: Memorydb - A "Memorydb" "Cluster" Is Deleted

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @delete_cluster
  Scenario: a "memorydb" "cluster" is deleted
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "AVAILABLE"
    When a "memorydb" "cluster" is deleted
    Then the "memorydb" "cluster" will be in "DELETING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no user in "DELETING" state is currently a member of an "memorydb" "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @delete_cluster
  Scenario: a "memorydb" "cluster" is deleted fails when the "memorydb" "cluster" did not exist
    Given the "memorydb" "cluster" did not exist
    When a "memorydb" "cluster" is deleted
    Then the operation is rejected

  @guard @negative @delete_cluster @lifecycle
  Scenario: a "memorydb" "cluster" is deleted fails when the "memorydb" "cluster" was not "AVAILABLE"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was not "AVAILABLE"
    When a "memorydb" "cluster" is deleted
    Then the operation is rejected
