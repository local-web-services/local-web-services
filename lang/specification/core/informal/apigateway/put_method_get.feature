@apigateway @generated
Feature: Apigateway - A Get Method Is Created On A "Api Gateway" "Resource"

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @put_method_get
  Scenario: a "GET" method is created on a "api gateway" "resource"
    Given the "api gateway" "method" did not already exist
    And the "api gateway" "resource" existed
    And the "api gateway" "resource" was "ACTIVE"
    When a "GET" method is created on a "api gateway" "resource"
    Then the "api gateway" "method" will exist on the "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @put_method_get
  Scenario: a "GET" method is created on a "api gateway" "resource" fails when the "api gateway" "method" already existed
    Given the "api gateway" "method" already existed
    When a "GET" method is created on a "api gateway" "resource"
    Then the operation is rejected

  @guard @negative @put_method_get
  Scenario: a "GET" method is created on a "api gateway" "resource" fails when the "api gateway" "resource" did not exist
    Given the "api gateway" "method" did not already exist
    And the "api gateway" "resource" did not exist
    When a "GET" method is created on a "api gateway" "resource"
    Then the operation is rejected

  @guard @negative @put_method_get @lifecycle
  Scenario: a "GET" method is created on a "api gateway" "resource" fails when the "api gateway" "resource" was not "ACTIVE"
    Given the "api gateway" "method" did not already exist
    And the "api gateway" "resource" existed
    And the "api gateway" "resource" was not "ACTIVE"
    When a "GET" method is created on a "api gateway" "resource"
    Then the operation is rejected
