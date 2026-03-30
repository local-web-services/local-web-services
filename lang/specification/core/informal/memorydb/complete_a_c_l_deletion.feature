@memorydb @generated
Feature: Memorydb - An Acl Deletion Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_a_c_l_deletion @internal
  Scenario: an "ACL" deletion completes
    Given the "ACL" exists
    And the "ACL" is "DELETING"
    When an "ACL" deletion completes
    Then the "ACL" is "DELETED"
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @complete_a_c_l_deletion @internal
  Scenario: an "ACL" deletion completes fails when the "ACL" does not exist
    Given the "ACL" does not exist
    When an "ACL" deletion completes
    Then the operation is rejected

  @guard @negative @complete_a_c_l_deletion @internal
  Scenario: an "ACL" deletion completes fails when the "ACL" is not "DELETING"
    Given the "ACL" exists
    And the "ACL" is not "DELETING"
    When an "ACL" deletion completes
    Then the operation is rejected
