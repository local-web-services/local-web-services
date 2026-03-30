@apigateway @generated
Feature: Apigateway - A Get Method Is Created On A Resource

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @put_method_get
  Scenario: a "GET" method is created on a resource
    Given the method does not already exist
    And the resource exists
    And the resource is "ACTIVE"
    When a "GET" method is created on a resource
    Then the method "EXISTS" on the resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @put_method_get
  Scenario: a "GET" method is created on a resource fails when the method already exists
    Given the method already exists
    When a "GET" method is created on a resource
    Then the operation is rejected

  @guard @negative @put_method_get
  Scenario: a "GET" method is created on a resource fails when the resource does not exist
    Given the method does not already exist
    And the resource does not exist
    When a "GET" method is created on a resource
    Then the operation is rejected

  @guard @negative @put_method_get @lifecycle
  Scenario: a "GET" method is created on a resource fails when the resource is not "ACTIVE"
    Given the method does not already exist
    And the resource exists
    And the resource is not "ACTIVE"
    When a "GET" method is created on a resource
    Then the operation is rejected
