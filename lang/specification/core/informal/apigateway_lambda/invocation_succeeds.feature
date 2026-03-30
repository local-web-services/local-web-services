@apigatewaylambda @generated
Feature: ApigatewayLambda - The Lambda Invocation Completes Successfully And The Api Returns A Successful Response

  # Generated from FizzBee spec: apigateway_lambda.fizz
  # Safety invariants: RequestRequiresActiveApi, InvocationRequiresActiveFunction, InvocationLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response
    Given an invocation is "IN_PROGRESS"
    When the Lambda invocation completes successfully and the "API" returns a successful response
    Then the invocation is "SUCCESS" and the request is "SUCCESS"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @guard @negative @invocation_succeeds @internal
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda invocation completes successfully and the "API" returns a successful response
    Then the operation is rejected
