@apigateway @generated
Feature: Apigateway - A Deployment Is Deleted When No Stage References It

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @delete_deployment
  Scenario: a deployment is deleted when no stage references it
    Given the deployment exists
    And the deployment is "ACTIVE"
    When a deployment is deleted when no stage references it
    Then the deployment is "DELETED"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @delete_deployment
  Scenario: a deployment is deleted when no stage references it fails when the deployment does not exist
    Given the deployment does not exist
    When a deployment is deleted when no stage references it
    Then the operation is rejected

  @guard @negative @delete_deployment @lifecycle
  Scenario: a deployment is deleted when no stage references it fails when the deployment is not "ACTIVE"
    Given the deployment exists
    And the deployment is not "ACTIVE"
    When a deployment is deleted when no stage references it
    Then the operation is rejected
