@memorydb @generated
Feature: Memorydb - A "Memorydb" "Cluster" Deletion Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_deletion @internal
  Scenario: a "memorydb" "cluster" deletion completes
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "DELETING"
    When a "memorydb" "cluster" deletion completes
    Then the "memorydb" "cluster" will be "DELETED" and its tags will be removed
    And every active "memorydb" "cluster" has write durability enabled
    And every snapshotting "memorydb" "cluster" has a corresponding in-progress "memorydb" "snapshot"
    And no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"
    And every active "memorydb" "cluster" and "snapshot" has tags

  @guard @negative @complete_cluster_deletion @internal
  Scenario: a "memorydb" "cluster" deletion completes fails when the "memorydb" "cluster" did not exist
    Given the "memorydb" "cluster" did not exist
    When a "memorydb" "cluster" deletion completes
    Then the operation is rejected

  @guard @negative @complete_cluster_deletion @internal
  Scenario: a "memorydb" "cluster" deletion completes fails when the "memorydb" "cluster" was not "DELETING"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was not "DELETING"
    When a "memorydb" "cluster" deletion completes
    Then the operation is rejected
