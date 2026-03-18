@memorydb @generated
Feature: Memorydb - A User Finishes Creating

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_user_creation @internal
  Scenario: a user finishes creating
    Given the user exists
    And the user is "CREATING"
    When a user finishes creating
    Then the user is "ACTIVE"
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @complete_user_creation @internal
  Scenario: a user finishes creating fails when the user does not exist
    Given the user does not exist
    When a user finishes creating
    Then the operation is rejected

  @standard @negative @complete_user_creation @internal
  Scenario: a user finishes creating fails when the user is not "CREATING"
    Given the user exists
    And the user is not "CREATING"
    When a user finishes creating
    Then the operation is rejected
