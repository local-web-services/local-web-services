@memorydb @generated
Feature: Memorydb - A "Memorydb" "User" Is Deleted

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @delete_user
  Scenario: a "memorydb" "user" is deleted
    Given the "memorydb" "user" existed
    And the "memorydb" "user" was "ACTIVE"
    When a "memorydb" "user" is deleted
    Then the "memorydb" "user" will be in "DELETING" state
    And every active "memorydb" "cluster" has write durability enabled
    And every snapshotting "memorydb" "cluster" has a corresponding in-progress "memorydb" "snapshot"
    And no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"
    And every active "memorydb" "cluster" and "snapshot" has tags

  @guard @negative @delete_user
  Scenario: a "memorydb" "user" is deleted fails when the "memorydb" "user" did not exist
    Given the "memorydb" "user" did not exist
    When a "memorydb" "user" is deleted
    Then the operation is rejected

  @guard @negative @delete_user @lifecycle
  Scenario: a "memorydb" "user" is deleted fails when the "memorydb" "user" was not "ACTIVE"
    Given the "memorydb" "user" existed
    And the "memorydb" "user" was not "ACTIVE"
    When a "memorydb" "user" is deleted
    Then the operation is rejected
