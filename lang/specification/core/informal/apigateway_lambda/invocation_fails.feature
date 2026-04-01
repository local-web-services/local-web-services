@apigatewaylambda @generated
Feature: ApigatewayLambda - The "Lambda" "Function" Invocation Fails And The "Api Gateway" "Api" Returns An Error Response

  # Generated from FizzBee spec: apigateway_lambda.fizz
  # Safety invariants: RequestRequiresActiveApi, InvocationRequiresActiveFunction, InvocationLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    Then the "lambda" "invocation" will be "FAILED" and the "api gateway" "request" will be "FAILED"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @guard @negative @invocation_fails @internal
  Scenario: the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    Then the operation is rejected
