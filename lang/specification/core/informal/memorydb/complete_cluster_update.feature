@memorydb @generated
Feature: Memorydb - A Memorydb Cluster Update Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_update @internal
  Scenario: a MemoryDB cluster update completes
    Given the cluster exists
    And the cluster is "MODIFYING"
    When a MemoryDB cluster update completes
    Then the cluster returns to "AVAILABLE" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @complete_cluster_update @internal
  Scenario: a MemoryDB cluster update completes fails when the cluster does not exist
    Given the cluster does not exist
    When a MemoryDB cluster update completes
    Then the operation is rejected

  @guard @negative @complete_cluster_update @internal
  Scenario: a MemoryDB cluster update completes fails when the cluster is not "MODIFYING"
    Given the cluster exists
    And the cluster is not "MODIFYING"
    When a MemoryDB cluster update completes
    Then the operation is rejected
