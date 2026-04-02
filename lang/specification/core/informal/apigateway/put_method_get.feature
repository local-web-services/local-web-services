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
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

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
