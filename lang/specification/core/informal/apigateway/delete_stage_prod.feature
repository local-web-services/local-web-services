@apigateway @generated
Feature: Apigateway - The Prod Stage Is Deleted

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @delete_stage_prod
  Scenario: the prod stage is deleted
    Given the prod stage exists
    And the prod stage is active
    When the prod stage is deleted
    Then the prod stage no longer exists
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @delete_stage_prod
  Scenario: the prod stage is deleted fails when the prod stage does not exist
    Given the prod stage does not exist
    When the prod stage is deleted
    Then the operation is rejected

  @guard @negative @delete_stage_prod @lifecycle
  Scenario: the prod stage is deleted fails when the prod stage is not active
    Given the prod stage exists
    And the prod stage is not active
    When the prod stage is deleted
    Then the operation is rejected
