@apigateway @generated
Feature: Apigateway - A Prod Stage Is Created For An Api

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @create_stage_prod
  Scenario: a prod stage is created for an "API"
    Given the deployment exists
    And the deployment is "ACTIVE"
    And the prod stage does not already exist for this "API"
    When a prod stage is created for an "API"
    Then the prod stage exists pointing to the deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @create_stage_prod
  Scenario: a prod stage is created for an "API" fails when the deployment does not exist
    Given the deployment does not exist
    When a prod stage is created for an "API"
    Then the operation is rejected

  @standard @negative @create_stage_prod @lifecycle @internal
  Scenario: a prod stage is created for an "API" fails when the deployment is not "ACTIVE"
    Given the deployment exists
    And the deployment is not "ACTIVE"
    When a prod stage is created for an "API"
    Then the operation is rejected

  @standard @negative @create_stage_prod
  Scenario: a prod stage is created for an "API" fails when the prod stage already exists for this "API"
    Given the deployment exists
    And the deployment is "ACTIVE"
    And the prod stage already exists for this "API"
    When a prod stage is created for an "API"
    Then the operation is rejected
