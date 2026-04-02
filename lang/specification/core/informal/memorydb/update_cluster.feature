@memorydb @generated
Feature: Memorydb - A "Memorydb" "Cluster" Configuration Is Updated

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @update_cluster
  Scenario: a "memorydb" "cluster" configuration is updated
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "AVAILABLE"
    When a "memorydb" "cluster" configuration is updated
    Then the "memorydb" "cluster" will be in "MODIFYING" state
    And every active "memorydb" "cluster" has write durability enabled
    And every snapshotting "memorydb" "cluster" has a corresponding in-progress "memorydb" "snapshot"
    And no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"
    And every active "memorydb" "cluster" and "snapshot" has tags

  @guard @negative @update_cluster
  Scenario: a "memorydb" "cluster" configuration is updated fails when the "memorydb" "cluster" did not exist
    Given the "memorydb" "cluster" did not exist
    When a "memorydb" "cluster" configuration is updated
    Then the operation is rejected

  @guard @negative @update_cluster @lifecycle
  Scenario: a "memorydb" "cluster" configuration is updated fails when the "memorydb" "cluster" was not "AVAILABLE"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was not "AVAILABLE"
    When a "memorydb" "cluster" configuration is updated
    Then the operation is rejected
