@apigatewaylambda @generated
Feature: ApigatewayLambda - The Api Receives An Http Request And Synchronously Invokes The Lambda Function

  # Generated from FizzBee spec: apigateway_lambda.fizz
  # Safety invariants: RequestRequiresActiveApi, InvocationRequiresActiveFunction, InvocationLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @handle_request
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Lambda integration configured
    And the integrated function is "ACTIVE"
    And a request slot is available
    And an invocation slot is available
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Then the request and invocation are both "IN_PROGRESS"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @standard @negative @handle_request
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function fails when the "API" does not exist
    Given the "API" does not exist
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Then the operation is rejected

  @standard @negative @handle_request @lifecycle @internal
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function fails when the "API" is not "ACTIVE"
    Given the "API" exists
    And the "API" is not "ACTIVE"
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Then the operation is rejected

  @standard @negative @handle_request
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function fails when the "API" has no Lambda integration configured
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no Lambda integration configured
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Then the operation is rejected

  @standard @negative @handle_request @lifecycle @internal
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function fails when the integrated function is not "ACTIVE"
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Lambda integration configured
    And the integrated function is not "ACTIVE"
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Then the operation is rejected

  @standard @negative @handle_request @capacity @internal
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function fails when no request slot is available
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Lambda integration configured
    And the integrated function is "ACTIVE"
    And no request slot is available
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Then the operation is rejected

  @standard @negative @handle_request @capacity @internal
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function fails when no invocation slot is available
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Lambda integration configured
    And the integrated function is "ACTIVE"
    And a request slot is available
    And no invocation slot is available
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Then the operation is rejected
