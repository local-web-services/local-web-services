@s3apievents @generated
Feature: S3apiEvents - An "S3" "Object" Is Uploaded And "S3" Delivers An "Eventbridge" "Event" To The "Eventbridge" "Bus"

  # Generated from FizzBee spec: s3api_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingObject, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @put_object_with_event
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has an "eventbridge" notification configured
    And the target "eventbridge" "bus" was "ACTIVE"
    And an "s3" "object" "slot" was "available"
    And an "eventbridge" "event" "slot" was "available"
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Then the "s3" "object" will exist and an "eventbridge" "event" will be "DELIVERED" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @put_object_with_event @lifecycle
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" was not "ACTIVE"
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @put_object_with_event
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" fails when the "s3" "bucket" has no "eventbridge" notification configured
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has no "eventbridge" notification configured
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @put_object_with_event @lifecycle
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" fails when the target "eventbridge" "bus" was "DELETED"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has an "eventbridge" notification configured
    And the target "eventbridge" "bus" was "DELETED"
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @put_object_with_event @capacity
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" fails when no "s3" "object" "slot" was "available"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has an "eventbridge" notification configured
    And the target "eventbridge" "bus" was "ACTIVE"
    And no "s3" "object" "slot" was "available"
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @put_object_with_event @capacity
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" fails when no "eventbridge" "event" "slot" was "available"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has an "eventbridge" notification configured
    And the target "eventbridge" "bus" was "ACTIVE"
    And an "s3" "object" "slot" was "available"
    And no "eventbridge" "event" "slot" was "available"
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Then the operation is rejected
