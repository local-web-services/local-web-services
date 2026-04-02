@memorydb @generated
Feature: Memorydb - An "Memorydb" "Acl" Is Created

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @create_a_c_l
  Scenario: an "memorydb" "ACL" is created
    Given the "memorydb" "ACL" did not already exist
    When an "memorydb" "ACL" is created
    Then the "memorydb" "ACL" will be in "CREATING" state
    And every active "memorydb" "cluster" has write durability enabled
    And every snapshotting "memorydb" "cluster" has a corresponding in-progress "memorydb" "snapshot"
    And no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"
    And every active "memorydb" "cluster" and "snapshot" has tags

  @guard @negative @create_a_c_l
  Scenario: an "memorydb" "ACL" is created fails when the "memorydb" "ACL" already existed
    Given the "memorydb" "ACL" already existed
    When an "memorydb" "ACL" is created
    Then the operation is rejected
