@apigateway @generated
Feature: Apigateway - A Non-Root Resource Is Deleted Along With Its Methods And Integrations

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @delete_resource
  Scenario: a non-root resource is deleted along with its methods and integrations
    Given the resource exists
    And the resource is "ACTIVE"
    And the resource has a path
    And the resource is not the root resource
    When a non-root resource is deleted along with its methods and integrations
    Then the resource is "DELETED" along with all its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @delete_resource
  Scenario: a non-root resource is deleted along with its methods and integrations fails when the resource does not exist
    Given the resource does not exist
    When a non-root resource is deleted along with its methods and integrations
    Then the operation is rejected

  @guard @negative @delete_resource @lifecycle
  Scenario: a non-root resource is deleted along with its methods and integrations fails when the resource is not "ACTIVE"
    Given the resource exists
    And the resource is not "ACTIVE"
    When a non-root resource is deleted along with its methods and integrations
    Then the operation is rejected

  @guard @negative @delete_resource
  Scenario: a non-root resource is deleted along with its methods and integrations fails when the resource does not have a path
    Given the resource exists
    And the resource is "ACTIVE"
    And the resource does not have a path
    When a non-root resource is deleted along with its methods and integrations
    Then the operation is rejected

  @guard @negative @delete_resource
  Scenario: a non-root resource is deleted along with its methods and integrations fails when the resource is the root resource
    Given the resource exists
    And the resource is "ACTIVE"
    And the resource has a path
    And the resource is the root resource
    When a non-root resource is deleted along with its methods and integrations
    Then the operation is rejected
