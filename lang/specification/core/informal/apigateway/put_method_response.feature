@apigateway @generated
Feature: Apigateway - A 200 Method Response Is Configured

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @put_method_response
  Scenario: a 200 method response is configured
    Given the "api gateway" "method" existed
    And the "api gateway" "method" existed
    When a 200 method response is configured
    Then the "api gateway" "method" response will exist
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @put_method_response
  Scenario: a 200 method response is configured fails when the "api gateway" "method" did not exist
    Given the "api gateway" "method" did not exist
    When a 200 method response is configured
    Then the operation is rejected

  @guard @negative @put_method_response
  Scenario: a 200 method response is configured fails when the "api gateway" "method" did not exist
    Given the "api gateway" "method" existed
    And the "api gateway" "method" did not exist
    When a 200 method response is configured
    Then the operation is rejected
