@apigateway @generated
Feature: Apigateway - A Method Is Deleted Along With Its Integration

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @delete_method
  Scenario: a method is deleted along with its integration
    Given the method exists
    And the method "EXISTS"
    When a method is deleted along with its integration
    Then the method is "DELETED" and its integration is "DELETED" if it exists
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @delete_method
  Scenario: a method is deleted along with its integration fails when the method does not exist
    Given the method does not exist
    When a method is deleted along with its integration
    Then the operation is rejected

  @standard @negative @delete_method
  Scenario: a method is deleted along with its integration fails when the method does not exist
    Given the method exists
    And the method does not exist
    When a method is deleted along with its integration
    Then the operation is rejected
