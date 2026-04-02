@apigateway @generated
Feature: Apigateway - A "Api Gateway" "Rest Api" Is Deleted

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @delete_rest_api
  Scenario: a "api gateway" "REST API" is deleted
    Given the "api gateway" "API" existed
    And the "api gateway" "API" was "ACTIVE"
    When a "api gateway" "REST API" is deleted
    Then the "api gateway" "API" will be deleted along with all its resources, methods, integrations, deployments, and stages
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

  @guard @negative @delete_rest_api
  Scenario: a "api gateway" "REST API" is deleted fails when the "api gateway" "API" did not exist
    Given the "api gateway" "API" did not exist
    When a "api gateway" "REST API" is deleted
    Then the operation is rejected

  @guard @negative @delete_rest_api @lifecycle
  Scenario: a "api gateway" "REST API" is deleted fails when the "api gateway" "API" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "API" was not "ACTIVE"
    When a "api gateway" "REST API" is deleted
    Then the operation is rejected
