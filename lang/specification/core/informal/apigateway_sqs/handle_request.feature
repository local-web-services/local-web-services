@apigatewaysqs @generated
Feature: ApigatewaySqs - The Api Receives A Request And Enqueues It As An Sqs Message

  # Generated from FizzBee spec: apigateway_sqs.fizz
  # Safety invariants: RequestRequiresActiveApi, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @handle_request
  Scenario: the "API" receives a request and enqueues it as an "SQS" message
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has an "SQS" integration configured
    And the target queue is "ACTIVE"
    And a request slot is available
    And a message slot is available
    When the "API" receives a request and enqueues it as an "SQS" message
    Then the request is "ACCEPTED" and the message is "AVAILABLE" in the queue
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @guard @negative @handle_request
  Scenario: the "API" receives a request and enqueues it as an "SQS" message fails when the "API" does not exist
    Given the "API" does not exist
    When the "API" receives a request and enqueues it as an "SQS" message
    Then the operation is rejected

  @guard @negative @handle_request @lifecycle
  Scenario: the "API" receives a request and enqueues it as an "SQS" message fails when the "API" is not "ACTIVE"
    Given the "API" exists
    And the "API" is not "ACTIVE"
    When the "API" receives a request and enqueues it as an "SQS" message
    Then the operation is rejected

  @guard @negative @handle_request
  Scenario: the "API" receives a request and enqueues it as an "SQS" message fails when the "API" has no "SQS" integration configured
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no "SQS" integration configured
    When the "API" receives a request and enqueues it as an "SQS" message
    Then the operation is rejected

  @guard @negative @handle_request @lifecycle
  Scenario: the "API" receives a request and enqueues it as an "SQS" message fails when the target queue is not "ACTIVE"
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has an "SQS" integration configured
    And the target queue is not "ACTIVE"
    When the "API" receives a request and enqueues it as an "SQS" message
    Then the operation is rejected

  @guard @negative @internal @handle_request @capacity
  Scenario: the "API" receives a request and enqueues it as an "SQS" message fails when no request slot is available
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has an "SQS" integration configured
    And the target queue is "ACTIVE"
    And no request slot is available
    When the "API" receives a request and enqueues it as an "SQS" message
    Then the operation is rejected

  @guard @negative @internal @handle_request @capacity
  Scenario: the "API" receives a request and enqueues it as an "SQS" message fails when no message slot is available
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has an "SQS" integration configured
    And the target queue is "ACTIVE"
    And a request slot is available
    And no message slot is available
    When the "API" receives a request and enqueues it as an "SQS" message
    Then the operation is rejected
