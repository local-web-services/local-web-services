@apigateway @generated
Feature: Apigateway - A "Api Gateway" "Rest Api" Is Created With A Root Resource

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_api
  Scenario: a "api gateway" "REST API" is created with a root resource
    Given the "api gateway" "API" did not already exist
    And a "api gateway" "resource" slot is available
    When a "api gateway" "REST API" is created with a root resource
    Then the "api gateway" "API" will be "ACTIVE" and its root resource will be "ACTIVE"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @create_rest_api
  Scenario: a "api gateway" "REST API" is created with a root resource fails when the "api gateway" "API" already existed
    Given the "api gateway" "API" already existed
    When a "api gateway" "REST API" is created with a root resource
    Then the operation is rejected

  @guard @negative @create_rest_api @capacity
  Scenario: a "api gateway" "REST API" is created with a root resource fails when no resource slot is available
    Given the "api gateway" "API" did not already exist
    And no resource slot is available
    When a "api gateway" "REST API" is created with a root resource
    Then the operation is rejected
