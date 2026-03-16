@apigateway @generated
Feature: Apigateway - Throttling Is Enabled For The Prod Stage

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @enable_stage_throttling_prod
  Scenario: throttling is enabled for the prod stage
    Given the prod stage exists
    And the prod stage is active
    When throttling is enabled for the prod stage
    Then prod stage requests are throttled
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @enable_stage_throttling_prod
  Scenario: throttling is enabled for the prod stage fails when the prod stage does not exist
    Given the prod stage does not exist
    When throttling is enabled for the prod stage
    Then the operation is rejected

  @standard @negative @enable_stage_throttling_prod @lifecycle
  Scenario: throttling is enabled for the prod stage fails when the prod stage is not active
    Given the prod stage exists
    And the prod stage is not active
    When throttling is enabled for the prod stage
    Then the operation is rejected
