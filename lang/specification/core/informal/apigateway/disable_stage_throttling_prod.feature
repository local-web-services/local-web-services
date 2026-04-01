@apigateway @generated
Feature: Apigateway - Throttling Was "Disabled" For The "Api Gateway" "Prod Stage"

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @disable_stage_throttling_prod
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage"
    Given the "api gateway" "prod stage" existed
    And the "api gateway" "prod stage" is "ACTIVE"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    Then "api gateway" "prod stage" requests will not be throttled
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

  @guard @negative @disable_stage_throttling_prod
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" fails when the "api gateway" "prod stage" did not exist
    Given the "api gateway" "prod stage" did not exist
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    Then the operation is rejected

  @guard @negative @disable_stage_throttling_prod @lifecycle
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" fails when the "api gateway" "prod stage" is not "ACTIVE"
    Given the "api gateway" "prod stage" existed
    And the "api gateway" "prod stage" is not "ACTIVE"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    Then the operation is rejected
