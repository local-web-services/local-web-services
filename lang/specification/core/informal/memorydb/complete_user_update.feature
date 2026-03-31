@memorydb @generated
Feature: Memorydb - A "Memorydb" "User" Update Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_user_update @internal
  Scenario: a "memorydb" "user" update completes
    Given the "memorydb" "user" existed
    And the "memorydb" "user" was "MODIFYING"
    When a "memorydb" "user" update completes
    Then the "memorydb" "user" returns to "ACTIVE" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no user in "DELETING" state is currently a member of an "memorydb" "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @complete_user_update @internal
  Scenario: a "memorydb" "user" update completes fails when the "memorydb" "user" did not exist
    Given the "memorydb" "user" did not exist
    When a "memorydb" "user" update completes
    Then the operation is rejected

  @guard @negative @complete_user_update @internal
  Scenario: a "memorydb" "user" update completes fails when the "memorydb" "user" was not "MODIFYING"
    Given the "memorydb" "user" existed
    And the "memorydb" "user" was not "MODIFYING"
    When a "memorydb" "user" update completes
    Then the operation is rejected
