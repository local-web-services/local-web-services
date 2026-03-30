@memorydb @generated
Feature: Memorydb - A User Is Created

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @create_user
  Scenario: a user is created
    Given the user does not already exist
    When a user is created
    Then the user is in "CREATING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @create_user
  Scenario: a user is created fails when the user already exists
    Given the user already exists
    When a user is created
    Then the operation is rejected
