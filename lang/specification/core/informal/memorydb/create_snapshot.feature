@memorydb @generated
Feature: Memorydb - A Snapshot Is Created From An Available Cluster

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @create_snapshot
  Scenario: a snapshot is created from an available cluster
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the snapshot slot is available
    When a snapshot is created from an available cluster
    Then the snapshot is in "CREATING" state and the cluster is "SNAPSHOTTING"
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @create_snapshot
  Scenario: a snapshot is created from an available cluster fails when the cluster does not exist
    Given the cluster does not exist
    When a snapshot is created from an available cluster
    Then the operation is rejected

  @standard @negative @create_snapshot @lifecycle
  Scenario: a snapshot is created from an available cluster fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a snapshot is created from an available cluster
    Then the operation is rejected

  @standard @negative @internal @create_snapshot
  Scenario: a snapshot is created from an available cluster fails when the snapshot slot is not available
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the snapshot slot is not available
    When a snapshot is created from an available cluster
    Then the operation is rejected
