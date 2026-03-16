@apigateway @generated
Feature: Apigateway - Throttling Is Disabled For The Dev Stage

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @disable_stage_throttling_dev
  Scenario: throttling is disabled for the dev stage
    Given the dev stage exists
    And the dev stage is active
    When throttling is disabled for the dev stage
    Then dev stage requests are not throttled
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @disable_stage_throttling_dev
  Scenario: throttling is disabled for the dev stage fails when the dev stage does not exist
    Given the dev stage does not exist
    When throttling is disabled for the dev stage
    Then the operation is rejected

  @standard @negative @disable_stage_throttling_dev @lifecycle
  Scenario: throttling is disabled for the dev stage fails when the dev stage is not active
    Given the dev stage exists
    And the dev stage is not active
    When throttling is disabled for the dev stage
    Then the operation is rejected
