@memorydb @generated
Feature: Memorydb - A Memorydb Cluster Deletion Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_deletion @internal
  Scenario: a MemoryDB cluster deletion completes
    Given the cluster exists
    And the cluster is "DELETING"
    When a MemoryDB cluster deletion completes
    Then the cluster is "DELETED" and its tags are removed
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @complete_cluster_deletion @internal
  Scenario: a MemoryDB cluster deletion completes fails when the cluster does not exist
    Given the cluster does not exist
    When a MemoryDB cluster deletion completes
    Then the operation is rejected

  @guard @negative @complete_cluster_deletion @internal
  Scenario: a MemoryDB cluster deletion completes fails when the cluster is not "DELETING"
    Given the cluster exists
    And the cluster is not "DELETING"
    When a MemoryDB cluster deletion completes
    Then the operation is rejected
