@memorydb @generated
Feature: Memorydb - A "Memorydb" "User" Is Removed From An "Memorydb" "Acl"

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @remove_user_from_a_c_l
  Scenario: a "memorydb" "user" is removed from an "memorydb" "ACL"
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was "ACTIVE"
    And the "memorydb" "user" membership entry existed
    And the "memorydb" "user" was a member of the "memorydb" "ACL"
    When a "memorydb" "user" is removed from an "memorydb" "ACL"
    Then the memorydb user will no longer be a member of the "memorydb" "ACL"
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no user in "DELETING" state is currently a member of an "memorydb" "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @remove_user_from_a_c_l
  Scenario: a "memorydb" "user" is removed from an "memorydb" "ACL" fails when the "memorydb" "ACL" did not exist
    Given the "memorydb" "ACL" did not exist
    When a "memorydb" "user" is removed from an "memorydb" "ACL"
    Then the operation is rejected

  @guard @negative @remove_user_from_a_c_l @lifecycle
  Scenario: a "memorydb" "user" is removed from an "memorydb" "ACL" fails when the "memorydb" "ACL" was not "ACTIVE"
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was not "ACTIVE"
    When a "memorydb" "user" is removed from an "memorydb" "ACL"
    Then the operation is rejected

  @guard @negative @remove_user_from_a_c_l
  Scenario: a "memorydb" "user" is removed from an "memorydb" "ACL" fails when the "memorydb" "user" membership entry did not exist
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was "ACTIVE"
    And the "memorydb" "user" membership entry did not exist
    When a "memorydb" "user" is removed from an "memorydb" "ACL"
    Then the operation is rejected

  @guard @negative @remove_user_from_a_c_l
  Scenario: a "memorydb" "user" is removed from an "memorydb" "ACL" fails when the "memorydb" "user" was not a member of the "memorydb" "ACL"
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was "ACTIVE"
    And the "memorydb" "user" membership entry existed
    And the "memorydb" "user" was not a member of the "memorydb" "ACL"
    When a "memorydb" "user" is removed from an "memorydb" "ACL"
    Then the operation is rejected
