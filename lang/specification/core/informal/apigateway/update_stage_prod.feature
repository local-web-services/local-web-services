@apigateway @generated
Feature: Apigateway - The "Api Gateway" "Prod Stage" Is Redeployed To A New Deployment

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @update_stage_prod
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment
    Given the "api gateway" "deployment" existed
    And the "api gateway" "deployment" was "ACTIVE"
    And the "api gateway" "prod stage" existed
    And the "api gateway" "prod stage" is "ACTIVE"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    Then the "api gateway" "prod stage" points to the new deployment
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

  @guard @negative @update_stage_prod
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment fails when the "api gateway" "deployment" did not exist
    Given the "api gateway" "deployment" did not exist
    When the "api gateway" "prod stage" is redeployed to a new deployment
    Then the operation is rejected

  @guard @negative @update_stage_prod @lifecycle
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment fails when the "api gateway" "deployment" was not "ACTIVE"
    Given the "api gateway" "deployment" existed
    And the "api gateway" "deployment" was not "ACTIVE"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    Then the operation is rejected

  @guard @negative @update_stage_prod
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment fails when the "api gateway" "prod stage" did not exist
    Given the "api gateway" "deployment" existed
    And the "api gateway" "deployment" was "ACTIVE"
    And the "api gateway" "prod stage" did not exist
    When the "api gateway" "prod stage" is redeployed to a new deployment
    Then the operation is rejected

  @guard @negative @update_stage_prod @lifecycle
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment fails when the "api gateway" "prod stage" is not "ACTIVE"
    Given the "api gateway" "deployment" existed
    And the "api gateway" "deployment" was "ACTIVE"
    And the "api gateway" "prod stage" existed
    And the "api gateway" "prod stage" is not "ACTIVE"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    Then the operation is rejected
