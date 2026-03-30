@memorydb @generated
Feature: Memorydb - A Memorydb Cluster Is Deleted

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @delete_cluster
  Scenario: a MemoryDB cluster is deleted
    Given the cluster exists
    And the cluster is "AVAILABLE"
    When a MemoryDB cluster is deleted
    Then the cluster is in "DELETING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @delete_cluster
  Scenario: a MemoryDB cluster is deleted fails when the cluster does not exist
    Given the cluster does not exist
    When a MemoryDB cluster is deleted
    Then the operation is rejected

  @guard @negative @delete_cluster @lifecycle
  Scenario: a MemoryDB cluster is deleted fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a MemoryDB cluster is deleted
    Then the operation is rejected
