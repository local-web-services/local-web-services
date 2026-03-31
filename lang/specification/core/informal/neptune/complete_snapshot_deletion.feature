@neptune @generated
Feature: Neptune - A "Neptune" "Cluster" Neptune Snapshot Deletion Completes

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_deletion @internal
  Scenario: a "neptune" "cluster" neptune snapshot deletion completes
    Given the "neptune" "snapshot" existed
    And the "neptune" "snapshot" was "DELETING"
    When a "neptune" "cluster" neptune snapshot deletion completes
    Then the "neptune" "SNAPSHOT" will be "DELETED"
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @complete_snapshot_deletion @internal
  Scenario: a "neptune" "cluster" neptune snapshot deletion completes fails when the "neptune" "snapshot" did not exist
    Given the "neptune" "snapshot" did not exist
    When a "neptune" "cluster" neptune snapshot deletion completes
    Then the operation is rejected

  @guard @negative @complete_snapshot_deletion @internal
  Scenario: a "neptune" "cluster" neptune snapshot deletion completes fails when the "neptune" "snapshot" was not "DELETING"
    Given the "neptune" "snapshot" existed
    And the "neptune" "snapshot" was not "DELETING"
    When a "neptune" "cluster" neptune snapshot deletion completes
    Then the operation is rejected
