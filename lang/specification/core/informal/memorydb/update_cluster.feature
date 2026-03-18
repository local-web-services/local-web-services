@memorydb @generated
Feature: Memorydb - A Memorydb Cluster Configuration Is Updated

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @update_cluster
  Scenario: a MemoryDB cluster configuration is updated
    Given the cluster exists
    And the cluster is "AVAILABLE"
    When a MemoryDB cluster configuration is updated
    Then the cluster is in "MODIFYING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @update_cluster
  Scenario: a MemoryDB cluster configuration is updated fails when the cluster does not exist
    Given the cluster does not exist
    When a MemoryDB cluster configuration is updated
    Then the operation is rejected

  @standard @negative @update_cluster @lifecycle @internal
  Scenario: a MemoryDB cluster configuration is updated fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a MemoryDB cluster configuration is updated
    Then the operation is rejected
