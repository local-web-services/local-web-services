@s3apievents @generated
Feature: S3apiEvents - An Object Is Uploaded And S3 Delivers An Event To The Eventbridge Bus

  # Generated from FizzBee spec: s3api_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingObject, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @put_object_with_event
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus
    Given the bucket was "ACTIVE"
    And the bucket has an EventBridge notification configured
    And the target bus was "ACTIVE"
    And an object slot is available
    And an event slot is available
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then the object will exist and an event will be "DELIVERED" to the bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @put_object_with_event @lifecycle
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus fails when the bucket was not "ACTIVE"
    Given the bucket was not "ACTIVE"
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @put_object_with_event
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus fails when the bucket has no EventBridge notification configured
    Given the bucket was "ACTIVE"
    And the bucket has no EventBridge notification configured
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @put_object_with_event @lifecycle
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus fails when the target bus was "DELETED"
    Given the bucket was "ACTIVE"
    And the bucket has an EventBridge notification configured
    And the target bus was "DELETED"
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @put_object_with_event @capacity
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus fails when no object slot is available
    Given the bucket was "ACTIVE"
    And the bucket has an EventBridge notification configured
    And the target bus was "ACTIVE"
    And no object slot is available
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @put_object_with_event @capacity
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus fails when no event slot is available
    Given the bucket was "ACTIVE"
    And the bucket has an EventBridge notification configured
    And the target bus was "ACTIVE"
    And an object slot is available
    And no event slot is available
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then the operation is rejected
