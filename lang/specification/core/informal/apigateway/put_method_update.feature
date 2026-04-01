@apigateway @generated
Feature: Apigateway - An Existing Method Is Updated

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @put_method_update
  Scenario: an existing method is updated
    Given the "api gateway" "method" existed
    And the "api gateway" "method" existed
    When an existing method is updated
    Then the "api gateway" "method" remains unchanged
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @put_method_update
  Scenario: an existing method is updated fails when the "api gateway" "method" did not exist
    Given the "api gateway" "method" did not exist
    When an existing method is updated
    Then the operation is rejected

  @guard @negative @put_method_update
  Scenario: an existing method is updated fails when the "api gateway" "method" did not exist
    Given the "api gateway" "method" existed
    And the "api gateway" "method" did not exist
    When an existing method is updated
    Then the operation is rejected
