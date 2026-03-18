@memorydb @generated
Feature: Memorydb - A Memorydb Cluster Finishes Creating

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_creation @internal
  Scenario: a MemoryDB cluster finishes creating
    Given the cluster exists
    And the cluster is "CREATING"
    When a MemoryDB cluster finishes creating
    Then the cluster is "AVAILABLE"
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @complete_cluster_creation @internal
  Scenario: a MemoryDB cluster finishes creating fails when the cluster does not exist
    Given the cluster does not exist
    When a MemoryDB cluster finishes creating
    Then the operation is rejected

  @standard @negative @complete_cluster_creation @internal
  Scenario: a MemoryDB cluster finishes creating fails when the cluster is not "CREATING"
    Given the cluster exists
    And the cluster is not "CREATING"
    When a MemoryDB cluster finishes creating
    Then the operation is rejected
