@memorydb @generated
Feature: Memorydb - An Acl Is Associated With A Cluster

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @associate_a_c_l_with_cluster
  Scenario: an "ACL" is associated with a cluster
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the "ACL" exists
    And the "ACL" is "ACTIVE"
    When an "ACL" is associated with a cluster
    Then the cluster is linked to the active "ACL"
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @associate_a_c_l_with_cluster
  Scenario: an "ACL" is associated with a cluster fails when the cluster does not exist
    Given the cluster does not exist
    When an "ACL" is associated with a cluster
    Then the operation is rejected

  @standard @negative @associate_a_c_l_with_cluster @lifecycle
  Scenario: an "ACL" is associated with a cluster fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When an "ACL" is associated with a cluster
    Then the operation is rejected

  @standard @negative @associate_a_c_l_with_cluster
  Scenario: an "ACL" is associated with a cluster fails when the "ACL" does not exist
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the "ACL" does not exist
    When an "ACL" is associated with a cluster
    Then the operation is rejected

  @standard @negative @associate_a_c_l_with_cluster @lifecycle
  Scenario: an "ACL" is associated with a cluster fails when the "ACL" is not "ACTIVE"
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the "ACL" exists
    And the "ACL" is not "ACTIVE"
    When an "ACL" is associated with a cluster
    Then the operation is rejected
