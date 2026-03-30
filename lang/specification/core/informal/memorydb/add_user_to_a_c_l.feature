@memorydb @generated
Feature: Memorydb - A User Is Added To An Acl

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @add_user_to_a_c_l
  Scenario: a user is added to an "ACL"
    Given the "ACL" exists
    And the "ACL" is "ACTIVE"
    And the user exists
    And the user is "ACTIVE"
    And the user is not already a member of the "ACL"
    When a user is added to an "ACL"
    Then the user is a member of the "ACL"
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @add_user_to_a_c_l
  Scenario: a user is added to an "ACL" fails when the "ACL" does not exist
    Given the "ACL" does not exist
    When a user is added to an "ACL"
    Then the operation is rejected

  @guard @negative @add_user_to_a_c_l @lifecycle
  Scenario: a user is added to an "ACL" fails when the "ACL" is not "ACTIVE"
    Given the "ACL" exists
    And the "ACL" is not "ACTIVE"
    When a user is added to an "ACL"
    Then the operation is rejected

  @guard @negative @add_user_to_a_c_l
  Scenario: a user is added to an "ACL" fails when the user does not exist
    Given the "ACL" exists
    And the "ACL" is "ACTIVE"
    And the user does not exist
    When a user is added to an "ACL"
    Then the operation is rejected

  @guard @negative @add_user_to_a_c_l @lifecycle
  Scenario: a user is added to an "ACL" fails when the user is not "ACTIVE"
    Given the "ACL" exists
    And the "ACL" is "ACTIVE"
    And the user exists
    And the user is not "ACTIVE"
    When a user is added to an "ACL"
    Then the operation is rejected

  @guard @negative @add_user_to_a_c_l
  Scenario: a user is added to an "ACL" fails when the user is already a member of the "ACL"
    Given the "ACL" exists
    And the "ACL" is "ACTIVE"
    And the user exists
    And the user is "ACTIVE"
    And the user is already a member of the "ACL"
    When a user is added to an "ACL"
    Then the operation is rejected
