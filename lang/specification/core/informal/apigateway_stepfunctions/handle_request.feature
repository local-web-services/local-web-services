@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - The "Api Gateway" "Api" Receives A Http Request And Synchronously Starts A Step Functions Execution

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @handle_request
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Step Functions integration configured
    And the integrated "step functions" "state machine" was "ACTIVE"
    And a "api gateway" "request" "slot" was "available"
    And a "step functions" "execution" "slot" was "available"
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Then the "api gateway" "request" will be "IN_PROGRESS" and the "step functions" "execution" will be "RUNNING"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @guard @negative @handle_request
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution fails when the "api gateway" "API" did not exist
    Given the "api gateway" "API" did not exist
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected

  @guard @negative @handle_request @lifecycle
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was not "ACTIVE"
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected

  @guard @negative @handle_request
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution fails when the "api gateway" "api" has no Step Functions integration configured
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no Step Functions integration configured
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected

  @guard @negative @handle_request @lifecycle
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution fails when the integrated "step functions" "state machine" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Step Functions integration configured
    And the integrated "step functions" "state machine" was not "ACTIVE"
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected

  @guard @negative @handle_request @capacity
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution fails when no "api gateway" "request" "slot" was "available"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Step Functions integration configured
    And the integrated "step functions" "state machine" was "ACTIVE"
    And no "api gateway" "request" "slot" was "available"
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected

  @guard @negative @handle_request @capacity
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution fails when no "step functions" "execution" "slot" was "available"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Step Functions integration configured
    And the integrated "step functions" "state machine" was "ACTIVE"
    And a "api gateway" "request" "slot" was "available"
    And no "step functions" "execution" "slot" was "available"
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected
