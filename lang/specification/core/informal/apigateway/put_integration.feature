@apigateway @generated
Feature: Apigateway - A Backend Integration Is Attached To A "Api Gateway" "Method"

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @put_integration
  Scenario: a backend integration is attached to a "api gateway" "method"
    Given the "api gateway" "method" existed
    And the "api gateway" "method" existed
    When a backend integration is attached to a "api gateway" "method"
    Then the "api gateway" "integration" will exist
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @put_integration
  Scenario: a backend integration is attached to a "api gateway" "method" fails when the "api gateway" "method" did not exist
    Given the "api gateway" "method" did not exist
    When a backend integration is attached to a "api gateway" "method"
    Then the operation is rejected

  @guard @negative @put_integration
  Scenario: a backend integration is attached to a "api gateway" "method" fails when the "api gateway" "method" did not exist
    Given the "api gateway" "method" existed
    And the "api gateway" "method" did not exist
    When a backend integration is attached to a "api gateway" "method"
    Then the operation is rejected
