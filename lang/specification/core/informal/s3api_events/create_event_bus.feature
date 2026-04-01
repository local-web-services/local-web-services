@s3apievents @generated
Feature: S3apiEvents - An "Eventbridge" "Bus" Is Created

  # Generated from FizzBee spec: s3api_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingObject, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_event_bus
  Scenario: an "eventbridge" "bus" is created
    Given the "eventbridge" "bus" did not already exist
    When an "eventbridge" "bus" is created
    Then the "eventbridge" "bus" will be "ACTIVE"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @create_event_bus
  Scenario: an "eventbridge" "bus" is created fails when the "eventbridge" "bus" already existed
    Given the "eventbridge" "bus" already existed
    When an "eventbridge" "bus" is created
    Then the operation is rejected
