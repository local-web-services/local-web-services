@memorydb @generated
Feature: Memorydb - An "Memorydb" "Acl" Is Deleted

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @delete_a_c_l
  Scenario: an "memorydb" "ACL" is deleted
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was "ACTIVE"
    When an "memorydb" "ACL" is deleted
    Then the "memorydb" "ACL" will be in "DELETING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no user in "DELETING" state is currently a member of an "memorydb" "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @delete_a_c_l
  Scenario: an "memorydb" "ACL" is deleted fails when the "memorydb" "ACL" did not exist
    Given the "memorydb" "ACL" did not exist
    When an "memorydb" "ACL" is deleted
    Then the operation is rejected

  @guard @negative @delete_a_c_l @lifecycle
  Scenario: an "memorydb" "ACL" is deleted fails when the "memorydb" "ACL" was not "ACTIVE"
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was not "ACTIVE"
    When an "memorydb" "ACL" is deleted
    Then the operation is rejected
