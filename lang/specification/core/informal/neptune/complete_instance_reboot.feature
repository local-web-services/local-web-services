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
    And every "neptune" "cluster" has a valid status
    And every "neptune" "instance" has a valid status
    And every "neptune" "snapshot" has a valid status
    And a stopped "neptune" "cluster" has no available "neptune" "instance"s
    And "neptune" "instance"s on a stopped or stopping "neptune" "cluster" are not in "MODIFYING" state
    And a deleted "neptune" "cluster" has no available "neptune" "instance"s
    And every backing-up "neptune" "cluster" has a corresponding in-progress "neptune" "snapshot"
    And a failed "neptune" "cluster" has no available "neptune" "instance"s

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
