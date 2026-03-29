@cloudtrail @generated
Feature: CloudTrail - A Trail Is Deleted

  # Generated from FizzBee spec: cloudtrail.fizz
  # Safety invariants: TrailStatusValid, LoggingOnlyForActiveTrails

  Background:
    Given the system is initialized

  @minimal @happy @delete_trail
  Scenario: a trail is deleted
    Given the trail exists and is active
    When a trail is deleted
    Then the trail no longer exists
    And every trail has a valid status

  @standard @negative @delete_trail
  Scenario: a trail is deleted fails when the trail does not exist
    Given the trail does not exist
    When a trail is deleted
    Then the operation is rejected
