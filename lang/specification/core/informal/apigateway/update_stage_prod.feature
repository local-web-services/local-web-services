@apigateway @generated
Feature: Apigateway - The Prod Stage Is Redeployed To A New Deployment

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @update_stage_prod
  Scenario: the prod stage is redeployed to a new deployment
    Given the deployment exists
    And the deployment is "ACTIVE"
    And the prod stage exists
    And the prod stage is active
    When the prod stage is redeployed to a new deployment
    Then the prod stage points to the new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @update_stage_prod
  Scenario: the prod stage is redeployed to a new deployment fails when the deployment does not exist
    Given the deployment does not exist
    When the prod stage is redeployed to a new deployment
    Then the operation is rejected

  @standard @negative @update_stage_prod @lifecycle @internal
  Scenario: the prod stage is redeployed to a new deployment fails when the deployment is not "ACTIVE"
    Given the deployment exists
    And the deployment is not "ACTIVE"
    When the prod stage is redeployed to a new deployment
    Then the operation is rejected

  @standard @negative @update_stage_prod
  Scenario: the prod stage is redeployed to a new deployment fails when the prod stage does not exist
    Given the deployment exists
    And the deployment is "ACTIVE"
    And the prod stage does not exist
    When the prod stage is redeployed to a new deployment
    Then the operation is rejected

  @standard @negative @update_stage_prod @lifecycle @internal
  Scenario: the prod stage is redeployed to a new deployment fails when the prod stage is not active
    Given the deployment exists
    And the deployment is "ACTIVE"
    And the prod stage exists
    And the prod stage is not active
    When the prod stage is redeployed to a new deployment
    Then the operation is rejected
