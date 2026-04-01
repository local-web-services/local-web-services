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
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

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
