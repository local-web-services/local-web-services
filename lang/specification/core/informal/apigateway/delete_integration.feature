@apigateway @generated
Feature: Apigateway - An Integration Is Deleted

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @delete_integration
  Scenario: an integration is deleted
    Given the integration exists
    And the integration "EXISTS"
    When an integration is deleted
    Then the integration is "DELETED"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @delete_integration
  Scenario: an integration is deleted fails when the integration does not exist
    Given the integration does not exist
    When an integration is deleted
    Then the operation is rejected

  @guard @negative @delete_integration
  Scenario: an integration is deleted fails when the integration does not exist
    Given the integration exists
    And the integration does not exist
    When an integration is deleted
    Then the operation is rejected
