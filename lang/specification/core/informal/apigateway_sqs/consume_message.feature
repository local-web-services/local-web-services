@apigatewaysqs @generated
Feature: ApigatewaySqs - A Backend Consumer Processes The "Sqs" "Message" From The "Sqs" "Queue"

  # Generated from FizzBee spec: apigateway_sqs.fizz
  # Safety invariants: RequestRequiresActiveApi, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @consume_message
  Scenario: a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    Given an "AVAILABLE" message existed in the "sqs" "queue"
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    Then the "sqs" "message" will be deleted
    And every "ACCEPTED" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @guard @negative @consume_message @lifecycle
  Scenario: a backend consumer processes the "sqs" "message" from the "sqs" "queue" fails when no "AVAILABLE" message existed in the "sqs" "queue"
    Given no "AVAILABLE" message existed in the "sqs" "queue"
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    Then the operation is rejected
