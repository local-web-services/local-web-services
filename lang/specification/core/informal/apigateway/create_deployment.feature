@apigateway @generated
Feature: Apigateway - An "Api Gateway" "Api" Deployment Is Created

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @create_deployment
  Scenario: an "api gateway" "API" deployment is created
    Given the "api gateway" "deployment" slot is available
    And the "api gateway" "method" has an "api gateway" "integration"
    And the "api gateway" "integration" existed
    And the "api gateway" "method" has an "api gateway" "API" association
    And the "api gateway" "API" existed
    And the "api gateway" "API" was "ACTIVE"
    When an "api gateway" "API" deployment is created
    Then the "api gateway" "deployment" will be "ACTIVE"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @guard @negative @create_deployment
  Scenario: an "api gateway" "API" deployment is created fails when the "api gateway" "deployment" slot is already in use
    Given the "api gateway" "deployment" slot is already in use
    When an "api gateway" "API" deployment is created
    Then the operation is rejected

  @guard @negative @create_deployment
  Scenario: an "api gateway" "API" deployment is created fails when the "api gateway" "method" does not have an "api gateway" "integration"
    Given the "api gateway" "deployment" slot is available
    And the "api gateway" "method" does not have an "api gateway" "integration"
    When an "api gateway" "API" deployment is created
    Then the operation is rejected

  @guard @negative @create_deployment
  Scenario: an "api gateway" "API" deployment is created fails when the "api gateway" "integration" did not exist
    Given the "api gateway" "deployment" slot is available
    And the "api gateway" "method" has an "api gateway" "integration"
    And the "api gateway" "integration" did not exist
    When an "api gateway" "API" deployment is created
    Then the operation is rejected

  @guard @negative @create_deployment
  Scenario: an "api gateway" "API" deployment is created fails when the "api gateway" "method" does not have an "api gateway" "API" association
    Given the "api gateway" "deployment" slot is available
    And the "api gateway" "method" has an "api gateway" "integration"
    And the "api gateway" "integration" existed
    And the "api gateway" "method" does not have an "api gateway" "API" association
    When an "api gateway" "API" deployment is created
    Then the operation is rejected

  @guard @negative @create_deployment
  Scenario: an "api gateway" "API" deployment is created fails when the "api gateway" "API" did not exist
    Given the "api gateway" "deployment" slot is available
    And the "api gateway" "method" has an "api gateway" "integration"
    And the "api gateway" "integration" existed
    And the "api gateway" "method" has an "api gateway" "API" association
    And the "api gateway" "API" did not exist
    When an "api gateway" "API" deployment is created
    Then the operation is rejected

  @guard @negative @create_deployment @lifecycle
  Scenario: an "api gateway" "API" deployment is created fails when the "api gateway" "API" was not "ACTIVE"
    Given the "api gateway" "deployment" slot is available
    And the "api gateway" "method" has an "api gateway" "integration"
    And the "api gateway" "integration" existed
    And the "api gateway" "method" has an "api gateway" "API" association
    And the "api gateway" "API" existed
    And the "api gateway" "API" was not "ACTIVE"
    When an "api gateway" "API" deployment is created
    Then the operation is rejected
