@memorydb @generated
Feature: Memorydb - A "Memorydb" "Cluster" Is Created

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a "memorydb" "cluster" is created
    Given the "memorydb" "cluster" did not already exist
    When a "memorydb" "cluster" is created
    Then the "memorydb" "cluster" will be in "CREATING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no user in "DELETING" state is currently a member of an "memorydb" "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @create_cluster
  Scenario: a "memorydb" "cluster" is created fails when the "memorydb" "cluster" already existed
    Given the "memorydb" "cluster" already existed
    When a "memorydb" "cluster" is created
    Then the operation is rejected
