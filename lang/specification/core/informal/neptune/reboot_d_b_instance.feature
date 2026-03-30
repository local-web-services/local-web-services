@neptune @generated
Feature: Neptune - A Database Instance Is Rebooted

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @reboot_d_b_instance
  Scenario: a database instance is rebooted
    Given the instance exists
    And the instance is "AVAILABLE"
    And the cluster exists
    And the cluster is "AVAILABLE"
    When a database instance is rebooted
    Then the instance is in "REBOOTING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @reboot_d_b_instance
  Scenario: a database instance is rebooted fails when the instance does not exist
    Given the instance does not exist
    When a database instance is rebooted
    Then the operation is rejected

  @guard @negative @reboot_d_b_instance @lifecycle
  Scenario: a database instance is rebooted fails when the instance is not "AVAILABLE"
    Given the instance exists
    And the instance is not "AVAILABLE"
    When a database instance is rebooted
    Then the operation is rejected

  @guard @negative @reboot_d_b_instance
  Scenario: a database instance is rebooted fails when the cluster does not exist
    Given the instance exists
    And the instance is "AVAILABLE"
    And the cluster does not exist
    When a database instance is rebooted
    Then the operation is rejected

  @guard @negative @reboot_d_b_instance @lifecycle
  Scenario: a database instance is rebooted fails when the cluster is not "AVAILABLE"
    Given the instance exists
    And the instance is "AVAILABLE"
    And the cluster exists
    And the cluster is not "AVAILABLE"
    When a database instance is rebooted
    Then the operation is rejected
