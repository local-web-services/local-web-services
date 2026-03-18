@memorydb @generated
Feature: Memorydb - A Cluster Restore From Snapshot Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_restore @internal
  Scenario: a cluster restore from snapshot completes
    Given the cluster exists
    And the cluster is "RESTORING"
    When a cluster restore from snapshot completes
    Then the cluster is "AVAILABLE"
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @complete_cluster_restore @internal
  Scenario: a cluster restore from snapshot completes fails when the cluster does not exist
    Given the cluster does not exist
    When a cluster restore from snapshot completes
    Then the operation is rejected

  @standard @negative @complete_cluster_restore @internal
  Scenario: a cluster restore from snapshot completes fails when the cluster is not "RESTORING"
    Given the cluster exists
    And the cluster is not "RESTORING"
    When a cluster restore from snapshot completes
    Then the operation is rejected
