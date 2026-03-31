@memorydb @generated
Feature: Memorydb - A "Memorydb" "Snapshot" Is Created From An Available "Memorydb" "Cluster"

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @create_snapshot
  Scenario: a "memorydb" "snapshot" is created from an available "memorydb" "cluster"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "AVAILABLE"
    And the "memorydb" "snapshot" slot is available
    When a "memorydb" "snapshot" is created from an available "memorydb" "cluster"
    Then the "memorydb" "snapshot" will be in "CREATING" state and the "memorydb" "cluster" will be "SNAPSHOTTING"
    And every active cluster has write durability enabled
    And every snapshotting cluster has a corresponding in-progress snapshot
    And no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no user in "DELETING" state is currently a member of an "memorydb" "ACL"
    And every active cluster and snapshot has tags

  @guard @negative @create_snapshot
  Scenario: a "memorydb" "snapshot" is created from an available "memorydb" "cluster" fails when the "memorydb" "cluster" did not exist
    Given the "memorydb" "cluster" did not exist
    When a "memorydb" "snapshot" is created from an available "memorydb" "cluster"
    Then the operation is rejected

  @guard @negative @create_snapshot @lifecycle
  Scenario: a "memorydb" "snapshot" is created from an available "memorydb" "cluster" fails when the "memorydb" "cluster" was not "AVAILABLE"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was not "AVAILABLE"
    When a "memorydb" "snapshot" is created from an available "memorydb" "cluster"
    Then the operation is rejected

  @guard @negative @create_snapshot
  Scenario: a "memorydb" "snapshot" is created from an available "memorydb" "cluster" fails when the "memorydb" "snapshot" slot is not available
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "AVAILABLE"
    And the "memorydb" "snapshot" slot is not available
    When a "memorydb" "snapshot" is created from an available "memorydb" "cluster"
    Then the operation is rejected
