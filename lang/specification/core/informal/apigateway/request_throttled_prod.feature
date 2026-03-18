@apigateway @generated
Feature: Apigateway - A Request Is Made To The Throttled Prod Stage

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @request_throttled_prod @internal
  Scenario: a request is made to the throttled prod stage
    Given the prod stage has throttling configured
    And throttling is enabled for the prod stage
    When a request is made to the throttled prod stage
    Then the request is throttled or passes non-deterministically
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @request_throttled_prod @internal
  Scenario: a request is made to the throttled prod stage fails when the prod stage does not have throttling configured
    Given the prod stage does not have throttling configured
    When a request is made to the throttled prod stage
    Then the operation is rejected

  @standard @negative @request_throttled_prod @internal
  Scenario: a request is made to the throttled prod stage fails when throttling is not enabled for the prod stage
    Given the prod stage has throttling configured
    And throttling is not enabled for the prod stage
    When a request is made to the throttled prod stage
    Then the operation is rejected
