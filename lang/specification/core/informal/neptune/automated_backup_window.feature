@neptune @generated
Feature: Neptune - An Automated Backup Window Runs On An Available "Neptune" "Cluster"

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @automated_backup_window @internal
  Scenario: an automated backup window runs on an available "neptune" "cluster"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    And a "neptune" "snapshot" "slot" was "available"
    When an automated backup window runs on an available "neptune" "cluster"
    Then a neptune snapshot will be "CREATING" and the "neptune" "cluster" will be in "BACKING_UP" state
    And every "neptune" "cluster" has a valid status
    And every "neptune" "instance" has a valid status
    And every "neptune" "snapshot" has a valid status
    And a stopped "neptune" "cluster" has no available "neptune" "instance"s
    And "neptune" "instance"s on a stopped or stopping "neptune" "cluster" are not in "MODIFYING" state
    And a deleted "neptune" "cluster" has no available "neptune" "instance"s
    And every backing-up "neptune" "cluster" has a corresponding in-progress "neptune" "snapshot"
    And a failed "neptune" "cluster" has no available "neptune" "instance"s

  @guard @negative @automated_backup_window @internal
  Scenario: an automated backup window runs on an available "neptune" "cluster" fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When an automated backup window runs on an available "neptune" "cluster"
    Then the operation is rejected

  @guard @negative @automated_backup_window @internal
  Scenario: an automated backup window runs on an available "neptune" "cluster" fails when the "neptune" "cluster" was not "AVAILABLE"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "AVAILABLE"
    When an automated backup window runs on an available "neptune" "cluster"
    Then the operation is rejected

  @guard @negative @automated_backup_window @internal
  Scenario: an automated backup window runs on an available "neptune" "cluster" fails when no "neptune" "snapshot" "slot" was "available"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    And no "neptune" "snapshot" "slot" was "available"
    When an automated backup window runs on an available "neptune" "cluster"
    Then the operation is rejected
