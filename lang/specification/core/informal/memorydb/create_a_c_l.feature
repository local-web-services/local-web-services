@memorydb @generated
Feature: Memorydb - An Acl Is Created

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @create_a_c_l
  Scenario: an "ACL" is created
    Given the "ACL" does not already exist
    When an "ACL" is created
    Then the "ACL" is in "CREATING" state
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @create_a_c_l
  Scenario: an "ACL" is created fails when the "ACL" already exists
    Given the "ACL" already exists
    When an "ACL" is created
    Then the operation is rejected
