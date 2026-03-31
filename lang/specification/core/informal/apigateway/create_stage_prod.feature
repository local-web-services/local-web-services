@apigateway @generated
Feature: Apigateway - A Prod Stage Is Created For An "Api Gateway" "Api"

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @create_stage_prod
  Scenario: a prod stage is created for an "api gateway" "API"
    Given the "api gateway" "deployment" existed
    And the "api gateway" "deployment" was "ACTIVE"
    And the "api gateway" "prod stage" did not already exist for this "API"
    When a prod stage is created for an "api gateway" "API"
    Then the "api gateway" "prod stage" will exist pointing to the "api gateway" "deployment"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @create_stage_prod
  Scenario: a prod stage is created for an "api gateway" "API" fails when the "api gateway" "deployment" did not exist
    Given the "api gateway" "deployment" did not exist
    When a prod stage is created for an "api gateway" "API"
    Then the operation is rejected

  @guard @negative @create_stage_prod @lifecycle
  Scenario: a prod stage is created for an "api gateway" "API" fails when the "api gateway" "deployment" was not "ACTIVE"
    Given the "api gateway" "deployment" existed
    And the "api gateway" "deployment" was not "ACTIVE"
    When a prod stage is created for an "api gateway" "API"
    Then the operation is rejected

  @guard @negative @create_stage_prod
  Scenario: a prod stage is created for an "api gateway" "API" fails when the "api gateway" "prod stage" already existed for this "API"
    Given the "api gateway" "deployment" existed
    And the "api gateway" "deployment" was "ACTIVE"
    And the "api gateway" "prod stage" already existed for this "API"
    When a prod stage is created for an "api gateway" "API"
    Then the operation is rejected
