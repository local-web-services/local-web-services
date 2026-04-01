@apigateway @generated
Feature: Apigateway - A Request Is Made To The Throttled "Api Gateway" "Prod Stage"

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @request_throttled_prod @internal
  Scenario: a request is made to the throttled "api gateway" "prod stage"
    Given the "api gateway" "prod stage" has throttling configured
    And throttling was "ENABLED" for the "api gateway" "prod stage"
    When a request is made to the throttled "api gateway" "prod stage"
    Then the "api gateway" "prod stage" request will be throttled or pass non-deterministically
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

  @guard @negative @request_throttled_prod @internal
  Scenario: a request is made to the throttled "api gateway" "prod stage" fails when the "api gateway" "prod stage" does not have throttling configured
    Given the "api gateway" "prod stage" does not have throttling configured
    When a request is made to the throttled "api gateway" "prod stage"
    Then the operation is rejected

  @guard @negative @request_throttled_prod @internal
  Scenario: a request is made to the throttled "api gateway" "prod stage" fails when throttling was not "ENABLED" for the "api gateway" "prod stage"
    Given the "api gateway" "prod stage" has throttling configured
    And throttling was not "ENABLED" for the "api gateway" "prod stage"
    When a request is made to the throttled "api gateway" "prod stage"
    Then the operation is rejected
