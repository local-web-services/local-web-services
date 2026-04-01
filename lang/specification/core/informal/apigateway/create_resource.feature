@apigateway @generated
Feature: Apigateway - A Child "Api Gateway" "Resource" Is Created Under An Existing "Api Gateway" "Resource"

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @create_resource
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given the "api gateway" "resource" slot is unallocated
    And the parent "api gateway" "resource" existed
    And the parent "api gateway" "resource" was "ACTIVE"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Then the new "api gateway" "resource" will be "ACTIVE"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @create_resource
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" fails when the "api gateway" "resource" slot is already allocated
    Given the "api gateway" "resource" slot is already allocated
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Then the operation is rejected

  @guard @negative @create_resource
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" fails when the parent "api gateway" "resource" did not exist
    Given the "api gateway" "resource" slot is unallocated
    And the parent "api gateway" "resource" did not exist
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Then the operation is rejected

  @guard @negative @create_resource @lifecycle
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" fails when the parent "api gateway" "resource" was not "ACTIVE"
    Given the "api gateway" "resource" slot is unallocated
    And the parent "api gateway" "resource" existed
    And the parent "api gateway" "resource" was not "ACTIVE"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Then the operation is rejected
