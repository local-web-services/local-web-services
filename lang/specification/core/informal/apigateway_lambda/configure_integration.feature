@apigatewaylambda @generated
Feature: ApigatewayLambda - A Lambda Integration Is Configured On The Rest Api

  # Generated from FizzBee spec: apigateway_lambda.fizz
  # Safety invariants: RequestRequiresActiveApi, InvocationRequiresActiveFunction, InvocationLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @configure_integration
  Scenario: a Lambda integration is configured on the "REST" "API"
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no integration configured
    And the function exists
    And the function is "ACTIVE"
    When a Lambda integration is configured on the "REST" "API"
    Then the "API" will synchronously invoke the function when a request arrives
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @standard @negative @configure_integration
  Scenario: a Lambda integration is configured on the "REST" "API" fails when the "API" does not exist
    Given the "API" does not exist
    When a Lambda integration is configured on the "REST" "API"
    Then the operation is rejected

  @standard @negative @configure_integration @lifecycle
  Scenario: a Lambda integration is configured on the "REST" "API" fails when the "API" is not "ACTIVE"
    Given the "API" exists
    And the "API" is not "ACTIVE"
    When a Lambda integration is configured on the "REST" "API"
    Then the operation is rejected

  @standard @negative @configure_integration
  Scenario: a Lambda integration is configured on the "REST" "API" fails when the "API" already has an integration configured
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" already has an integration configured
    When a Lambda integration is configured on the "REST" "API"
    Then the operation is rejected

  @standard @negative @configure_integration
  Scenario: a Lambda integration is configured on the "REST" "API" fails when the function does not exist
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no integration configured
    And the function does not exist
    When a Lambda integration is configured on the "REST" "API"
    Then the operation is rejected

  @standard @negative @configure_integration @lifecycle
  Scenario: a Lambda integration is configured on the "REST" "API" fails when the function is not "ACTIVE"
    Given the "API" exists
    And the "API" is "ACTIVE"
    And the "API" has no integration configured
    And the function exists
    And the function is not "ACTIVE"
    When a Lambda integration is configured on the "REST" "API"
    Then the operation is rejected
