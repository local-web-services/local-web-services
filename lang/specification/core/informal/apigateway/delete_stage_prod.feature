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
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

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
