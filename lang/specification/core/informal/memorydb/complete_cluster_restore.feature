@memorydb @generated
Feature: Memorydb - A "Memorydb" "Cluster" Restore From "Memorydb" "Snapshot" Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_restore @internal
  Scenario: a "memorydb" "cluster" restore from "memorydb" "snapshot" completes
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "RESTORING"
    When a "memorydb" "cluster" restore from "memorydb" "snapshot" completes
    Then the "memorydb" "cluster" will be "AVAILABLE"
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no user in "DELETING" state is currently a member of an "memorydb" "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @complete_cluster_restore @internal
  Scenario: a "memorydb" "cluster" restore from "memorydb" "snapshot" completes fails when the "memorydb" "cluster" did not exist
    Given the "memorydb" "cluster" did not exist
    When a "memorydb" "cluster" restore from "memorydb" "snapshot" completes
    Then the operation is rejected

  @guard @negative @complete_cluster_restore @internal
  Scenario: a "memorydb" "cluster" restore from "memorydb" "snapshot" completes fails when the "memorydb" "cluster" was not "RESTORING"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was not "RESTORING"
    When a "memorydb" "cluster" restore from "memorydb" "snapshot" completes
    Then the operation is rejected
