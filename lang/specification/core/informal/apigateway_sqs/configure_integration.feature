@apigatewaysqs @generated
Feature: ApigatewaySqs - An Sqs Direct Integration Is Configured On The Rest Api

  # Generated from FizzBee spec: apigateway_sqs.fizz
  # Safety invariants: RequestRequiresActiveApi, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @configure_integration
  Scenario: an "SQS" direct integration is configured on the "REST" "API"
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no integration configured
    And the queue exists
    And the queue is "ACTIVE"
    When an "SQS" direct integration is configured on the "REST" "API"
    Then the "API" will enqueue incoming requests as "SQS" messages without invoking Lambda
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @standard @negative @configure_integration
  Scenario: an "SQS" direct integration is configured on the "REST" "API" fails when the "API" does not exist
    Given the "API" does not exist
    When an "SQS" direct integration is configured on the "REST" "API"
    Then the operation is rejected

  @standard @negative @configure_integration @lifecycle @internal
  Scenario: an "SQS" direct integration is configured on the "REST" "API" fails when the "API" is not "ACTIVE"
    Given the "API" exists
    And the "API" is not "ACTIVE"
    When an "SQS" direct integration is configured on the "REST" "API"
    Then the operation is rejected

  @standard @negative @configure_integration
  Scenario: an "SQS" direct integration is configured on the "REST" "API" fails when the "API" already has an integration configured
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" already has an integration configured
    When an "SQS" direct integration is configured on the "REST" "API"
    Then the operation is rejected

  @standard @negative @configure_integration
  Scenario: an "SQS" direct integration is configured on the "REST" "API" fails when the queue does not exist
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no integration configured
    And the queue does not exist
    When an "SQS" direct integration is configured on the "REST" "API"
    Then the operation is rejected

  @standard @negative @configure_integration @lifecycle @internal
  Scenario: an "SQS" direct integration is configured on the "REST" "API" fails when the queue is not "ACTIVE"
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no integration configured
    And the queue exists
    And the queue is not "ACTIVE"
    When an "SQS" direct integration is configured on the "REST" "API"
    Then the operation is rejected
