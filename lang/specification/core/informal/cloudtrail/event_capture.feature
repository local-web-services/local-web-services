@cloudtrail @generated
Feature: CloudTrail - Event Capture

  # Generated from FizzBee spec: cloudtrail.fizz
  # Safety invariants: EventsReferValidTrails, DeliveredEventsFromLoggingTrails

  Background:
    Given the system is initialized
    And a cloudtrail trail has been created
    And StartLogging has been called on the trail

  @minimal @happy @management_event
  Scenario: a management event is captured when an SQS queue is created
    When CreateQueue is called on the SQS provider
    Then a cloudtrail management event with eventName CreateQueue is buffered
    And the event has eventSource sqs.amazonaws.com
    And the event has no errorCode
    And all buffered events reference valid trails

  @minimal @happy @management_event_dynamodb
  Scenario: a management event is captured when a DynamoDB table is created
    When CreateTable is called on the DynamoDB provider
    Then a cloudtrail management event with eventName CreateTable is buffered
    And the event has eventSource dynamodb.amazonaws.com

  @minimal @happy @management_event_s3
  Scenario: a management event is captured when an S3 bucket is created
    When CreateBucket is called on the S3 provider
    Then a cloudtrail management event with eventName CreateBucket is buffered
    And the event has eventSource s3.amazonaws.com

  @minimal @happy @management_event_error
  Scenario: a failed management event is captured with errorCode
    When a caller invokes an operation that returns an AWS error
    Then a cloudtrail management event is buffered
    And the event has errorCode set to the AWS error code
    And the event has errorMessage set

  @minimal @happy @data_event_s3
  Scenario: an S3 data event is captured when an object is put
    When PutObject is called on the S3 provider
    Then a cloudtrail data event with eventName PutObject is buffered
    And the event has eventSource s3.amazonaws.com
    And the event resources array contains the object ARN

  @minimal @happy @data_event_dynamodb
  Scenario: a DynamoDB data event is captured when an item is put
    When PutItem is called on the DynamoDB provider
    Then a cloudtrail data event with eventName PutItem is buffered
    And the event has eventSource dynamodb.amazonaws.com
    And the event resources array contains the table ARN

  @minimal @happy @no_capture_when_stopped
  Scenario: no events are buffered when the trail is stopped
    Given StopLogging has been called on the trail
    When CreateQueue is called on the SQS provider
    Then no new cloudtrail event is buffered for the logging trail

  @minimal @happy @no_op_without_provider
  Scenario: service calls succeed when CloudTrail provider is absent
    Given no CloudTrail provider is registered
    When CreateQueue is called on the SQS provider
    Then the SQS call succeeds normally
    And no cloudtrail error is raised

  @minimal @happy @full_event_envelope
  Scenario: captured events include the full CloudTrail event envelope
    When any AWS service operation is called
    Then the buffered event includes eventVersion
    And the buffered event includes userIdentity
    And the buffered event includes eventTime
    And the buffered event includes eventSource
    And the buffered event includes eventName
    And the buffered event includes awsRegion
    And the buffered event includes sourceIPAddress
    And the buffered event includes eventType
    And the buffered event includes eventID
    And the buffered event includes recipientAccountId

  @guard @negative @iam_denied
  Scenario: an IAM-denied call is captured with AccessDenied errorCode
    Given AwsIamAuthMiddleware is configured in enforce mode
    And the caller does not have permission for the operation
    When a service operation is called
    Then a cloudtrail event is buffered with errorCode AccessDenied
