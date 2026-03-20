@apigateway @generated
Feature: Apigateway - A Root Resource Is Initialized For An Api

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @init_root_resource
  Scenario: a root resource is initialized for an "API"
    Given the "API" exists
    And the "API" is "ACTIVE"
    When a root resource is initialized for an "API"
    Then the root resource is "ACTIVE"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @init_root_resource
  Scenario: a root resource is initialized for an "API" fails when the "API" does not exist
    Given the "API" does not exist
    When a root resource is initialized for an "API"
    Then the operation is rejected

  @standard @negative @init_root_resource @lifecycle
  Scenario: a root resource is initialized for an "API" fails when the "API" is not "ACTIVE"
    Given the "API" exists
    And the "API" is not "ACTIVE"
    When a root resource is initialized for an "API"
    Then the operation is rejected
