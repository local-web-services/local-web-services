@apigateway @generated
Feature: Apigateway - A Root Resource Is Initialized For An "Api Gateway" "Api"

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @init_root_resource
  Scenario: a root resource is initialized for an "api gateway" "API"
    Given the "api gateway" "API" existed
    And the "api gateway" "API" was "ACTIVE"
    When a root resource is initialized for an "api gateway" "API"
    Then the root "api gateway" "resource" will be "ACTIVE"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @init_root_resource
  Scenario: a root resource is initialized for an "api gateway" "API" fails when the "api gateway" "API" did not exist
    Given the "api gateway" "API" did not exist
    When a root resource is initialized for an "api gateway" "API"
    Then the operation is rejected

  @guard @negative @init_root_resource @lifecycle
  Scenario: a root resource is initialized for an "api gateway" "API" fails when the "api gateway" "API" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "API" was not "ACTIVE"
    When a root resource is initialized for an "api gateway" "API"
    Then the operation is rejected
