@memorydb @generated
Feature: Memorydb - A Shard Failover Is Triggered On A Multi-Az "Memorydb" "Cluster"

  # Generated from FizzBee spec: memorydb.fizz
  # Safety invariants: AllClustersHaveDurability, SnapshottingClusterHasSnapshot, ACLNotDeletedWhileInUse, UserNotDeletedWhileInACL, TagsExistForResources

  Background:
    Given the system is initialized

  @minimal @happy @failover_shard @internal
  Scenario: a shard failover is triggered on a multi-"AZ" "memorydb" "cluster"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "AVAILABLE"
    And multi-"AZ" was "ENABLED" for the "memorydb" "cluster"
    When a shard failover is triggered on a multi-"AZ" "memorydb" "cluster"
    Then the "memorydb" "cluster" remains "AVAILABLE" after the shard failover
    And every active "memorydb" "cluster" has write durability enabled
    And every snapshotting "memorydb" "cluster" has a corresponding in-progress "memorydb" "snapshot"
    And no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"
    And no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"
    And every active "memorydb" "cluster" and "snapshot" has tags

  @guard @negative @failover_shard @internal
  Scenario: a shard failover is triggered on a multi-"AZ" "memorydb" "cluster" fails when the "memorydb" "cluster" did not exist
    Given the "memorydb" "cluster" did not exist
    When a shard failover is triggered on a multi-"AZ" "memorydb" "cluster"
    Then the operation is rejected

  @guard @negative @failover_shard @internal
  Scenario: a shard failover is triggered on a multi-"AZ" "memorydb" "cluster" fails when the "memorydb" "cluster" was not "AVAILABLE"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was not "AVAILABLE"
    When a shard failover is triggered on a multi-"AZ" "memorydb" "cluster"
    Then the operation is rejected

  @guard @negative @failover_shard @internal
  Scenario: a shard failover is triggered on a multi-"AZ" "memorydb" "cluster" fails when multi-"AZ" was not "ENABLED" for the "memorydb" "cluster"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "AVAILABLE"
    And multi-"AZ" was not "ENABLED" for the "memorydb" "cluster"
    When a shard failover is triggered on a multi-"AZ" "memorydb" "cluster"
    Then the operation is rejected
