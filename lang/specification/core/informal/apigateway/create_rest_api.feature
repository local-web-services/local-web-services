@apigateway @generated
Feature: Apigateway - A Rest Api Is Created

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_api
  Scenario: a "REST" "API" is created
    Given the "API" does not already exist
    When a "REST" "API" is created
    Then the "API" is "ACTIVE"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @create_rest_api
  Scenario: a "REST" "API" is created fails when the "API" already exists
    Given the "API" already exists
    When a "REST" "API" is created
    Then the operation is rejected
