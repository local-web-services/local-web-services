@cloudtrail @generated
Feature: CloudTrail - Logging State

  # Generated from FizzBee spec: cloudtrail.fizz
  # Safety invariants: TrailStatusValid, LoggingOnlyForActiveTrails

  Background:
    Given the system is initialized

  @minimal @happy @start_logging
  Scenario: logging is enabled on a trail
    Given the trail exists and logging is disabled
    When logging is started on the trail
    Then the trail has logging enabled
    And logging is only enabled for active trails

  @minimal @happy @stop_logging
  Scenario: logging is disabled on a trail
    Given the trail exists and logging is enabled
    When logging is stopped on the trail
    Then the trail has logging disabled

  @standard @negative @start_logging
  Scenario: start logging fails when the trail does not exist
    Given the trail does not exist
    When logging is started on the trail
    Then the operation is rejected

  @standard @negative @stop_logging
  Scenario: stop logging fails when the trail does not exist
    Given the trail does not exist
    When logging is stopped on the trail
    Then the operation is rejected
