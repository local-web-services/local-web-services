@apigatewaylambda @generated
Feature: ApigatewayLambda - The Lambda Invocation Fails And The "Api Gateway" "Api" Returns An Error Response

  # Generated from FizzBee spec: apigateway_lambda.fizz
  # Safety invariants: RequestRequiresActiveApi, InvocationRequiresActiveFunction, InvocationLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the Lambda invocation fails and the "api gateway" "API" returns an error response
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation fails and the "api gateway" "API" returns an error response
    Then the invocation will be "FAILED" and the request will be "FAILED"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @guard @negative @invocation_fails @internal
  Scenario: the Lambda invocation fails and the "api gateway" "API" returns an error response fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation fails and the "api gateway" "API" returns an error response
    Then the operation is rejected
