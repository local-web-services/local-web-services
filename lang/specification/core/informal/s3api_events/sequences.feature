@s3apievents @generated
Feature: S3apiEvents - Action Sequences

  # Generated from FizzBee spec: s3api_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingObject, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "s3" "bucket" is created then an EventBridge event bus is created
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an EventBridge event bus is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "s3" "bucket" is created then the EventBridge event bus is deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "s3" "bucket" is created then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an object is uploaded but event delivery fails because the bus has been deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is uploaded but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "s3" "bucket" is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "s3" "bucket" is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then an object is uploaded but event delivery fails because the bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an object is uploaded but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "s3" "bucket" is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "s3" "bucket" is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an object is uploaded but event delivery fails because the bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an object is uploaded but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then a "s3" "bucket" is created
    Given bid in bucket_status
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When a "s3" "bucket" is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an EventBridge event bus is created
    Given bid in bucket_status
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then the EventBridge event bus is deleted
    Given bid in bucket_status
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given bid in bucket_status
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded but event delivery fails because the bus has been deleted
    Given bid in bucket_status
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When an object is uploaded but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When a "s3" "bucket" is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then an EventBridge event bus is created
    Given bid in bucket_status
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then the EventBridge event bus is deleted
    Given bid in bucket_status
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given bid in bucket_status
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then an object is uploaded but event delivery fails because the bus has been deleted
    Given bid in bucket_status
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When an object is uploaded but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is uploaded but event delivery fails because the bus has been deleted
    When a "s3" "bucket" is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then an EventBridge event bus is created
    Given bid in bucket_status
    When an object is uploaded but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted
    Given bid in bucket_status
    When an object is uploaded but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given bid in bucket_status
    When an object is uploaded but event delivery fails because the bus has been deleted
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given bid in bucket_status
    When an object is uploaded but event delivery fails because the bus has been deleted
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "s3" "bucket" is created then the EventBridge event bus is deleted then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the EventBridge event bus is deleted
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "s3" "bucket" is created then EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an object is uploaded and S3 delivers an event to the EventBridge bus then an object is uploaded but event delivery fails because the bus has been deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When an object is uploaded but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an object is uploaded but event delivery fails because the bus has been deleted then an EventBridge event bus is created
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is uploaded but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "s3" "bucket" is created then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "s3" "bucket" is created
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded but event delivery fails because the bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When an object is uploaded but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then an object is uploaded and S3 delivers an event to the EventBridge bus then a "s3" "bucket" is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When a "s3" "bucket" is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then an object is uploaded but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an object is uploaded but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "s3" "bucket" is created then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "s3" "bucket" is created
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then an object is uploaded but event delivery fails because the bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When an object is uploaded but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then EventBridge notifications are enabled on the bucket targeting a specific bus then a "s3" "bucket" is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When a "s3" "bucket" is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an object is uploaded and S3 delivers an event to the EventBridge bus then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an object is uploaded but event delivery fails because the bus has been deleted then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an object is uploaded but event delivery fails because the bus has been deleted
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then a "s3" "bucket" is created then an object is uploaded but event delivery fails because the bus has been deleted
    Given bid in bucket_status
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When a "s3" "bucket" is created
    When an object is uploaded but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an EventBridge event bus is created then a "s3" "bucket" is created
    Given bid in bucket_status
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When an EventBridge event bus is created
    When a "s3" "bucket" is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given bid in bucket_status
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded and S3 delivers an event to the EventBridge bus then the EventBridge event bus is deleted
    Given bid in bucket_status
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded but event delivery fails because the bus has been deleted then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given bid in bucket_status
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When an object is uploaded but event delivery fails because the bus has been deleted
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then a "s3" "bucket" is created then an EventBridge event bus is created
    Given bid in bucket_status
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When a "s3" "bucket" is created
    When an EventBridge event bus is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given bid in bucket_status
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then the EventBridge event bus is deleted then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given bid in bucket_status
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When the EventBridge event bus is deleted
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded but event delivery fails because the bus has been deleted
    Given bid in bucket_status
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When an object is uploaded but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then an object is uploaded but event delivery fails because the bus has been deleted then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When an object is uploaded but event delivery fails because the bus has been deleted
    When a "s3" "bucket" is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then a "s3" "bucket" is created then the EventBridge event bus is deleted
    Given bid in bucket_status
    When an object is uploaded but event delivery fails because the bus has been deleted
    When a "s3" "bucket" is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then an EventBridge event bus is created then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given bid in bucket_status
    When an object is uploaded but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given bid in bucket_status
    When an object is uploaded but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then EventBridge notifications are enabled on the bucket targeting a specific bus then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is uploaded but event delivery fails because the bus has been deleted
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    When a "s3" "bucket" is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then an object is uploaded and S3 delivers an event to the EventBridge bus then an EventBridge event bus is created
    Given bid in bucket_status
    When an object is uploaded but event delivery fails because the bus has been deleted
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists
