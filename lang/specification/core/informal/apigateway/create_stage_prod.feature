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
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

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
