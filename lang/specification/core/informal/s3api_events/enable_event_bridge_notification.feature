@s3apievents @generated
Feature: S3apiEvents - Eventbridge Notifications Are Enabled On The Bucket Targeting A Specific Bus

  # Generated from FizzBee spec: s3api_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingObject, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @enable_event_bridge_notification
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus
    Given the bucket exists and is "ACTIVE"
    And the bucket has no EventBridge notification configured
    And the bus exists and is "ACTIVE"
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then the bucket will send events to the bus when objects are uploaded
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @enable_event_bridge_notification
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus fails when the bucket does not exist or is not "ACTIVE"
    Given the bucket does not exist or is not "ACTIVE"
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then the operation is rejected

  @standard @negative @enable_event_bridge_notification
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus fails when the bucket already has an EventBridge notification configured
    Given the bucket exists and is "ACTIVE"
    And the bucket already has an EventBridge notification configured
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then the operation is rejected

  @standard @negative @enable_event_bridge_notification
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus fails when the bus does not exist or is not "ACTIVE"
    Given the bucket exists and is "ACTIVE"
    And the bucket has no EventBridge notification configured
    And the bus does not exist or is not "ACTIVE"
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then the operation is rejected
