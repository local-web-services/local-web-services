@s3apievents @generated
Feature: S3apiEvents - Action Sequences

  # Generated from FizzBee spec: s3api_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingObject, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "s3" "bucket" is created then an "eventbridge" "bus" is created
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then the "eventbridge" "bus" is deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "s3" "bucket" is created
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "s3" "bucket" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "s3" "bucket" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "s3" "bucket" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then a "s3" "bucket" is created
    Given bid in bucket_status
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When a "s3" "bucket" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then an "eventbridge" "bus" is created
    Given bid in bucket_status
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then the "eventbridge" "bus" is deleted
    Given bid in bucket_status
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Given bid in bucket_status
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Given bid in bucket_status
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then a "s3" "bucket" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When a "s3" "bucket" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then an "eventbridge" "bus" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then the "eventbridge" "bus" is deleted
    Given bid in bucket_status
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Given bid in bucket_status
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Given bid in bucket_status
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then a "s3" "bucket" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When a "s3" "bucket" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then an "eventbridge" "bus" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then the "eventbridge" "bus" is deleted
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then the "eventbridge" "bus" is deleted then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "eventbridge" "bus" is deleted
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then an "eventbridge" "bus" is created
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "s3" "bucket" is created then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "s3" "bucket" is created
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then a "s3" "bucket" is created
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When a "s3" "bucket" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "s3" "bucket" is created then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "s3" "bucket" is created
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then a "s3" "bucket" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When a "s3" "bucket" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then an "eventbridge" "bus" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then a "s3" "bucket" is created then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Given bid in bucket_status
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When a "s3" "bucket" is created
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then an "eventbridge" "bus" is created then a "s3" "bucket" is created
    Given bid in bucket_status
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    When a "s3" "bucket" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given bid in bucket_status
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then the "eventbridge" "bus" is deleted
    Given bid in bucket_status
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Given bid in bucket_status
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then a "s3" "bucket" is created then an "eventbridge" "bus" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When a "s3" "bucket" is created
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given bid in bucket_status
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then the "eventbridge" "bus" is deleted then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Given bid in bucket_status
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    Given bid in bucket_status
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then a "s3" "bucket" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When a "s3" "bucket" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then a "s3" "bucket" is created then the "eventbridge" "bus" is deleted
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When a "s3" "bucket" is created
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then an "eventbridge" "bus" is created then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When an "eventbridge" "bus" is created
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then the "eventbridge" "bus" is deleted then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When the "eventbridge" "bus" is deleted
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" then a "s3" "bucket" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"
    When a "s3" "bucket" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted then an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" then an "eventbridge" "bus" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted
    When an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists
