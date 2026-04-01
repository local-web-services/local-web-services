@apigateway @generated
Feature: Apigateway - A "Api Gateway" "Method" Is Deleted Along With Its Integration

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @delete_method
  Scenario: a "api gateway" "method" is deleted along with its integration
    Given the "api gateway" "method" existed
    And the "api gateway" "method" existed
    When a "api gateway" "method" is deleted along with its integration
    Then the "api gateway" "method" will be deleted and its integration will be deleted if it will exist
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

  @guard @negative @delete_method
  Scenario: a "api gateway" "method" is deleted along with its integration fails when the "api gateway" "method" did not exist
    Given the "api gateway" "method" did not exist
    When a "api gateway" "method" is deleted along with its integration
    Then the operation is rejected

  @guard @negative @delete_method
  Scenario: a "api gateway" "method" is deleted along with its integration fails when the "api gateway" "method" did not exist
    Given the "api gateway" "method" existed
    And the "api gateway" "method" did not exist
    When a "api gateway" "method" is deleted along with its integration
    Then the operation is rejected
