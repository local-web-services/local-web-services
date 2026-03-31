@apigatewaylambda @generated
Feature: ApigatewayLambda - A Lambda Integration Is Configured On The "Api Gateway" "Api"

  # Generated from FizzBee spec: apigateway_lambda.fizz
  # Safety invariants: RequestRequiresActiveApi, InvocationRequiresActiveFunction, InvocationLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @configure_integration
  Scenario: a Lambda integration is configured on the "api gateway" "api"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had no integration configured
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When a Lambda integration is configured on the "api gateway" "api"
    Then the "api gateway" "API" will synchronously invoke the function when a request arrives
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @guard @negative @configure_integration
  Scenario: a Lambda integration is configured on the "api gateway" "api" fails when the "api gateway" "API" did not exist
    Given the "api gateway" "API" did not exist
    When a Lambda integration is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_integration @lifecycle
  Scenario: a Lambda integration is configured on the "api gateway" "api" fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was not "ACTIVE"
    When a Lambda integration is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_integration
  Scenario: a Lambda integration is configured on the "api gateway" "api" fails when the "api gateway" "API" already had an "api gateway" "integration" configured
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" already had an "api gateway" "integration" configured
    When a Lambda integration is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_integration
  Scenario: a Lambda integration is configured on the "api gateway" "api" fails when the "lambda" "function" did not exist
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had no integration configured
    And the "lambda" "function" did not exist
    When a Lambda integration is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_integration @lifecycle
  Scenario: a Lambda integration is configured on the "api gateway" "api" fails when the "lambda" "function" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had no integration configured
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a Lambda integration is configured on the "api gateway" "api"
    Then the operation is rejected
