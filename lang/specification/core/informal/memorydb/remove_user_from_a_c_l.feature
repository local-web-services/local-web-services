@memorydb @generated
Feature: Memorydb - A User Is Removed From An Acl

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @remove_user_from_a_c_l
  Scenario: a user is removed from an "ACL"
    Given the "ACL" exists
    And the "ACL" is "ACTIVE"
    And the user membership entry exists
    And the user is a member of the "ACL"
    When a user is removed from an "ACL"
    Then the user is no longer a member of the "ACL"
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @remove_user_from_a_c_l
  Scenario: a user is removed from an "ACL" fails when the "ACL" does not exist
    Given the "ACL" does not exist
    When a user is removed from an "ACL"
    Then the operation is rejected

  @standard @negative @remove_user_from_a_c_l @lifecycle @internal
  Scenario: a user is removed from an "ACL" fails when the "ACL" is not "ACTIVE"
    Given the "ACL" exists
    And the "ACL" is not "ACTIVE"
    When a user is removed from an "ACL"
    Then the operation is rejected

  @standard @negative @remove_user_from_a_c_l
  Scenario: a user is removed from an "ACL" fails when the user membership entry does not exist
    Given the "ACL" exists
    And the "ACL" is "ACTIVE"
    And the user membership entry does not exist
    When a user is removed from an "ACL"
    Then the operation is rejected

  @standard @negative @remove_user_from_a_c_l @internal
  Scenario: a user is removed from an "ACL" fails when the user is not a member of the "ACL"
    Given the "ACL" exists
    And the "ACL" is "ACTIVE"
    And the user membership entry exists
    And the user is not a member of the "ACL"
    When a user is removed from an "ACL"
    Then the operation is rejected
