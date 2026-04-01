@apigateway @generated
Feature: Apigateway - An Existing "Api Gateway" "Method" Is Updated

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @put_method_update
  Scenario: an existing "api gateway" "method" is updated
    Given the "api gateway" "method" existed
    And the "api gateway" "method" existed
    When an existing "api gateway" "method" is updated
    Then the "api gateway" "method" remains unchanged
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

  @guard @negative @put_method_update
  Scenario: an existing "api gateway" "method" is updated fails when the "api gateway" "method" did not exist
    Given the "api gateway" "method" did not exist
    When an existing "api gateway" "method" is updated
    Then the operation is rejected

  @guard @negative @put_method_update
  Scenario: an existing "api gateway" "method" is updated fails when the "api gateway" "method" did not exist
    Given the "api gateway" "method" existed
    And the "api gateway" "method" did not exist
    When an existing "api gateway" "method" is updated
    Then the operation is rejected
