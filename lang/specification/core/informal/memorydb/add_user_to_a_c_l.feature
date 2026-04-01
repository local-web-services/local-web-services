@memorydb @generated
Feature: Memorydb - A "Memorydb" "User" Is Added To An "Memorydb" "Acl"

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @add_user_to_a_c_l
  Scenario: a "memorydb" "user" is added to an "memorydb" "ACL"
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was "ACTIVE"
    And the "memorydb" "user" existed
    And the "memorydb" "user" was "ACTIVE"
    And the "memorydb" "user" was not already a member of the "memorydb" "ACL"
    When a "memorydb" "user" is added to an "memorydb" "ACL"
    Then the "memorydb" "user" will be a member of the "memorydb" "ACL"
    And every active "memorydb" "cluster" has write durability enabled
    And every snapshotting "memorydb" "cluster" has a corresponding in-progress "memorydb" "snapshot"
    And no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"
    And every active "memorydb" "cluster" and "snapshot" has tags

  @guard @negative @add_user_to_a_c_l
  Scenario: a "memorydb" "user" is added to an "memorydb" "ACL" fails when the "memorydb" "ACL" did not exist
    Given the "memorydb" "ACL" did not exist
    When a "memorydb" "user" is added to an "memorydb" "ACL"
    Then the operation is rejected

  @guard @negative @add_user_to_a_c_l @lifecycle
  Scenario: a "memorydb" "user" is added to an "memorydb" "ACL" fails when the "memorydb" "ACL" was not "ACTIVE"
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was not "ACTIVE"
    When a "memorydb" "user" is added to an "memorydb" "ACL"
    Then the operation is rejected

  @guard @negative @add_user_to_a_c_l
  Scenario: a "memorydb" "user" is added to an "memorydb" "ACL" fails when the "memorydb" "user" did not exist
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was "ACTIVE"
    And the "memorydb" "user" did not exist
    When a "memorydb" "user" is added to an "memorydb" "ACL"
    Then the operation is rejected

  @guard @negative @add_user_to_a_c_l @lifecycle
  Scenario: a "memorydb" "user" is added to an "memorydb" "ACL" fails when the "memorydb" "user" was not "ACTIVE"
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was "ACTIVE"
    And the "memorydb" "user" existed
    And the "memorydb" "user" was not "ACTIVE"
    When a "memorydb" "user" is added to an "memorydb" "ACL"
    Then the operation is rejected

  @guard @negative @add_user_to_a_c_l
  Scenario: a "memorydb" "user" is added to an "memorydb" "ACL" fails when the "memorydb" "user" is already a member of the "memorydb" "ACL"
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was "ACTIVE"
    And the "memorydb" "user" existed
    And the "memorydb" "user" was "ACTIVE"
    And the "memorydb" "user" is already a member of the "memorydb" "ACL"
    When a "memorydb" "user" is added to an "memorydb" "ACL"
    Then the operation is rejected
