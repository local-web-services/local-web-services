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
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

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
