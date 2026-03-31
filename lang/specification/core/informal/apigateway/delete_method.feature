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
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

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
