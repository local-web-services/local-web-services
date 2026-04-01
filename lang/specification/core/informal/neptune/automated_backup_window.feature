@neptune @generated
Feature: Neptune - An Automated Backup Window Runs On An Available Neptune Cluster

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @automated_backup_window @internal
  Scenario: an automated backup window runs on an available neptune cluster
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    And a neptune snapshot slot is available
    When an automated backup window runs on an available neptune cluster
    Then a neptune snapshot will be "CREATING" and the "neptune" "cluster" will be in "BACKING_UP" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @automated_backup_window @internal
  Scenario: an automated backup window runs on an available neptune cluster fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When an automated backup window runs on an available neptune cluster
    Then the operation is rejected

  @guard @negative @automated_backup_window @internal
  Scenario: an automated backup window runs on an available neptune cluster fails when the "neptune" "cluster" was not "AVAILABLE"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "AVAILABLE"
    When an automated backup window runs on an available neptune cluster
    Then the operation is rejected

  @guard @negative @automated_backup_window @internal
  Scenario: an automated backup window runs on an available neptune cluster fails when no neptune snapshot slot is available
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    And no neptune snapshot slot is available
    When an automated backup window runs on an available neptune cluster
    Then the operation is rejected
