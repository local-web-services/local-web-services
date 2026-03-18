@memorydb @generated
Feature: Memorydb - A Shard Failover Is Triggered On A Multi-Az Cluster

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @failover_shard @internal
  Scenario: a shard failover is triggered on a multi-"AZ" cluster
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And multi-"AZ" is enabled for the cluster
    When a shard failover is triggered on a multi-"AZ" cluster
    Then the cluster remains "AVAILABLE" after the shard failover
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @failover_shard @internal
  Scenario: a shard failover is triggered on a multi-"AZ" cluster fails when the cluster does not exist
    Given the cluster does not exist
    When a shard failover is triggered on a multi-"AZ" cluster
    Then the operation is rejected

  @standard @negative @failover_shard @internal
  Scenario: a shard failover is triggered on a multi-"AZ" cluster fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a shard failover is triggered on a multi-"AZ" cluster
    Then the operation is rejected

  @standard @negative @failover_shard @internal
  Scenario: a shard failover is triggered on a multi-"AZ" cluster fails when multi-"AZ" is not enabled for the cluster
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And multi-"AZ" is not enabled for the cluster
    When a shard failover is triggered on a multi-"AZ" cluster
    Then the operation is rejected
