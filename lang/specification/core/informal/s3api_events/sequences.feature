@s3apievents @generated
Feature: S3apiEvents - Action Sequences

  # Generated from FizzBee spec: s3api_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingObject, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: an S3 bucket is created then an EventBridge event bus is created
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When an EventBridge event bus is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an S3 bucket is created then the EventBridge event bus is deleted
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an S3 bucket is created then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an S3 bucket is created then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an S3 bucket is created then an object is uploaded but event delivery fails because the bus has been deleted
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then an S3 bucket is created
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When an S3 bucket is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then an object is uploaded but event delivery fails because the bus has been deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an S3 bucket is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When an S3 bucket is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an object is uploaded but event delivery fails because the bus has been deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an S3 bucket is created
    Given bid in bucket_status
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    When an S3 bucket is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an EventBridge event bus is created
    Given bid in bucket_status
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    When an EventBridge event bus is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then the EventBridge event bus is deleted
    Given bid in bucket_status
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given bid in bucket_status
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded but event delivery fails because the bus has been deleted
    Given bid in bucket_status
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then an S3 bucket is created
    Given bid in bucket_status
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    When an S3 bucket is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then an EventBridge event bus is created
    Given bid in bucket_status
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    When an EventBridge event bus is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then the EventBridge event bus is deleted
    Given bid in bucket_status
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given bid in bucket_status
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then an object is uploaded but event delivery fails because the bus has been deleted
    Given bid in bucket_status
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then an S3 bucket is created
    Given bid in bucket_status
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    When an S3 bucket is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then an EventBridge event bus is created
    Given bid in bucket_status
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted
    Given bid in bucket_status
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given bid in bucket_status
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given bid in bucket_status
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an S3 bucket is created then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an S3 bucket is created then the EventBridge event bus is deleted then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given the EventBridge event bus has been deleted
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an S3 bucket is created then EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an S3 bucket is created then an object is uploaded and S3 delivers an event to the EventBridge bus then an object is uploaded but event delivery fails because the bus has been deleted
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an S3 bucket is created then an object is uploaded but event delivery fails because the bus has been deleted then an EventBridge event bus is created
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then an S3 bucket is created then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given an S3 bucket has been created
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the EventBridge event bus has been deleted
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded but event delivery fails because the bus has been deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then an object is uploaded and S3 delivers an event to the EventBridge bus then an S3 bucket is created
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    When an S3 bucket is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then an object is uploaded but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an S3 bucket is created then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given an S3 bucket has been created
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then an object is uploaded but event delivery fails because the bus has been deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given an EventBridge event bus has been created
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then EventBridge notifications are enabled on the bucket targeting a specific bus then an S3 bucket is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    When an S3 bucket is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an object is uploaded and S3 delivers an event to the EventBridge bus then an EventBridge event bus is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    When an EventBridge event bus is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an object is uploaded but event delivery fails because the bus has been deleted then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an S3 bucket is created then an object is uploaded but event delivery fails because the bus has been deleted
    Given bid in bucket_status
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    Given an S3 bucket has been created
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an EventBridge event bus is created then an S3 bucket is created
    Given bid in bucket_status
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    Given an EventBridge event bus has been created
    When an S3 bucket is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given bid in bucket_status
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    Given the EventBridge event bus has been deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded and S3 delivers an event to the EventBridge bus then the EventBridge event bus is deleted
    Given bid in bucket_status
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded but event delivery fails because the bus has been deleted then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given bid in bucket_status
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then an S3 bucket is created then an EventBridge event bus is created
    Given bid in bucket_status
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    Given an S3 bucket has been created
    When an EventBridge event bus is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given bid in bucket_status
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then the EventBridge event bus is deleted then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given bid in bucket_status
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    Given the EventBridge event bus has been deleted
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then EventBridge notifications are enabled on the bucket targeting a specific bus then an object is uploaded but event delivery fails because the bus has been deleted
    Given bid in bucket_status
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    When an object is uploaded but event delivery fails because the bus has been deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded and S3 delivers an event to the EventBridge bus then an object is uploaded but event delivery fails because the bus has been deleted then an S3 bucket is created
    Given bid in bucket_status
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    When an S3 bucket is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then an S3 bucket is created then the EventBridge event bus is deleted
    Given bid in bucket_status
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    Given an S3 bucket has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then an EventBridge event bus is created then EventBridge notifications are enabled on the bucket targeting a specific bus
    Given bid in bucket_status
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    Given an EventBridge event bus has been created
    When EventBridge notifications are enabled on the bucket targeting a specific bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted then an object is uploaded and S3 delivers an event to the EventBridge bus
    Given bid in bucket_status
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    Given the EventBridge event bus has been deleted
    When an object is uploaded and S3 delivers an event to the EventBridge bus
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then EventBridge notifications are enabled on the bucket targeting a specific bus then an S3 bucket is created
    Given bid in bucket_status
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    Given EventBridge notifications have been enabled on the bucket targeting a specific bus
    When an S3 bucket is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an object is uploaded but event delivery fails because the bus has been deleted then an object is uploaded and S3 delivers an event to the EventBridge bus then an EventBridge event bus is created
    Given bid in bucket_status
    Given an object has been uploaded but event delivery has failed because the bus has been deleted
    Given an object has been uploaded and S3 has delivered an event to the EventBridge bus
    When an EventBridge event bus is created
    Then every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists
