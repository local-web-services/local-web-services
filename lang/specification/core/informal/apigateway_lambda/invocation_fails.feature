@apigatewaylambda @generated
Feature: ApigatewayLambda - The Lambda Invocation Fails And The Api Returns An Error Response

  # Generated from FizzBee spec: apigateway_lambda.fizz
  # Safety invariants: RequestRequiresActiveApi, InvocationRequiresActiveFunction, InvocationLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the Lambda invocation fails and the "API" returns an error response
    Given an invocation is "IN_PROGRESS"
    When the Lambda invocation fails and the "API" returns an error response
    Then the invocation is "FAILED" and the request is "FAILED"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @standard @negative @invocation_fails @internal
  Scenario: the Lambda invocation fails and the "API" returns an error response fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda invocation fails and the "API" returns an error response
    Then the operation is rejected
