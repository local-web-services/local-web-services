@apigateway @generated
Feature: Apigateway - An "Api Gateway" "Integration" Is Deleted

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @delete_integration
  Scenario: an "api gateway" "integration" is deleted
    Given the "api gateway" "integration" existed
    And the "api gateway" "integration" existed
    When an "api gateway" "integration" is deleted
    Then the "api gateway" "integration" will be deleted
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

  @guard @negative @delete_integration
  Scenario: an "api gateway" "integration" is deleted fails when the "api gateway" "integration" did not exist
    Given the "api gateway" "integration" did not exist
    When an "api gateway" "integration" is deleted
    Then the operation is rejected

  @guard @negative @delete_integration
  Scenario: an "api gateway" "integration" is deleted fails when the "api gateway" "integration" did not exist
    Given the "api gateway" "integration" existed
    And the "api gateway" "integration" did not exist
    When an "api gateway" "integration" is deleted
    Then the operation is rejected
