@apigateway @generated
Feature: Apigateway - A Rest Api Is Deleted

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @delete_rest_api
  Scenario: a "REST" "API" is deleted
    Given the "API" exists
    And the "API" is "ACTIVE"
    When a "REST" "API" is deleted
    Then the "API" is "DELETED" along with all its resources, methods, integrations, deployments, and stages
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @delete_rest_api
  Scenario: a "REST" "API" is deleted fails when the "API" does not exist
    Given the "API" does not exist
    When a "REST" "API" is deleted
    Then the operation is rejected

  @standard @negative @delete_rest_api @lifecycle @internal
  Scenario: a "REST" "API" is deleted fails when the "API" is not "ACTIVE"
    Given the "API" exists
    And the "API" is not "ACTIVE"
    When a "REST" "API" is deleted
    Then the operation is rejected
