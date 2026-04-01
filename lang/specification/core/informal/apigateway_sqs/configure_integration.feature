@apigatewaysqs @generated
Feature: ApigatewaySqs - A Sqs Direct Integration Is Configured On The "Api Gateway" "Api"

  # Generated from FizzBee spec: apigateway_sqs.fizz
  # Safety invariants: RequestRequiresActiveApi, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @configure_integration
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had no integration configured
    And the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    When a "SQS" direct integration is configured on the "api gateway" "api"
    Then the "api gateway" "API" will enqueue incoming requests as "SQS" messages without invoking Lambda
    And every "ACCEPTED" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @guard @negative @configure_integration
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api" fails when the "api gateway" "API" did not exist
    Given the "api gateway" "API" did not exist
    When a "SQS" direct integration is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_integration @lifecycle
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api" fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was not "ACTIVE"
    When a "SQS" direct integration is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_integration
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api" fails when the "api gateway" "API" already had an "api gateway" "integration" configured
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" already had an "api gateway" "integration" configured
    When a "SQS" direct integration is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_integration
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api" fails when the "sqs" "queue" did not exist
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had no integration configured
    And the "sqs" "queue" did not exist
    When a "SQS" direct integration is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_integration @lifecycle
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api" fails when the "sqs" "queue" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had no integration configured
    And the "sqs" "queue" existed
    And the "sqs" "queue" was not "ACTIVE"
    When a "SQS" direct integration is configured on the "api gateway" "api"
    Then the operation is rejected
