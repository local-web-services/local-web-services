@apigatewaylambda @generated
Feature: ApigatewayLambda - A Rest Api Is Created

  # Generated from FizzBee spec: apigateway_lambda.fizz
  # Safety invariants: RequestRequiresActiveApi, InvocationRequiresActiveFunction, InvocationLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_api
  Scenario: a "REST" "API" is created
    Given the "API" does not already exist
    When a "REST" "API" is created
    Then the "API" is "ACTIVE" with no Lambda integration configured
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @guard @negative @create_rest_api
  Scenario: a "REST" "API" is created fails when the "API" already exists
    Given the "API" already exists
    When a "REST" "API" is created
    Then the operation is rejected
