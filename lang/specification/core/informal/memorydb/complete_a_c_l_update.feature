@memorydb @generated
Feature: Memorydb - An Acl Update Completes

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @complete_a_c_l_update @internal
  Scenario: an "ACL" update completes
    Given the "ACL" exists
    And the "ACL" is "MODIFYING"
    When an "ACL" update completes
    Then the "ACL" returns to "ACTIVE" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @complete_a_c_l_update @internal
  Scenario: an "ACL" update completes fails when the "ACL" does not exist
    Given the "ACL" does not exist
    When an "ACL" update completes
    Then the operation is rejected

  @guard @negative @complete_a_c_l_update @internal
  Scenario: an "ACL" update completes fails when the "ACL" is not "MODIFYING"
    Given the "ACL" exists
    And the "ACL" is not "MODIFYING"
    When an "ACL" update completes
    Then the operation is rejected
