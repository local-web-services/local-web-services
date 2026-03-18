@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - A Step Functions Direct Integration Is Configured On The Rest Api

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @configure_integration
  Scenario: a Step Functions direct integration is configured on the "REST" "API"
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no integration configured
    And the state machine exists
    And the state machine is "ACTIVE"
    When a Step Functions direct integration is configured on the "REST" "API"
    Then the "API" will synchronously start and await an Express Workflow execution per request
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @standard @negative @configure_integration
  Scenario: a Step Functions direct integration is configured on the "REST" "API" fails when the "API" does not exist
    Given the "API" does not exist
    When a Step Functions direct integration is configured on the "REST" "API"
    Then the operation is rejected

  @standard @negative @configure_integration @lifecycle @internal
  Scenario: a Step Functions direct integration is configured on the "REST" "API" fails when the "API" is not "ACTIVE"
    Given the "API" exists
    And the "API" is not "ACTIVE"
    When a Step Functions direct integration is configured on the "REST" "API"
    Then the operation is rejected

  @standard @negative @configure_integration
  Scenario: a Step Functions direct integration is configured on the "REST" "API" fails when the "API" already has an integration configured
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" already has an integration configured
    When a Step Functions direct integration is configured on the "REST" "API"
    Then the operation is rejected

  @standard @negative @configure_integration
  Scenario: a Step Functions direct integration is configured on the "REST" "API" fails when the state machine does not exist
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no integration configured
    And the state machine does not exist
    When a Step Functions direct integration is configured on the "REST" "API"
    Then the operation is rejected

  @standard @negative @configure_integration @lifecycle @internal
  Scenario: a Step Functions direct integration is configured on the "REST" "API" fails when the state machine is not "ACTIVE"
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no integration configured
    And the state machine exists
    And the state machine is not "ACTIVE"
    When a Step Functions direct integration is configured on the "REST" "API"
    Then the operation is rejected
