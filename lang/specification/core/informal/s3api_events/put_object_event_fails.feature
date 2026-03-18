@s3apievents @generated
Feature: S3apiEvents - An Object Is Uploaded But Event Delivery Fails Because The Bus Has Been Deleted

  # Generated from FizzBee spec: s3api_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingObject, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @put_object_event_fails
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted
    Given the bucket is "ACTIVE"
    And the bucket has an EventBridge notification configured
    And the target bus is "DELETED"
    And an object slot is available
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then the object "EXISTS" but no event is delivered
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @put_object_event_fails @lifecycle @internal
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted fails when the bucket is not "ACTIVE"
    Given the bucket is not "ACTIVE"
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then the operation is rejected

  @standard @negative @put_object_event_fails
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted fails when the bucket has no EventBridge notification configured
    Given the bucket is "ACTIVE"
    And the bucket has no EventBridge notification configured
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then the operation is rejected

  @standard @negative @put_object_event_fails @lifecycle @internal
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted fails when the target bus is not "DELETED"
    Given the bucket is "ACTIVE"
    And the bucket has an EventBridge notification configured
    And the target bus is not "DELETED"
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then the operation is rejected

  @standard @negative @put_object_event_fails @capacity @internal
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted fails when no object slot is available
    Given the bucket is "ACTIVE"
    And the bucket has an EventBridge notification configured
    And the target bus is "DELETED"
    And no object slot is available
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then the operation is rejected
