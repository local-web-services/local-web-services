@memorydb @generated
Feature: Memorydb - Tags Are Removed From A Memorydb Resource

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @untag_resource
  Scenario: tags are removed from a MemoryDB resource
    Given the resource has a tag entry
    And the resource is tagged
    When tags are removed from a MemoryDB resource
    Then the resource tag state is unchanged (no-op model)
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a cluster
    And no user in "DELETING" state is currently a member of an "ACL"
    And every active cluster and snapshot has tags

  @standard @negative @untag_resource
  Scenario: tags are removed from a MemoryDB resource fails when the resource does not have a tag entry
    Given the resource does not have a tag entry
    When tags are removed from a MemoryDB resource
    Then the operation is rejected

  @standard @negative @untag_resource
  Scenario: tags are removed from a MemoryDB resource fails when the resource is not tagged
    Given the resource has a tag entry
    And the resource is not tagged
    When tags are removed from a MemoryDB resource
    Then the operation is rejected
