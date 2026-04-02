@memorydb @generated
Feature: Memorydb - An "Memorydb" "Acl" Is Associated With A "Memorydb" "Cluster"

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @associate_a_c_l_with_cluster
  Scenario: an "memorydb" "ACL" is associated with a "memorydb" "cluster"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "AVAILABLE"
    And the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was "ACTIVE"
    When an "memorydb" "ACL" is associated with a "memorydb" "cluster"
    Then the "memorydb" "cluster" will be linked to the active "ACL"
    And every active "memorydb" "cluster" has write durability enabled
    And every snapshotting "memorydb" "cluster" has a corresponding in-progress "memorydb" "snapshot"
    And no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"
    And every active "memorydb" "cluster" and "snapshot" has tags

  @guard @negative @associate_a_c_l_with_cluster
  Scenario: an "memorydb" "ACL" is associated with a "memorydb" "cluster" fails when the "memorydb" "cluster" did not exist
    Given the "memorydb" "cluster" did not exist
    When an "memorydb" "ACL" is associated with a "memorydb" "cluster"
    Then the operation is rejected

  @guard @negative @associate_a_c_l_with_cluster @lifecycle
  Scenario: an "memorydb" "ACL" is associated with a "memorydb" "cluster" fails when the "memorydb" "cluster" was not "AVAILABLE"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was not "AVAILABLE"
    When an "memorydb" "ACL" is associated with a "memorydb" "cluster"
    Then the operation is rejected

  @guard @negative @associate_a_c_l_with_cluster
  Scenario: an "memorydb" "ACL" is associated with a "memorydb" "cluster" fails when the "memorydb" "ACL" did not exist
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "AVAILABLE"
    And the "memorydb" "ACL" did not exist
    When an "memorydb" "ACL" is associated with a "memorydb" "cluster"
    Then the operation is rejected

  @guard @negative @associate_a_c_l_with_cluster @lifecycle
  Scenario: an "memorydb" "ACL" is associated with a "memorydb" "cluster" fails when the "memorydb" "ACL" was not "ACTIVE"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "AVAILABLE"
    And the "memorydb" "ACL" existed
    And the "memorydb" "ACL" was not "ACTIVE"
    When an "memorydb" "ACL" is associated with a "memorydb" "cluster"
    Then the operation is rejected
