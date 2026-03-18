@memorydb @generated
Feature: Memorydb - A User Is Deleted

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @delete_user
  Scenario: a user is deleted
    Given the user exists
    And the user is "ACTIVE"
    When a user is deleted
    Then the user is in "DELETING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @delete_user
  Scenario: a user is deleted fails when the user does not exist
    Given the user does not exist
    When a user is deleted
    Then the operation is rejected

  @standard @negative @delete_user @lifecycle @internal
  Scenario: a user is deleted fails when the user is not "ACTIVE"
    Given the user exists
    And the user is not "ACTIVE"
    When a user is deleted
    Then the operation is rejected
