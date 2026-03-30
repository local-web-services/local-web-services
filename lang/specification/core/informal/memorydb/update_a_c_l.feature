@memorydb @generated
Feature: Memorydb - An Acl Is Updated

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @update_a_c_l
  Scenario: an "ACL" is updated
    Given the "ACL" exists
    And the "ACL" is "ACTIVE"
    When an "ACL" is updated
    Then the "ACL" is in "MODIFYING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @update_a_c_l
  Scenario: an "ACL" is updated fails when the "ACL" does not exist
    Given the "ACL" does not exist
    When an "ACL" is updated
    Then the operation is rejected

  @guard @negative @update_a_c_l @lifecycle
  Scenario: an "ACL" is updated fails when the "ACL" is not "ACTIVE"
    Given the "ACL" exists
    And the "ACL" is not "ACTIVE"
    When an "ACL" is updated
    Then the operation is rejected
