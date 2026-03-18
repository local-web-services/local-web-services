@apigateway @generated
Feature: Apigateway - A Backend Integration Is Attached To A Method

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @put_integration
  Scenario: a backend integration is attached to a method
    Given the method exists
    And the method "EXISTS"
    When a backend integration is attached to a method
    Then the integration "EXISTS"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @put_integration
  Scenario: a backend integration is attached to a method fails when the method does not exist
    Given the method does not exist
    When a backend integration is attached to a method
    Then the operation is rejected

  @standard @negative @put_integration
  Scenario: a backend integration is attached to a method fails when the method does not exist
    Given the method exists
    And the method does not exist
    When a backend integration is attached to a method
    Then the operation is rejected
