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
    And the integrated state machine was "ACTIVE"
    And a request slot is available
    And an "step functions" "execution" slot is available
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Then the request and execution are both "IN_PROGRESS" and "RUNNING" respectively
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

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
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution fails when the integrated state machine was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Step Functions integration configured
    And the integrated state machine was not "ACTIVE"
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected

  @guard @negative @handle_request @capacity
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution fails when no request slot is available
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Step Functions integration configured
    And the integrated state machine was "ACTIVE"
    And no request slot is available
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected

  @guard @negative @handle_request @capacity
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution fails when no execution slot is available
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a Step Functions integration configured
    And the integrated state machine was "ACTIVE"
    And a request slot is available
    And no execution slot is available
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected
