@apigateway @generated
Feature: Apigateway - A Non-Root "Api Gateway" "Resource" Is Deleted Along With Its Methods And Integrations

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @delete_resource
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given the "api gateway" "resource" existed
    And the "api gateway" "resource" was "ACTIVE"
    And the "api gateway" "resource" has a path
    And the "api gateway" "resource" is not the root "api gateway" "resource"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Then the "api gateway" "resource" will be deleted along with all its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @delete_resource
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations fails when the "api gateway" "resource" did not exist
    Given the "api gateway" "resource" did not exist
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Then the operation is rejected

  @guard @negative @delete_resource @lifecycle
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations fails when the "api gateway" "resource" was not "ACTIVE"
    Given the "api gateway" "resource" existed
    And the "api gateway" "resource" was not "ACTIVE"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Then the operation is rejected

  @guard @negative @delete_resource
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations fails when the "api gateway" "resource" does not have a path
    Given the "api gateway" "resource" existed
    And the "api gateway" "resource" was "ACTIVE"
    And the "api gateway" "resource" does not have a path
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Then the operation is rejected

  @guard @negative @delete_resource
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations fails when the "api gateway" "resource" is the root "api gateway" "resource"
    Given the "api gateway" "resource" existed
    And the "api gateway" "resource" was "ACTIVE"
    And the "api gateway" "resource" has a path
    And the "api gateway" "resource" is the root "api gateway" "resource"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Then the operation is rejected
