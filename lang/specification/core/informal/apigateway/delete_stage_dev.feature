@apigateway @generated
Feature: Apigateway - The Dev Stage Is Deleted

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @delete_stage_dev
  Scenario: the dev stage is deleted
    Given the dev stage exists
    And the dev stage is active
    When the dev stage is deleted
    Then the dev stage no longer exists
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @delete_stage_dev
  Scenario: the dev stage is deleted fails when the dev stage does not exist
    Given the dev stage does not exist
    When the dev stage is deleted
    Then the operation is rejected

  @standard @negative @delete_stage_dev @lifecycle @internal
  Scenario: the dev stage is deleted fails when the dev stage is not active
    Given the dev stage exists
    And the dev stage is not active
    When the dev stage is deleted
    Then the operation is rejected
