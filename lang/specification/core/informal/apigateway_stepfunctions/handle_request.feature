@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - The Api Receives An Http Request And Synchronously Starts A Step Functions Execution

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @handle_request
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Step Functions integration configured
    And the integrated state machine is "ACTIVE"
    And a request slot is available
    And an execution slot is available
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then the request and execution are both "IN_PROGRESS" and "RUNNING" respectively
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @standard @negative @handle_request
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution fails when the "API" does not exist
    Given the "API" does not exist
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected

  @standard @negative @handle_request @lifecycle
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution fails when the "API" is not "ACTIVE"
    Given the "API" exists
    And the "API" is not "ACTIVE"
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected

  @standard @negative @handle_request
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution fails when the "API" has no Step Functions integration configured
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no Step Functions integration configured
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected

  @standard @negative @handle_request @lifecycle
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution fails when the integrated state machine is not "ACTIVE"
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Step Functions integration configured
    And the integrated state machine is not "ACTIVE"
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected

  @standard @negative @internal @handle_request @capacity
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution fails when no request slot is available
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Step Functions integration configured
    And the integrated state machine is "ACTIVE"
    And no request slot is available
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected

  @standard @negative @internal @handle_request @capacity
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution fails when no execution slot is available
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has a Step Functions integration configured
    And the integrated state machine is "ACTIVE"
    And a request slot is available
    And no execution slot is available
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then the operation is rejected
