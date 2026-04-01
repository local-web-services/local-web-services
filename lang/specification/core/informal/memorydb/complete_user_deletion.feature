@memorydb @generated
Feature: Memorydb - A "Memorydb" "User" Deletion Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_user_deletion @internal
  Scenario: a "memorydb" "user" deletion completes
    Given the "memorydb" "user" existed
    And the "memorydb" "user" was "DELETING"
    When a "memorydb" "user" deletion completes
    Then the "memorydb" "user" will be deleted
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no user in "DELETING" state is currently a member of an "memorydb" "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @complete_user_deletion @internal
  Scenario: a "memorydb" "user" deletion completes fails when the "memorydb" "user" did not exist
    Given the "memorydb" "user" did not exist
    When a "memorydb" "user" deletion completes
    Then the operation is rejected

  @guard @negative @complete_user_deletion @internal
  Scenario: a "memorydb" "user" deletion completes fails when the "memorydb" "user" was not "DELETING"
    Given the "memorydb" "user" existed
    And the "memorydb" "user" was not "DELETING"
    When a "memorydb" "user" deletion completes
    Then the operation is rejected
