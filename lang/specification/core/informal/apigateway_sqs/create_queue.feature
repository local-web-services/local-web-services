@apigatewaysqs @generated
Feature: ApigatewaySqs - A "Sqs" "Queue" Is Created

  # Generated from FizzBee spec: apigateway_sqs.fizz
  # Safety invariants: RequestRequiresActiveApi, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: a "sqs" "queue" is created
    Given the "sqs" "queue" did not already exist
    When a "sqs" "queue" is created
    Then the "sqs" "queue" will be "ACTIVE"
    And every "ACCEPTED" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @guard @negative @create_queue
  Scenario: a "sqs" "queue" is created fails when the "sqs" "queue" already existed
    Given the "sqs" "queue" already existed
    When a "sqs" "queue" is created
    Then the operation is rejected
