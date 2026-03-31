@docdb @generated
Feature: Docdb - A Failover Is Triggered And A Replica Is Promoted To Primary

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    And the new primary "documentdb" "instance" existed
    And the "documentdb" "instance" belongs to this documentdb cluster
    And the "documentdb" "instance" was not already the primary
    And the "documentdb" "instance" was "AVAILABLE"
    When a failover is triggered and a replica is promoted to primary
    Then the "documentdb" "cluster" has a new primary documentdb instance
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary fails when the "documentdb" "cluster" did not exist
    Given the "documentdb" "cluster" did not exist
    When a failover is triggered and a replica is promoted to primary
    Then the operation is rejected

  @guard @negative @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary fails when the "documentdb" "cluster" was not "AVAILABLE"
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was not "AVAILABLE"
    When a failover is triggered and a replica is promoted to primary
    Then the operation is rejected

  @guard @negative @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary fails when the new primary "documentdb" "instance" did not exist
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    And the new primary "documentdb" "instance" did not exist
    When a failover is triggered and a replica is promoted to primary
    Then the operation is rejected

  @guard @negative @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary fails when the "documentdb" "instance" does not belong to this documentdb cluster
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    And the new primary "documentdb" "instance" existed
    And the "documentdb" "instance" does not belong to this documentdb cluster
    When a failover is triggered and a replica is promoted to primary
    Then the operation is rejected

  @guard @negative @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary fails when the "documentdb" "instance" was already the primary
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    And the new primary "documentdb" "instance" existed
    And the "documentdb" "instance" belongs to this documentdb cluster
    And the "documentdb" "instance" was already the primary
    When a failover is triggered and a replica is promoted to primary
    Then the operation is rejected

  @guard @negative @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary fails when the "documentdb" "instance" was not "AVAILABLE"
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    And the new primary "documentdb" "instance" existed
    And the "documentdb" "instance" belongs to this documentdb cluster
    And the "documentdb" "instance" was not already the primary
    And the "documentdb" "instance" was not "AVAILABLE"
    When a failover is triggered and a replica is promoted to primary
    Then the operation is rejected
