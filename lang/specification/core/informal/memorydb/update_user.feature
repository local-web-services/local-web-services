@memorydb @generated
Feature: Memorydb - A User Is Updated

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @update_user
  Scenario: a user is updated
    Given the user exists
    And the user is "ACTIVE"
    When a user is updated
    Then the user is in "MODIFYING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @update_user
  Scenario: a user is updated fails when the user does not exist
    Given the user does not exist
    When a user is updated
    Then the operation is rejected

  @guard @negative @update_user @lifecycle
  Scenario: a user is updated fails when the user is not "ACTIVE"
    Given the user exists
    And the user is not "ACTIVE"
    When a user is updated
    Then the operation is rejected
