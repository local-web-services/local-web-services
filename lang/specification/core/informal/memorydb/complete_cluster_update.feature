@memorydb @generated
Feature: Memorydb - A "Memorydb" "Cluster" Update Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_update @internal
  Scenario: a "memorydb" "cluster" update completes
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "MODIFYING"
    When a "memorydb" "cluster" update completes
    Then the "memorydb" "cluster" returns to "AVAILABLE" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no user in "DELETING" state is currently a member of an "memorydb" "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @complete_cluster_update @internal
  Scenario: a "memorydb" "cluster" update completes fails when the "memorydb" "cluster" did not exist
    Given the "memorydb" "cluster" did not exist
    When a "memorydb" "cluster" update completes
    Then the operation is rejected

  @guard @negative @complete_cluster_update @internal
  Scenario: a "memorydb" "cluster" update completes fails when the "memorydb" "cluster" was not "MODIFYING"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was not "MODIFYING"
    When a "memorydb" "cluster" update completes
    Then the operation is rejected
