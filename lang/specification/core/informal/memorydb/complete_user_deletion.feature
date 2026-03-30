@memorydb @generated
Feature: Memorydb - A User Deletion Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_user_deletion @internal
  Scenario: a user deletion completes
    Given the user exists
    And the user is "DELETING"
    When a user deletion completes
    Then the user is "DELETED"
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @complete_user_deletion @internal
  Scenario: a user deletion completes fails when the user does not exist
    Given the user does not exist
    When a user deletion completes
    Then the operation is rejected

  @guard @negative @complete_user_deletion @internal
  Scenario: a user deletion completes fails when the user is not "DELETING"
    Given the user exists
    And the user is not "DELETING"
    When a user deletion completes
    Then the operation is rejected
