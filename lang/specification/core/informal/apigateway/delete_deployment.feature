@apigateway @generated
Feature: Apigateway - A "Api Gateway" "Deployment" Is Deleted When No Stage References It

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @delete_deployment
  Scenario: a "api gateway" "deployment" is deleted when no stage references it
    Given the "api gateway" "deployment" existed
    And the "api gateway" "deployment" was "ACTIVE"
    When a "api gateway" "deployment" is deleted when no stage references it
    Then the "api gateway" "deployment" will be deleted
    And all "ACTIVE" "api gateway" "resource"s belong to "ACTIVE" "api gateway" "API"s
    And all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s
    And all "api gateway" "integration"s correspond to existing "api gateway" "method"s
    And all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s
    And all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s
    And all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s
    And each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"

  @guard @negative @delete_deployment
  Scenario: a "api gateway" "deployment" is deleted when no stage references it fails when the "api gateway" "deployment" did not exist
    Given the "api gateway" "deployment" did not exist
    When a "api gateway" "deployment" is deleted when no stage references it
    Then the operation is rejected

  @guard @negative @delete_deployment @lifecycle
  Scenario: a "api gateway" "deployment" is deleted when no stage references it fails when the "api gateway" "deployment" was not "ACTIVE"
    Given the "api gateway" "deployment" existed
    And the "api gateway" "deployment" was not "ACTIVE"
    When a "api gateway" "deployment" is deleted when no stage references it
    Then the operation is rejected
