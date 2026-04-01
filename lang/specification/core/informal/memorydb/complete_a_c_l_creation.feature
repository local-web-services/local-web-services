@memorydb @generated
Feature: Memorydb - An "Memorydb" "Acl" Finishes Creating

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_a_c_l_creation @internal
  Scenario: an "memorydb" "ACL" finishes creating
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was "CREATING"
    When an "memorydb" "ACL" finishes creating
    Then the "memorydb" "ACL" will be "ACTIVE"
    And every active "memorydb" "cluster" has write durability enabled
    And every snapshotting "memorydb" "cluster" has a corresponding in-progress "memorydb" "snapshot"
    And no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"
    And every active "memorydb" "cluster" and "snapshot" has tags

  @guard @negative @complete_a_c_l_creation @internal
  Scenario: an "memorydb" "ACL" finishes creating fails when the "memorydb" "ACL" did not exist
    Given the "memorydb" "ACL" did not exist
    When an "memorydb" "ACL" finishes creating
    Then the operation is rejected

  @guard @negative @complete_a_c_l_creation @internal
  Scenario: an "memorydb" "ACL" finishes creating fails when the "memorydb" "ACL" was not "CREATING"
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was not "CREATING"
    When an "memorydb" "ACL" finishes creating
    Then the operation is rejected
