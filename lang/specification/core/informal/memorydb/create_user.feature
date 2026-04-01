@memorydb @generated
Feature: Memorydb - A "Memorydb" "User" Is Created

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @create_user
  Scenario: a "memorydb" "user" is created
    Given the "memorydb" "user" did not already exist
    When a "memorydb" "user" is created
    Then the "memorydb" "user" will be in "CREATING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no user in "DELETING" state is currently a member of an "memorydb" "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @create_user
  Scenario: a "memorydb" "user" is created fails when the "memorydb" "user" already existed
    Given the "memorydb" "user" already existed
    When a "memorydb" "user" is created
    Then the operation is rejected
