@apigateway @generated
Feature: Apigateway - A "Api Gateway" "Backend Integration" Is Called

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @integration_timeout @internal
  Scenario: a "api gateway" "backend integration" is called
    Given the "api gateway" "integration" existed
    And the "api gateway" "integration" existed
    When a "api gateway" "backend integration" is called
    Then the "api gateway" "integration" times out or responds non-deterministically
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

  @guard @negative @integration_timeout @internal
  Scenario: a "api gateway" "backend integration" is called fails when the "api gateway" "integration" did not exist
    Given the "api gateway" "integration" did not exist
    When a "api gateway" "backend integration" is called
    Then the operation is rejected

  @guard @negative @integration_timeout @internal
  Scenario: a "api gateway" "backend integration" is called fails when the "api gateway" "integration" did not exist
    Given the "api gateway" "integration" existed
    And the "api gateway" "integration" did not exist
    When a "api gateway" "backend integration" is called
    Then the operation is rejected
