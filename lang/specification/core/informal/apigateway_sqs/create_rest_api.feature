@apigatewaysqs @generated
Feature: ApigatewaySqs - A Rest Api Is Created

  # Generated from FizzBee spec: apigateway_sqs.fizz
  # Safety invariants: RequestRequiresActiveApi, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_api
  Scenario: a "REST" "API" is created
    Given the "API" does not already exist
    When a "REST" "API" is created
    Then the "API" is "ACTIVE" with no "SQS" integration configured
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @standard @negative @create_rest_api
  Scenario: a "REST" "API" is created fails when the "API" already exists
    Given the "API" already exists
    When a "REST" "API" is created
    Then the operation is rejected
