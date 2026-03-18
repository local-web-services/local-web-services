@apigatewaysqs @generated
Feature: ApigatewaySqs - A Backend Consumer Processes The Message From The Queue

  # Generated from FizzBee spec: apigateway_sqs.fizz
  # Safety invariants: RequestRequiresActiveApi, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @consume_message
  Scenario: a backend consumer processes the message from the queue
    Given an "AVAILABLE" message exists in the queue
    When a backend consumer processes the message from the queue
    Then the message is "DELETED"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @standard @negative @consume_message @lifecycle @internal
  Scenario: a backend consumer processes the message from the queue fails when no "AVAILABLE" message exists in the queue
    Given no "AVAILABLE" message exists in the queue
    When a backend consumer processes the message from the queue
    Then the operation is rejected
