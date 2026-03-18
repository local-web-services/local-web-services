@neptune @generated
Feature: Neptune - An Automated Backup Window Runs On An Available Cluster

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @automated_backup_window
  Scenario: an automated backup window runs on an available cluster
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And a snapshot slot is available
    When an automated backup window runs on an available cluster
    Then a snapshot is "CREATING" and linked to the cluster
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And a failed cluster has no available instances

  @standard @negative @automated_backup_window
  Scenario: an automated backup window runs on an available cluster fails when the cluster does not exist
    Given the cluster does not exist
    When an automated backup window runs on an available cluster
    Then the operation is rejected

  @standard @negative @automated_backup_window @lifecycle @internal
  Scenario: an automated backup window runs on an available cluster fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When an automated backup window runs on an available cluster
    Then the operation is rejected

  @standard @negative @automated_backup_window
  Scenario: an automated backup window runs on an available cluster fails when no snapshot slot is available
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And no snapshot slot is available
    When an automated backup window runs on an available cluster
    Then the operation is rejected
