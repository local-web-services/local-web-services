@apigateway @generated
Feature: Apigateway - A 200 Integration Response Is Configured

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @put_integration_response
  Scenario: a 200 integration response is configured
    Given the integration exists
    And the integration "EXISTS"
    When a 200 integration response is configured
    Then the integration response exists
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @put_integration_response
  Scenario: a 200 integration response is configured fails when the integration does not exist
    Given the integration does not exist
    When a 200 integration response is configured
    Then the operation is rejected

  @standard @negative @put_integration_response
  Scenario: a 200 integration response is configured fails when the integration does not exist
    Given the integration exists
    And the integration does not exist
    When a 200 integration response is configured
    Then the operation is rejected
