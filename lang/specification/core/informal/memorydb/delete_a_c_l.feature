@memorydb @generated
Feature: Memorydb - An Acl Is Deleted

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @delete_a_c_l
  Scenario: an "ACL" is deleted
    Given the "ACL" exists
    And the "ACL" is "ACTIVE"
    When an "ACL" is deleted
    Then the "ACL" is in "DELETING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @delete_a_c_l
  Scenario: an "ACL" is deleted fails when the "ACL" does not exist
    Given the "ACL" does not exist
    When an "ACL" is deleted
    Then the operation is rejected

  @standard @negative @delete_a_c_l @lifecycle @internal
  Scenario: an "ACL" is deleted fails when the "ACL" is not "ACTIVE"
    Given the "ACL" exists
    And the "ACL" is not "ACTIVE"
    When an "ACL" is deleted
    Then the operation is rejected
