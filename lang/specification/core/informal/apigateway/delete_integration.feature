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
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

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
