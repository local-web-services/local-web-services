@memorydb @generated
Feature: Memorydb - Tags Are Added To A "Memorydb" "Resource"

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @tag_resource
  Scenario: tags are added to a "memorydb" "resource"
    Given the "memorydb" "resource" has a tag entry
    And the "memorydb" "resource" was tagged
    When tags are added to a "memorydb" "resource"
    Then the "memorydb" "resource" remains tagged
    And every active "memorydb" "cluster" has write durability enabled
    And every snapshotting "memorydb" "cluster" has a corresponding in-progress "memorydb" "snapshot"
    And no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"
    And every active "memorydb" "cluster" and "snapshot" has tags

  @guard @negative @tag_resource
  Scenario: tags are added to a "memorydb" "resource" fails when the "memorydb" "resource" does not have a tag entry
    Given the "memorydb" "resource" does not have a tag entry
    When tags are added to a "memorydb" "resource"
    Then the operation is rejected

  @guard @negative @tag_resource
  Scenario: tags are added to a "memorydb" "resource" fails when the "memorydb" "resource" was not tagged
    Given the "memorydb" "resource" has a tag entry
    And the "memorydb" "resource" was not tagged
    When tags are added to a "memorydb" "resource"
    Then the operation is rejected
