@neptune @generated
Feature: Neptune - A "Neptune" "Instance" Reboot Completes

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @complete_instance_reboot @internal
  Scenario: a "neptune" "instance" reboot completes
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was "REBOOTING"
    When a "neptune" "instance" reboot completes
    Then the "neptune" "instance" returns to "AVAILABLE" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @complete_instance_reboot @internal
  Scenario: a "neptune" "instance" reboot completes fails when the "neptune" "instance" did not exist
    Given the "neptune" "instance" did not exist
    When a "neptune" "instance" reboot completes
    Then the operation is rejected

  @guard @negative @complete_instance_reboot @internal
  Scenario: a "neptune" "instance" reboot completes fails when the "neptune" "instance" was not "REBOOTING"
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was not "REBOOTING"
    When a "neptune" "instance" reboot completes
    Then the operation is rejected
