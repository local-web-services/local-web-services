@apigateway @generated
Feature: Apigateway - A Request Is Made To The Throttled Dev Stage

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @request_throttled_dev @internal
  Scenario: a request is made to the throttled dev stage
    Given the dev stage has throttling configured
    And throttling is enabled for the dev stage
    When a request is made to the throttled dev stage
    Then the request is throttled or passes non-deterministically
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @request_throttled_dev @internal
  Scenario: a request is made to the throttled dev stage fails when the dev stage does not have throttling configured
    Given the dev stage does not have throttling configured
    When a request is made to the throttled dev stage
    Then the operation is rejected

  @guard @negative @request_throttled_dev @internal
  Scenario: a request is made to the throttled dev stage fails when throttling is not enabled for the dev stage
    Given the dev stage has throttling configured
    And throttling is not enabled for the dev stage
    When a request is made to the throttled dev stage
    Then the operation is rejected
