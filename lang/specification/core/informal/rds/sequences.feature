@rds @generated
Feature: Rds - Action Sequences

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" finishes creating
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" configuration is modified
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" modification completes
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" is rebooted
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" reboot completes
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" deletion completes
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "snapshot" finishes creating
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "snapshot" is deleted
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "snapshot" deletion completes
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then an automated backup runs on an available "rds" "instance"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a tag is applied to a "rds" "instance"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" is created
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" finishes creating
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" configuration is modified
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" modification completes
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" is rebooted
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" reboot completes
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" deletion completes
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "snapshot" is created from a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "snapshot" is deleted
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "snapshot" deletion completes
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" is restored from a "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" restore from "rds" "snapshot" completes
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then an automated backup runs on an available "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a tag is applied to a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" is created
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" finishes creating
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" configuration is modified
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" modification completes
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" is rebooted
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" reboot completes
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" deletion completes
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "snapshot" is created from a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "snapshot" finishes creating
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "snapshot" deletion completes
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" is restored from a "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" restore from "rds" "snapshot" completes
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then an automated backup runs on an available "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a tag is applied to a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" is created
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" finishes creating
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" configuration is modified
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" modification completes
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" is rebooted
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" reboot completes
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" deletion completes
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "snapshot" is created from a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "snapshot" finishes creating
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "snapshot" is deleted
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" is restored from a "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" restore from "rds" "snapshot" completes
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then an automated backup runs on an available "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a tag is applied to a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" is created
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" finishes creating
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" configuration is modified
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" modification completes
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" is rebooted
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" reboot completes
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" deletion completes
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "snapshot" is created from a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "snapshot" finishes creating
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "snapshot" is deleted
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "snapshot" deletion completes
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then an automated backup runs on an available "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a tag is applied to a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" is created
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" finishes creating
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" modification completes
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" reboot completes
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" deletion completes
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is created
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" modification completes
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is created
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" finishes creating
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" modification completes
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" reboot completes
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" deletion completes
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" is created
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" modification completes
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" finishes creating then a "rds" "instance" configuration is modified
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" finishes creating
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" configuration is modified then a "rds" "instance" modification completes
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" modification completes then a "rds" "instance" is rebooted
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" modification completes
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" is rebooted then a "rds" "instance" reboot completes
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" is rebooted
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" reboot completes then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" deletion completes
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" deletion completes then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "snapshot" finishes creating
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "snapshot" finishes creating then a "rds" "snapshot" is deleted
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "snapshot" finishes creating
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "snapshot" is deleted then a "rds" "snapshot" deletion completes
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "snapshot" is deleted
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "snapshot" deletion completes then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a "rds" "instance" restore from "rds" "snapshot" completes then an automated backup runs on an available "rds" "instance"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then an automated backup runs on an available "rds" "instance" then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When an automated backup runs on an available "rds" "instance"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a multi-"AZ" failover is triggered on a "rds" "instance" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then multi-"AZ" was "ENABLED" on a "rds" "instance" then a tag is applied to a "rds" "instance"
    Given iid not in instance_status
    When a "rds" "instance" is created
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is created then a tag is applied to a "rds" "instance" then a "rds" "instance" finishes creating
    Given iid not in instance_status
    When a "rds" "instance" is created
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" is created then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is created
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" configuration is modified then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" modification completes then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" modification completes
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" is rebooted then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is rebooted
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" reboot completes then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" deletion completes then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "snapshot" finishes creating then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "snapshot" finishes creating
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "snapshot" is deleted then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "snapshot" deletion completes then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" is restored from a "rds" "snapshot" then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a "rds" "instance" restore from "rds" "snapshot" completes then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then an automated backup runs on an available "rds" "instance" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When an automated backup runs on an available "rds" "instance"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a multi-"AZ" failover is triggered on a "rds" "instance" then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" finishes creating then a tag is applied to a "rds" "instance" then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" finishes creating
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" is created then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is created
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" finishes creating then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" finishes creating
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" modification completes then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" modification completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" is rebooted then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is rebooted
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" reboot completes then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" reboot completes
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" deletion completes then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "snapshot" finishes creating then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "snapshot" is deleted then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "snapshot" deletion completes then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "snapshot" deletion completes
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" is restored from a "rds" "snapshot" then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a "rds" "instance" restore from "rds" "snapshot" completes then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then an automated backup runs on an available "rds" "instance" then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When an automated backup runs on an available "rds" "instance"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" configuration is modified then a tag is applied to a "rds" "instance" then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" configuration is modified
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" is created then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" is created
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" finishes creating then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" configuration is modified then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" is rebooted then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" is rebooted
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" reboot completes then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" reboot completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" deletion completes then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "snapshot" finishes creating then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "snapshot" is deleted then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "snapshot" is deleted
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "snapshot" deletion completes then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "snapshot" deletion completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" is restored from a "rds" "snapshot" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a "rds" "instance" restore from "rds" "snapshot" completes then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then an automated backup runs on an available "rds" "instance" then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" modification completes then a tag is applied to a "rds" "instance" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" modification completes
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" is created then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" is created
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" finishes creating then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" configuration is modified then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" modification completes then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" modification completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" reboot completes then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" reboot completes
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" deletion completes then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "snapshot" finishes creating then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "snapshot" finishes creating
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "snapshot" is deleted then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "snapshot" is deleted
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "snapshot" deletion completes then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "snapshot" deletion completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" is restored from a "rds" "snapshot" then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then an automated backup runs on an available "rds" "instance" then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is rebooted then a tag is applied to a "rds" "instance" then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" is rebooted
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" is created then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is created
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" finishes creating then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" finishes creating
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" configuration is modified then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" configuration is modified
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" modification completes then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" modification completes
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" is rebooted then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is rebooted
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" deletion completes then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" deletion completes
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "snapshot" is created from a "rds" "instance" then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "snapshot" finishes creating then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "snapshot" finishes creating
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "snapshot" is deleted then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "snapshot" is deleted
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "snapshot" deletion completes then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "snapshot" deletion completes
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then an automated backup runs on an available "rds" "instance" then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" reboot completes then a tag is applied to a "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" reboot completes
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" is created then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" is created
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" finishes creating then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" finishes creating
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" configuration is modified then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" configuration is modified
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" modification completes then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" modification completes
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" is rebooted then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" is rebooted
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" reboot completes then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" deletion completes then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" deletion completes
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "snapshot" is created from a "rds" "instance" then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "snapshot" finishes creating then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "snapshot" finishes creating
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "snapshot" is deleted then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "snapshot" is deleted
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "snapshot" deletion completes then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then an automated backup runs on an available "rds" "instance" then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" then a tag is applied to a "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" is created then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" is created
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" finishes creating then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" finishes creating
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" configuration is modified then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" configuration is modified
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" modification completes then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" modification completes
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" is rebooted then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" is rebooted
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" reboot completes then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" reboot completes
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" is deleted without a final "rds" "snapshot" then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" deletion completes then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" deletion completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "snapshot" is created from a "rds" "instance" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "snapshot" is created from a "rds" "instance"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "snapshot" finishes creating then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "snapshot" finishes creating
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "snapshot" is deleted then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "snapshot" deletion completes then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then an automated backup runs on an available "rds" "instance" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" then a tag is applied to a "rds" "instance" then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" is created then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is created
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" finishes creating then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" finishes creating
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" configuration is modified then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" configuration is modified
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" modification completes then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" modification completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" is rebooted then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is rebooted
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" reboot completes then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" reboot completes
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" is deleted without a final "rds" "snapshot" then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" is deleted with a final "rds" "snapshot" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "snapshot" is created from a "rds" "instance" then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "snapshot" finishes creating then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "snapshot" is deleted then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "snapshot" deletion completes then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then an automated backup runs on an available "rds" "instance" then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" deletion completes then a tag is applied to a "rds" "instance" then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" deletion completes
    When a tag is applied to a "rds" "instance"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is created then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is created
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" finishes creating then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" finishes creating
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" configuration is modified then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" modification completes then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" modification completes
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is rebooted then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is rebooted
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" reboot completes then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" reboot completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot" then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" deletion completes then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "snapshot" finishes creating then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "snapshot" is deleted then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "snapshot" deletion completes then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then an automated backup runs on an available "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" then a tag is applied to a "rds" "instance" then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a tag is applied to a "rds" "instance"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" is created then a "rds" "snapshot" deletion completes
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is created
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" finishes creating then a "rds" "instance" is restored from a "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" configuration is modified then a "rds" "instance" restore from "rds" "snapshot" completes
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" modification completes then an automated backup runs on an available "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" modification completes
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" is rebooted then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is rebooted
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" reboot completes then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" reboot completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" is deleted without a final "rds" "snapshot" then a tag is applied to a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" is created
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" deletion completes then a "rds" "instance" finishes creating
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" deletion completes
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" configuration is modified
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "snapshot" is deleted then a "rds" "instance" modification completes
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "snapshot" deletion completes then a "rds" "instance" is rebooted
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" reboot completes
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then an automated backup runs on an available "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" deletion completes
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "snapshot" is created from a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" finishes creating then a tag is applied to a "rds" "instance" then a "rds" "snapshot" is deleted
    Given sid in snapshot_status
    When a "rds" "snapshot" finishes creating
    When a tag is applied to a "rds" "instance"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" is created then a "rds" "instance" is restored from a "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is created
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" finishes creating then a "rds" "instance" restore from "rds" "snapshot" completes
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" finishes creating
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" configuration is modified then an automated backup runs on an available "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" configuration is modified
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" modification completes then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" modification completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" is rebooted then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is rebooted
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" reboot completes then a tag is applied to a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" reboot completes
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" is created
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" finishes creating
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" deletion completes then a "rds" "instance" configuration is modified
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" deletion completes
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" modification completes
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "snapshot" finishes creating then a "rds" "instance" is rebooted
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "snapshot" deletion completes then a "rds" "instance" reboot completes
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then an automated backup runs on an available "rds" "instance" then a "rds" "instance" deletion completes
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "snapshot" is created from a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "snapshot" finishes creating
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" is deleted then a tag is applied to a "rds" "instance" then a "rds" "snapshot" deletion completes
    Given sid in snapshot_status
    When a "rds" "snapshot" is deleted
    When a tag is applied to a "rds" "instance"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" is created then a "rds" "instance" restore from "rds" "snapshot" completes
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is created
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" finishes creating then an automated backup runs on an available "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" finishes creating
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" configuration is modified then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" configuration is modified
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" modification completes then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" modification completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" is rebooted then a tag is applied to a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is rebooted
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" reboot completes then a "rds" "instance" is created
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" finishes creating
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" configuration is modified
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" deletion completes then a "rds" "instance" modification completes
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" deletion completes
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is rebooted
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "snapshot" finishes creating then a "rds" "instance" reboot completes
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "snapshot" is deleted then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" deletion completes
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then an automated backup runs on an available "rds" "instance" then a "rds" "snapshot" is created from a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "snapshot" finishes creating
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "snapshot" is deleted
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "snapshot" deletion completes then a tag is applied to a "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "snapshot" deletion completes
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" is created then an automated backup runs on an available "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" is created
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" finishes creating then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" finishes creating
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" configuration is modified then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" configuration is modified
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" modification completes then a tag is applied to a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" modification completes
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" is rebooted then a "rds" "instance" is created
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" is rebooted
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" reboot completes then a "rds" "instance" finishes creating
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" reboot completes
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" configuration is modified
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" modification completes
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" deletion completes then a "rds" "instance" is rebooted
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" reboot completes
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "snapshot" finishes creating then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "snapshot" is deleted then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "snapshot" deletion completes then a "rds" "instance" deletion completes
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "snapshot" is created from a "rds" "instance"
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then an automated backup runs on an available "rds" "instance" then a "rds" "snapshot" finishes creating
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "snapshot" is deleted
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "snapshot" deletion completes
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" then a tag is applied to a "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given sid in snapshot_status
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is created then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is created
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" finishes creating then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" finishes creating
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" configuration is modified then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" configuration is modified
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" modification completes then a "rds" "instance" is created
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" modification completes
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is rebooted then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is rebooted
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" reboot completes then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" reboot completes
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" modification completes
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" deletion completes then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" deletion completes
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "snapshot" finishes creating then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "snapshot" is deleted then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "snapshot" deletion completes then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "snapshot" deletion completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then an automated backup runs on an available "rds" "instance" then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes then a tag is applied to a "rds" "instance" then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a tag is applied to a "rds" "instance"
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" is created then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is created
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" finishes creating then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" finishes creating
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" configuration is modified then a "rds" "instance" is created
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" modification completes then a "rds" "instance" finishes creating
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" modification completes
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" is rebooted then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is rebooted
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" reboot completes then a "rds" "instance" modification completes
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" reboot completes
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" is rebooted
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" reboot completes
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" deletion completes then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "snapshot" finishes creating then a "rds" "instance" deletion completes
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "snapshot" finishes creating
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "snapshot" is deleted then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "snapshot" is deleted
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "snapshot" deletion completes then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "snapshot" deletion completes
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available "rds" "instance" then a tag is applied to a "rds" "instance" then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When an automated backup runs on an available "rds" "instance"
    When a tag is applied to a "rds" "instance"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is created then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is created
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" finishes creating then a "rds" "instance" is created
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" finishes creating
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" configuration is modified then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" modification completes then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" modification completes
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is rebooted then a "rds" "instance" modification completes
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is rebooted
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" reboot completes then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" deletion completes then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" deletion completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "snapshot" finishes creating then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "snapshot" finishes creating
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "snapshot" is deleted then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "snapshot" is deleted
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "snapshot" deletion completes then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "snapshot" deletion completes
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then an automated backup runs on an available "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When an automated backup runs on an available "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then multi-"AZ" was "ENABLED" on a "rds" "instance" then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" then a tag is applied to a "rds" "instance" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a tag is applied to a "rds" "instance"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is created then a "rds" "instance" finishes creating
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is created
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" finishes creating then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" finishes creating
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" configuration is modified then a "rds" "instance" modification completes
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" modification completes then a "rds" "instance" is rebooted
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" modification completes
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is rebooted then a "rds" "instance" reboot completes
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is rebooted
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" reboot completes then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "instance" deletion completes
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" deletion completes then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "snapshot" finishes creating then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "snapshot" finishes creating
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "snapshot" is deleted then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "snapshot" is deleted
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "snapshot" deletion completes then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot" then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then an automated backup runs on an available "rds" "instance" then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When an automated backup runs on an available "rds" "instance"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a multi-"AZ" failover is triggered on a "rds" "instance" then a tag is applied to a "rds" "instance"
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a tag is applied to a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" then a tag is applied to a "rds" "instance" then a "rds" "instance" is created
    Given iid in instance_status
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" is created then a "rds" "instance" configuration is modified
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is created
    When a "rds" "instance" configuration is modified
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" finishes creating then a "rds" "instance" modification completes
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" finishes creating
    When a "rds" "instance" modification completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" configuration is modified then a "rds" "instance" is rebooted
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" configuration is modified
    When a "rds" "instance" is rebooted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" modification completes then a "rds" "instance" reboot completes
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" modification completes
    When a "rds" "instance" reboot completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" is rebooted then a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is rebooted
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" reboot completes then a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" reboot completes
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" is deleted without a final "rds" "snapshot" then a "rds" "instance" deletion completes
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    When a "rds" "instance" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" is deleted with a final "rds" "snapshot" then a "rds" "snapshot" is created from a "rds" "instance"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    When a "rds" "snapshot" is created from a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" deletion completes then a "rds" "snapshot" finishes creating
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" deletion completes
    When a "rds" "snapshot" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "snapshot" is created from a "rds" "instance" then a "rds" "snapshot" is deleted
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "snapshot" is created from a "rds" "instance"
    When a "rds" "snapshot" is deleted
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "snapshot" finishes creating then a "rds" "snapshot" deletion completes
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "snapshot" finishes creating
    When a "rds" "snapshot" deletion completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "snapshot" is deleted then a "rds" "instance" is restored from a "rds" "snapshot"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "snapshot" is deleted
    When a "rds" "instance" is restored from a "rds" "snapshot"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "snapshot" deletion completes then a "rds" "instance" restore from "rds" "snapshot" completes
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "snapshot" deletion completes
    When a "rds" "instance" restore from "rds" "snapshot" completes
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" is restored from a "rds" "snapshot" then an automated backup runs on an available "rds" "instance"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    When an automated backup runs on an available "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a "rds" "instance" restore from "rds" "snapshot" completes then a multi-"AZ" failover is triggered on a "rds" "instance"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then an automated backup runs on an available "rds" "instance" then multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When an automated backup runs on an available "rds" "instance"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then a multi-"AZ" failover is triggered on a "rds" "instance" then a "rds" "instance" is created
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    When a "rds" "instance" is created
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a "rds" "instance" then multi-"AZ" was "ENABLED" on a "rds" "instance" then a "rds" "instance" finishes creating
    Given iid in instance_status
    When a tag is applied to a "rds" "instance"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    When a "rds" "instance" finishes creating
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot
