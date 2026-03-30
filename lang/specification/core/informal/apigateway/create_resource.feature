@apigateway @generated
Feature: Apigateway - A Child Resource Is Created Under An Existing Resource

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @create_resource
  Scenario: a child resource is created under an existing resource
    Given the resource slot is unallocated
    And the parent resource exists
    And the parent resource is "ACTIVE"
    When a child resource is created under an existing resource
    Then the new resource is "ACTIVE"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @internal @create_resource
  Scenario: a child resource is created under an existing resource fails when the resource slot is already allocated
    Given the resource slot is already allocated
    When a child resource is created under an existing resource
    Then the operation is rejected

  @guard @negative @create_resource
  Scenario: a child resource is created under an existing resource fails when the parent resource does not exist
    Given the resource slot is unallocated
    And the parent resource does not exist
    When a child resource is created under an existing resource
    Then the operation is rejected

  @guard @negative @create_resource @lifecycle
  Scenario: a child resource is created under an existing resource fails when the parent resource is not "ACTIVE"
    Given the resource slot is unallocated
    And the parent resource exists
    And the parent resource is not "ACTIVE"
    When a child resource is created under an existing resource
    Then the operation is rejected
