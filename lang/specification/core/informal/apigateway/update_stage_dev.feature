@apigateway @generated
Feature: Apigateway - The Dev Stage Is Redeployed To A New Deployment

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @update_stage_dev
  Scenario: the dev stage is redeployed to a new deployment
    Given the deployment exists
    And the deployment is "ACTIVE"
    And the dev stage exists
    And the dev stage is active
    When the dev stage is redeployed to a new deployment
    Then the dev stage points to the new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @update_stage_dev
  Scenario: the dev stage is redeployed to a new deployment fails when the deployment does not exist
    Given the deployment does not exist
    When the dev stage is redeployed to a new deployment
    Then the operation is rejected

  @standard @negative @update_stage_dev @lifecycle @internal
  Scenario: the dev stage is redeployed to a new deployment fails when the deployment is not "ACTIVE"
    Given the deployment exists
    And the deployment is not "ACTIVE"
    When the dev stage is redeployed to a new deployment
    Then the operation is rejected

  @standard @negative @update_stage_dev
  Scenario: the dev stage is redeployed to a new deployment fails when the dev stage does not exist
    Given the deployment exists
    And the deployment is "ACTIVE"
    And the dev stage does not exist
    When the dev stage is redeployed to a new deployment
    Then the operation is rejected

  @standard @negative @update_stage_dev @lifecycle @internal
  Scenario: the dev stage is redeployed to a new deployment fails when the dev stage is not active
    Given the deployment exists
    And the deployment is "ACTIVE"
    And the dev stage exists
    And the dev stage is not active
    When the dev stage is redeployed to a new deployment
    Then the operation is rejected
