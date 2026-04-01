@memorydb @generated
Feature: Memorydb - An "Memorydb" "Acl" Is Updated

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @update_a_c_l
  Scenario: an "memorydb" "ACL" is updated
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was "ACTIVE"
    When an "memorydb" "ACL" is updated
    Then the "memorydb" "ACL" will be in "MODIFYING" state
    And every active "memorydb" "cluster" has write durability enabled
    And every snapshotting "memorydb" "cluster" has a corresponding in-progress "memorydb" "snapshot"
    And no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"
    And every active "memorydb" "cluster" and "snapshot" has tags

  @guard @negative @update_a_c_l
  Scenario: an "memorydb" "ACL" is updated fails when the "memorydb" "ACL" did not exist
    Given the "memorydb" "ACL" did not exist
    When an "memorydb" "ACL" is updated
    Then the operation is rejected

  @guard @negative @update_a_c_l @lifecycle
  Scenario: an "memorydb" "ACL" is updated fails when the "memorydb" "ACL" was not "ACTIVE"
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was not "ACTIVE"
    When an "memorydb" "ACL" is updated
    Then the operation is rejected
