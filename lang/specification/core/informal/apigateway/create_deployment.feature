@apigateway @generated
Feature: Apigateway - An Api Deployment Is Created

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @minimal @happy @create_deployment
  Scenario: an "API" deployment is created
    Given the deployment slot is available
    And the method has an integration
    And the integration "EXISTS"
    And the method has an "API" association
    And the "API" exists
    And the "API" is "ACTIVE"
    When an "API" deployment is created
    Then the deployment is "ACTIVE"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @standard @negative @create_deployment
  Scenario: an "API" deployment is created fails when the deployment slot is already in use
    Given the deployment slot is already in use
    When an "API" deployment is created
    Then the operation is rejected

  @standard @negative @create_deployment
  Scenario: an "API" deployment is created fails when the method does not have an integration
    Given the deployment slot is available
    And the method does not have an integration
    When an "API" deployment is created
    Then the operation is rejected

  @standard @negative @create_deployment
  Scenario: an "API" deployment is created fails when the integration does not exist
    Given the deployment slot is available
    And the method has an integration
    And the integration does not exist
    When an "API" deployment is created
    Then the operation is rejected

  @standard @negative @create_deployment
  Scenario: an "API" deployment is created fails when the method does not have an "API" association
    Given the deployment slot is available
    And the method has an integration
    And the integration "EXISTS"
    And the method does not have an "API" association
    When an "API" deployment is created
    Then the operation is rejected

  @standard @negative @create_deployment
  Scenario: an "API" deployment is created fails when the "API" does not exist
    Given the deployment slot is available
    And the method has an integration
    And the integration "EXISTS"
    And the method has an "API" association
    And the "API" does not exist
    When an "API" deployment is created
    Then the operation is rejected

  @standard @negative @create_deployment @lifecycle @internal
  Scenario: an "API" deployment is created fails when the "API" is not "ACTIVE"
    Given the deployment slot is available
    And the method has an integration
    And the integration "EXISTS"
    And the method has an "API" association
    And the "API" exists
    And the "API" is not "ACTIVE"
    When an "API" deployment is created
    Then the operation is rejected
