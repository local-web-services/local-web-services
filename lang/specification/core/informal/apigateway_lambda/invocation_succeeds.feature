@apigatewaylambda @generated
Feature: ApigatewayLambda - The "Lambda" "Function" Invocation Completes Successfully And The "Api Gateway" "Api" Returns A Successful Response

  # Generated from FizzBee spec: apigateway_lambda.fizz
  # Safety invariants: RequestRequiresActiveApi, InvocationRequiresActiveFunction, InvocationLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    Then the "lambda" "invocation" will be "SUCCESS" and the "api gateway" "request" will be "SUCCESS"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    Then the operation is rejected
