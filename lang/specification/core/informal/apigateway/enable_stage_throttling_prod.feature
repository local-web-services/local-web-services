@apigateway @generated
Feature: Apigateway - Throttling Was "Enabled" For The "Api Gateway" "Prod Stage"

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @enable_stage_throttling_prod
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage"
    Given the "api gateway" "prod stage" existed
    And the "api gateway" "prod stage" is "ACTIVE"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    Then prod stage requests are throttled
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @enable_stage_throttling_prod
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" fails when the "api gateway" "prod stage" did not exist
    Given the "api gateway" "prod stage" did not exist
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    Then the operation is rejected

  @guard @negative @enable_stage_throttling_prod @lifecycle
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" fails when the "api gateway" "prod stage" is not "ACTIVE"
    Given the "api gateway" "prod stage" existed
    And the "api gateway" "prod stage" is not "ACTIVE"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    Then the operation is rejected
