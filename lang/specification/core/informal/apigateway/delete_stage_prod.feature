@apigateway @generated
Feature: Apigateway - The "Api Gateway" "Prod Stage" Is Deleted

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @delete_stage_prod
  Scenario: the "api gateway" "prod stage" is deleted
    Given the "api gateway" "prod stage" existed
    And the "api gateway" "prod stage" is "ACTIVE"
    When the "api gateway" "prod stage" is deleted
    Then the "api gateway" "prod stage" no longer will exist
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @delete_stage_prod
  Scenario: the "api gateway" "prod stage" is deleted fails when the "api gateway" "prod stage" did not exist
    Given the "api gateway" "prod stage" did not exist
    When the "api gateway" "prod stage" is deleted
    Then the operation is rejected

  @guard @negative @delete_stage_prod @lifecycle
  Scenario: the "api gateway" "prod stage" is deleted fails when the "api gateway" "prod stage" is not "ACTIVE"
    Given the "api gateway" "prod stage" existed
    And the "api gateway" "prod stage" is not "ACTIVE"
    When the "api gateway" "prod stage" is deleted
    Then the operation is rejected
