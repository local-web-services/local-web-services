@apigatewaysqs @generated
Feature: ApigatewaySqs - The "Api Gateway" "Api" Receives A Request And Enqueues It As A Sqs Message

  # Generated from FizzBee spec: apigateway_sqs.fizz
  # Safety invariants: RequestRequiresActiveApi, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @handle_request
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "SQS" integration configured
    And the target "sqs" "queue" was "ACTIVE"
    And a "request" "slot" was "available"
    And a "sqs" "message" "slot" was "available"
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Then the request will be "ACCEPTED" and the "sqs" "message" will be "AVAILABLE" in the "sqs" "queue"
    And every "ACCEPTED" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @guard @negative @handle_request
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message fails when the "api gateway" "API" did not exist
    Given the "api gateway" "API" did not exist
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Then the operation is rejected

  @guard @negative @handle_request @lifecycle
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was not "ACTIVE"
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Then the operation is rejected

  @guard @negative @handle_request
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message fails when the "api gateway" "api" has no "SQS" integration configured
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no "SQS" integration configured
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Then the operation is rejected

  @guard @negative @handle_request @lifecycle
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message fails when the target "sqs" "queue" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "SQS" integration configured
    And the target "sqs" "queue" was not "ACTIVE"
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Then the operation is rejected

  @guard @negative @handle_request @capacity
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message fails when no "request" "slot" was "available"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "SQS" integration configured
    And the target "sqs" "queue" was "ACTIVE"
    And no "request" "slot" was "available"
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Then the operation is rejected

  @guard @negative @handle_request @capacity
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message fails when no "sqs" "message" "slot" was "available"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "SQS" integration configured
    And the target "sqs" "queue" was "ACTIVE"
    And a "request" "slot" was "available"
    And no "sqs" "message" "slot" was "available"
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Then the operation is rejected
