@memorydb @generated
Feature: Memorydb - A "Memorydb" "User" Finishes Creating

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_user_creation @internal
  Scenario: a "memorydb" "user" finishes creating
    Given the "memorydb" "user" existed
    And the "memorydb" "user" was "CREATING"
    When a "memorydb" "user" finishes creating
    Then the "memorydb" "user" will be "ACTIVE"
    And every active "memorydb" "cluster" has write durability enabled
    And every snapshotting "memorydb" "cluster" has a corresponding in-progress "memorydb" "snapshot"
    And no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"
    And every active "memorydb" "cluster" and "snapshot" has tags

  @guard @negative @complete_user_creation @internal
  Scenario: a "memorydb" "user" finishes creating fails when the "memorydb" "user" did not exist
    Given the "memorydb" "user" did not exist
    When a "memorydb" "user" finishes creating
    Then the operation is rejected

  @guard @negative @complete_user_creation @internal
  Scenario: a "memorydb" "user" finishes creating fails when the "memorydb" "user" was not "CREATING"
    Given the "memorydb" "user" existed
    And the "memorydb" "user" was not "CREATING"
    When a "memorydb" "user" finishes creating
    Then the operation is rejected
