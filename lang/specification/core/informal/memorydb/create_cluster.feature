@memorydb @generated
Feature: Memorydb - A Memorydb Cluster Is Created

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a MemoryDB cluster is created
    Given the cluster does not already exist
    When a MemoryDB cluster is created
    Then the cluster is in "CREATING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @create_cluster
  Scenario: a MemoryDB cluster is created fails when the cluster already exists
    Given the cluster already exists
    When a MemoryDB cluster is created
    Then the operation is rejected
