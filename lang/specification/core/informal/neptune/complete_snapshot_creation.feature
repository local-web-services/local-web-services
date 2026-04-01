@neptune @generated
Feature: Neptune - A "Neptune" "Cluster" Neptune Snapshot Finishes Creating

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_creation @internal
  Scenario: a "neptune" "cluster" neptune snapshot finishes creating
    Given the "neptune" "snapshot" existed
    And the "neptune" "snapshot" was "CREATING"
    When a "neptune" "cluster" neptune snapshot finishes creating
    Then the "neptune" "snapshot" will be "AVAILABLE" and the "neptune" "cluster" returns to "AVAILABLE" if it was backing up
    And every "neptune" "cluster" has a valid status
    And every "neptune" "instance" has a valid status
    And every "neptune" "snapshot" has a valid status
    And a stopped "neptune" "cluster" has no available "neptune" "instance"s
    And "neptune" "instance"s on a stopped or stopping "neptune" "cluster" are not in "MODIFYING" state
    And a deleted "neptune" "cluster" has no available "neptune" "instance"s
    And every backing-up "neptune" "cluster" has a corresponding in-progress "neptune" "snapshot"
    And a failed "neptune" "cluster" has no available "neptune" "instance"s

  @guard @negative @complete_snapshot_creation @internal
  Scenario: a "neptune" "cluster" neptune snapshot finishes creating fails when the "neptune" "snapshot" did not exist
    Given the "neptune" "snapshot" did not exist
    When a "neptune" "cluster" neptune snapshot finishes creating
    Then the operation is rejected

  @guard @negative @complete_snapshot_creation @internal
  Scenario: a "neptune" "cluster" neptune snapshot finishes creating fails when the "neptune" "snapshot" was not "CREATING"
    Given the "neptune" "snapshot" existed
    And the "neptune" "snapshot" was not "CREATING"
    When a "neptune" "cluster" neptune snapshot finishes creating
    Then the operation is rejected
