@s3apievents @generated
Feature: S3apiEvents - An "S3" "Object" Is Uploaded But "Eventbridge" "Event" Delivery Fails Because The "Eventbridge" "Bus" Has Been Deleted

  # Generated from FizzBee spec: s3api_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingObject, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @put_object_event_fails
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has an "eventbridge" notification configured
    And the target "eventbridge" "bus" was "DELETED"
    And an "s3" "object" "slot" was "available"
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Then the "s3" "object" will exist but no "eventbridge" "event" will be delivered
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @put_object_event_fails @lifecycle
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" was not "ACTIVE"
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Then the operation is rejected

  @guard @negative @put_object_event_fails
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted fails when the "s3" "bucket" has no "eventbridge" notification configured
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has no "eventbridge" notification configured
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Then the operation is rejected

  @guard @negative @put_object_event_fails @lifecycle
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted fails when the target "eventbridge" "bus" was not "DELETED"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has an "eventbridge" notification configured
    And the target "eventbridge" "bus" was not "DELETED"
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Then the operation is rejected

  @guard @negative @put_object_event_fails @capacity
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted fails when no "s3" "object" "slot" was "available"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has an "eventbridge" notification configured
    And the target "eventbridge" "bus" was "DELETED"
    And no "s3" "object" "slot" was "available"
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Then the operation is rejected
