@apigateway @generated
Feature: Apigateway - A Rest Api Is Created With A Root Resource

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_api
  Scenario: a "REST" "API" is created with a root resource
    Given the "API" does not already exist
    And a resource slot is available
    When a "REST" "API" is created with a root resource
    Then the "API" is "ACTIVE" and its root resource is "ACTIVE"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @create_rest_api
  Scenario: a "REST" "API" is created with a root resource fails when the "API" already exists
    Given the "API" already exists
    When a "REST" "API" is created with a root resource
    Then the operation is rejected

  @guard @negative @internal @create_rest_api @capacity
  Scenario: a "REST" "API" is created with a root resource fails when no resource slot is available
    Given the "API" does not already exist
    And no resource slot is available
    When a "REST" "API" is created with a root resource
    Then the operation is rejected
