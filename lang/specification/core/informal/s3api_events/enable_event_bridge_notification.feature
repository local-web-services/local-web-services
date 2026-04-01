@s3apievents @generated
Feature: S3apiEvents - "Eventbridge" Notifications Are Enabled On The "S3" "Bucket" Targeting A Specific "Eventbridge" "Bus"

  # Generated from FizzBee spec: s3api_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingObject, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @enable_event_bridge_notification
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Given the "s3" "bucket" existed and was "ACTIVE"
    And the "s3" "bucket" has no "eventbridge" notification configured
    And the "eventbridge" "bus" existed and was "ACTIVE"
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Then the "s3" "bucket" will send "eventbridge" "events" to the "eventbridge" "bus" when "s3" "objects" are uploaded
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @enable_event_bridge_notification
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" fails when the "s3" "bucket" did not exist or was "ACTIVE"
    Given the "s3" "bucket" did not exist or was "ACTIVE"
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @enable_event_bridge_notification
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" fails when the "s3" "bucket" already has an "eventbridge" notification configured
    Given the "s3" "bucket" existed and was "ACTIVE"
    And the "s3" "bucket" already has an "eventbridge" notification configured
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @enable_event_bridge_notification
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" fails when the "eventbridge" "bus" did not exist or was "ACTIVE"
    Given the "s3" "bucket" existed and was "ACTIVE"
    And the "s3" "bucket" has no "eventbridge" notification configured
    And the "eventbridge" "bus" did not exist or was "ACTIVE"
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Then the operation is rejected
