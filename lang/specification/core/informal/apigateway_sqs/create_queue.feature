@apigatewaysqs @generated
Feature: ApigatewaySqs - An Sqs Queue Is Created

  # Generated from FizzBee spec: apigateway_sqs.fizz
  # Safety invariants: RequestRequiresActiveApi, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: an "SQS" queue is created
    Given the queue does not already exist
    When an "SQS" queue is created
    Then the queue is "ACTIVE"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @standard @negative @create_queue
  Scenario: an "SQS" queue is created fails when the queue already exists
    Given the queue already exists
    When an "SQS" queue is created
    Then the operation is rejected
