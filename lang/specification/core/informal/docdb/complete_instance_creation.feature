@docdb @generated
Feature: Docdb - A "Documentdb" "Instance" Finishes Creating

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @complete_instance_creation @internal
  Scenario: a "documentdb" "instance" finishes creating
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was "CREATING"
    And the "documentdb" "cluster" existed
    And the "documentdb" "instance" is the primary
    When a "documentdb" "instance" finishes creating
    Then the "documentdb" "instance" will be "AVAILABLE" and the "documentdb" "cluster" primary will be updated if applicable
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @guard @negative @complete_instance_creation @internal
  Scenario: a "documentdb" "instance" finishes creating fails when the "documentdb" "instance" did not exist
    Given the "documentdb" "instance" did not exist
    When a "documentdb" "instance" finishes creating
    Then the operation is rejected

  @guard @negative @complete_instance_creation @internal
  Scenario: a "documentdb" "instance" finishes creating fails when the "documentdb" "instance" was not "CREATING"
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was not "CREATING"
    When a "documentdb" "instance" finishes creating
    Then the operation is rejected

  @guard @negative @complete_instance_creation @internal
  Scenario: a "documentdb" "instance" finishes creating fails when the "documentdb" "cluster" did not exist
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was "CREATING"
    And the "documentdb" "cluster" did not exist
    When a "documentdb" "instance" finishes creating
    Then the operation is rejected

  @guard @negative @complete_instance_creation @internal
  Scenario: a "documentdb" "instance" finishes creating fails when the "documentdb" "instance" is not the primary
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was "CREATING"
    And the "documentdb" "cluster" existed
    And the "documentdb" "instance" is not the primary
    When a "documentdb" "instance" finishes creating
    Then the operation is rejected
