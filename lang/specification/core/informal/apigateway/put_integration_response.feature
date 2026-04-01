@apigateway @generated
Feature: Apigateway - A 200 "Api Gateway" "Integration" Response Is Configured

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @put_integration_response
  Scenario: a 200 "api gateway" "integration" response is configured
    Given the "api gateway" "integration" existed
    And the "api gateway" "integration" existed
    When a 200 "api gateway" "integration" response is configured
    Then the "api gateway" "integration" response will exist
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

  @guard @negative @put_integration_response
  Scenario: a 200 "api gateway" "integration" response is configured fails when the "api gateway" "integration" did not exist
    Given the "api gateway" "integration" did not exist
    When a 200 "api gateway" "integration" response is configured
    Then the operation is rejected

  @guard @negative @put_integration_response
  Scenario: a 200 "api gateway" "integration" response is configured fails when the "api gateway" "integration" did not exist
    Given the "api gateway" "integration" existed
    And the "api gateway" "integration" did not exist
    When a 200 "api gateway" "integration" response is configured
    Then the operation is rejected
