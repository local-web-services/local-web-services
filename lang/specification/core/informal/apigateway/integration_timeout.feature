@apigateway @generated
Feature: Apigateway - A Backend Integration Is Called

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @integration_timeout @internal
  Scenario: a backend integration is called
    Given the integration exists
    And the integration "EXISTS"
    When a backend integration is called
    Then the integration times out or responds non-deterministically
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @integration_timeout @internal
  Scenario: a backend integration is called fails when the integration does not exist
    Given the integration does not exist
    When a backend integration is called
    Then the operation is rejected

  @guard @negative @integration_timeout @internal
  Scenario: a backend integration is called fails when the integration does not exist
    Given the integration exists
    And the integration does not exist
    When a backend integration is called
    Then the operation is rejected
