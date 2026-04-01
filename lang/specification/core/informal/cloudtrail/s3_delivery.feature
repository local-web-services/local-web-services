@cloudtrail @generated
Feature: CloudTrail - S3 Log Delivery

  @minimal @happy @s3_flush
  Scenario: buffered events are flushed to S3
    Given a cloudtrail trail has been created with an S3 bucket
    And StartLogging has been called on the trail
    And events have accumulated in the buffer
    When the flush interval elapses or the high-water mark is reached
    Then a gzip-compressed JSON log file is written to the trail's S3 bucket
    And the S3 key follows the standard CloudTrail path format
    And the buffer is cleared after the flush

  @minimal @happy @s3_log_format
  Scenario: the S3 log file contains valid CloudTrail records
    Given a cloudtrail trail has been created with an S3 bucket
    And StartLogging has been called on the trail
    And an S3 log file has been written by the flush cycle
    When the file is downloaded and decompressed
    Then it is valid JSON with a top-level Records array
    And each element in Records is a valid CloudTrail event

  @minimal @happy @stopped_trail_no_delivery
  Scenario: a stopped trail does not receive S3 delivery
    Given a cloudtrail trail has been created with an S3 bucket
    And StartLogging has been called on the trail
    And StopLogging has been called on the trail
    And events accumulate in the internal buffer
    When the flush interval elapses
    Then no S3 log file is written to the trail's bucket

  @guard @negative @delivery_error
  Scenario: delivery error is recorded when the S3 bucket does not exist
    Given a cloudtrail trail has been created with an S3 bucket
    And StartLogging has been called on the trail
    And the S3 bucket configured on the trail does not exist
    When a flush is attempted
    Then GetTrailStatus returns a LatestDeliveryError
    And the event buffer is not lost

  @minimal @happy @delivery_resumes
  Scenario: delivery resumes after the S3 bucket is created
    Given a prior delivery failure occurred because the bucket did not exist
    And the S3 bucket has now been created
    When the next scheduled flush runs
    Then the flush succeeds
    And LatestDeliveryError is cleared

  @minimal @happy @bucket_not_validated_on_create
  Scenario: trail creation succeeds even when the S3 bucket does not yet exist
    Given the S3 provider has no bucket with the trail's configured name
    When CreateTrail is called
    Then the trail is created successfully
    And no error is returned at creation time

  @sequence @delivery_sequence
  Scenario: end-to-end delivery sequence
    Given a trail is created with an S3 bucket
    And the S3 bucket exists
    And StartLogging is called
    When multiple service API calls are made
    And the flush cycle runs
    Then log files appear under the CloudTrail S3 key path
    And LookupEvents returns the captured events
