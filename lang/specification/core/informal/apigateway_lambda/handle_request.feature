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
    And the integrated "lambda" "function" was "ACTIVE"
    And a "request" "slot" was "available"
    And a "lambda" "invocation" slot is available
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Then the "api gateway" "request" and "lambda" "invocation" are both "IN_PROGRESS"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

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
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" fails when the integrated "lambda" "function" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had a Lambda integration configured
    And the integrated "lambda" "function" was not "ACTIVE"
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @handle_request @capacity
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" fails when no "request" "slot" was "available"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had a Lambda integration configured
    And the integrated "lambda" "function" was "ACTIVE"
    And no "request" "slot" was "available"
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @handle_request @capacity
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" fails when no "lambda" "invocation" "slot" was "available"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had a Lambda integration configured
    And the integrated "lambda" "function" was "ACTIVE"
    And a "request" "slot" was "available"
    And no "lambda" "invocation" "slot" was "available"
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Then the operation is rejected
