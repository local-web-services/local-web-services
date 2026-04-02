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
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

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
