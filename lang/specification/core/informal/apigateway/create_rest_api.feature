@apigateway @generated
Feature: Apigateway - A "Api Gateway" "Rest Api" Is Created With A Root Resource

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_api
  Scenario: a "api gateway" "REST API" is created with a root resource
    Given the "api gateway" "API" did not already exist
    And a "api gateway" "resource" "slot" was "available"
    When a "api gateway" "REST API" is created with a root resource
    Then the "api gateway" "API" will be "ACTIVE" and its root resource will be "ACTIVE"
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

  @guard @negative @create_rest_api
  Scenario: a "api gateway" "REST API" is created with a root resource fails when the "api gateway" "API" already existed
    Given the "api gateway" "API" already existed
    When a "api gateway" "REST API" is created with a root resource
    Then the operation is rejected

  @guard @negative @create_rest_api @capacity
  Scenario: a "api gateway" "REST API" is created with a root resource fails when no "api gateway" "resource" "slot" was "available"
    Given the "api gateway" "API" did not already exist
    And no "api gateway" "resource" "slot" was "available"
    When a "api gateway" "REST API" is created with a root resource
    Then the operation is rejected
