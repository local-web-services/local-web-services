@apigatewaylambda @generated
Feature: ApigatewayLambda - The "Api Gateway" "Api" Receives A Http Request And Synchronously Invokes The "Lambda" "Function"

  # Generated from FizzBee spec: apigateway_lambda.fizz
  # Safety invariants: RequestRequiresActiveApi, InvocationRequiresActiveFunction, InvocationLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @handle_request
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had a Lambda integration configured
    And the integrated function was "ACTIVE"
    And a request slot is available
    And a "lambda" "invocation" slot is available
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Then the request and invocation are both "IN_PROGRESS"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @guard @negative @handle_request
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" fails when the "api gateway" "API" did not exist
    Given the "api gateway" "API" did not exist
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @handle_request @lifecycle
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was not "ACTIVE"
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @handle_request
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" fails when the "api gateway" "API" had no Lambda integration configured
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had no Lambda integration configured
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @handle_request @lifecycle
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" fails when the integrated function was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had a Lambda integration configured
    And the integrated function was not "ACTIVE"
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @handle_request @capacity
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" fails when no request slot is available
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had a Lambda integration configured
    And the integrated function was "ACTIVE"
    And no request slot is available
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @handle_request @capacity
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" fails when no invocation slot is available
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had a Lambda integration configured
    And the integrated function was "ACTIVE"
    And a request slot is available
    And no invocation slot is available
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Then the operation is rejected
