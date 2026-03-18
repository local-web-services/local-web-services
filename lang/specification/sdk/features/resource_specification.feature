@sdk @resource_specification
Feature: Resource specification

  Resources declared in the session spec are available immediately after
  the session starts — no separate creation step is needed in tests.

  @happy
  Scenario: DynamoDB table declared in spec is available on start
    Given a session with a DynamoDB table "Orders" with partition key "orderId"
    Then the table "Orders" exists

  @happy
  Scenario: SQS queue declared in spec is available on start
    Given a session with an SQS queue "OrderQueue"
    Then the queue "OrderQueue" exists

  @happy
  Scenario: S3 bucket declared in spec is available on start
    Given a session with an S3 bucket "order-bucket"
    Then the bucket "order-bucket" exists

  @happy
  Scenario: SNS topic declared in spec is available on start
    Given a session with an SNS topic "OrderEvents"
    Then the topic "OrderEvents" exists

  @happy
  Scenario: Step Functions state machine declared in spec is available on start
    Given a session with a state machine "OrderProcessor" using a Pass definition
    Then the state machine "OrderProcessor" exists

  @happy
  Scenario: Multiple resource types declared together are all available on start
    Given a session with a DynamoDB table "Orders" with partition key "orderId"
    And the session also has an SQS queue "OrderQueue"
    And the session also has an S3 bucket "order-bucket"
    Then the table "Orders" exists
    And the queue "OrderQueue" exists
    And the bucket "order-bucket" exists
