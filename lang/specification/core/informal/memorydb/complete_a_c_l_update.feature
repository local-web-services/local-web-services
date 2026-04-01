@memorydb @generated
Feature: Memorydb - An "Memorydb" "Acl" Update Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_a_c_l_update @internal
  Scenario: an "memorydb" "ACL" update completes
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was "MODIFYING"
    When an "memorydb" "ACL" update completes
    Then the "memorydb" "ACL" returns to "ACTIVE" state
    And every active "memorydb" "cluster" has write durability enabled
    And every snapshotting "memorydb" "cluster" has a corresponding in-progress "memorydb" "snapshot"
    And no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"
    And every active "memorydb" "cluster" and "snapshot" has tags

  @guard @negative @complete_a_c_l_update @internal
  Scenario: an "memorydb" "ACL" update completes fails when the "memorydb" "ACL" did not exist
    Given the "memorydb" "ACL" did not exist
    When an "memorydb" "ACL" update completes
    Then the operation is rejected

  @guard @negative @complete_a_c_l_update @internal
  Scenario: an "memorydb" "ACL" update completes fails when the "memorydb" "ACL" was not "MODIFYING"
    Given the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was not "MODIFYING"
    When an "memorydb" "ACL" update completes
    Then the operation is rejected
