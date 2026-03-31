@apigateway @generated
Feature: Apigateway - Action Sequences

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a root resource is initialized for an "api gateway" "API"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a "api gateway" "REST API" is deleted
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a "GET" method is created on a "api gateway" "resource"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then an existing method is updated
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a "api gateway" "method" is deleted along with its integration
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a 200 method response is configured
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a backend integration is attached to a "api gateway" "method"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then an "api gateway" "integration" is deleted
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a 200 integration response is configured
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then an "api gateway" "API" deployment is created
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a "api gateway" "deployment" is deleted when no stage references it
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a prod stage is created for an "api gateway" "API"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then the "api gateway" "prod stage" is deleted
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then the "api gateway" "prod stage" is redeployed to a new deployment
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a request is made to the throttled prod stage
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a backend integration is called
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a "api gateway" "REST API" is created with a root resource
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a "api gateway" "REST API" is deleted
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a "GET" method is created on a "api gateway" "resource"
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then an existing method is updated
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a "api gateway" "method" is deleted along with its integration
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a 200 method response is configured
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a backend integration is attached to a "api gateway" "method"
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then an "api gateway" "integration" is deleted
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a 200 integration response is configured
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then an "api gateway" "API" deployment is created
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a "api gateway" "deployment" is deleted when no stage references it
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a prod stage is created for an "api gateway" "API"
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then the "api gateway" "prod stage" is deleted
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a request is made to the throttled prod stage
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a backend integration is called
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a "api gateway" "REST API" is created with a root resource
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a root resource is initialized for an "api gateway" "API"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a "GET" method is created on a "api gateway" "resource"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then an existing method is updated
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a "api gateway" "method" is deleted along with its integration
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a 200 method response is configured
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a backend integration is attached to a "api gateway" "method"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then an "api gateway" "integration" is deleted
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a 200 integration response is configured
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then an "api gateway" "API" deployment is created
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a "api gateway" "deployment" is deleted when no stage references it
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a prod stage is created for an "api gateway" "API"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then the "api gateway" "prod stage" is deleted
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then the "api gateway" "prod stage" is redeployed to a new deployment
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a request is made to the throttled prod stage
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a backend integration is called
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "api gateway" "REST API" is created with a root resource
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a root resource is initialized for an "api gateway" "API"
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "api gateway" "REST API" is deleted
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "GET" method is created on a "api gateway" "resource"
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then an existing method is updated
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "api gateway" "method" is deleted along with its integration
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a 200 method response is configured
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a backend integration is attached to a "api gateway" "method"
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then an "api gateway" "integration" is deleted
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a 200 integration response is configured
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then an "api gateway" "API" deployment is created
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "api gateway" "deployment" is deleted when no stage references it
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a prod stage is created for an "api gateway" "API"
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then the "api gateway" "prod stage" is deleted
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a request is made to the throttled prod stage
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a backend integration is called
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "api gateway" "REST API" is created with a root resource
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a root resource is initialized for an "api gateway" "API"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "api gateway" "REST API" is deleted
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "GET" method is created on a "api gateway" "resource"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then an existing method is updated
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "api gateway" "method" is deleted along with its integration
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a 200 method response is configured
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a backend integration is attached to a "api gateway" "method"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then an "api gateway" "integration" is deleted
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a 200 integration response is configured
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then an "api gateway" "API" deployment is created
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "api gateway" "deployment" is deleted when no stage references it
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a prod stage is created for an "api gateway" "API"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then the "api gateway" "prod stage" is deleted
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then the "api gateway" "prod stage" is redeployed to a new deployment
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a request is made to the throttled prod stage
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a backend integration is called
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a "api gateway" "REST API" is created with a root resource
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a root resource is initialized for an "api gateway" "API"
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a "api gateway" "REST API" is deleted
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then an existing method is updated
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a "api gateway" "method" is deleted along with its integration
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a 200 method response is configured
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a backend integration is attached to a "api gateway" "method"
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then an "api gateway" "integration" is deleted
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a 200 integration response is configured
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then an "api gateway" "API" deployment is created
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a "api gateway" "deployment" is deleted when no stage references it
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a prod stage is created for an "api gateway" "API"
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then the "api gateway" "prod stage" is deleted
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a request is made to the throttled prod stage
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a backend integration is called
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a "api gateway" "REST API" is created with a root resource
    Given mk in method_status
    When an existing method is updated
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a root resource is initialized for an "api gateway" "API"
    Given mk in method_status
    When an existing method is updated
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a "api gateway" "REST API" is deleted
    Given mk in method_status
    When an existing method is updated
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in method_status
    When an existing method is updated
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in method_status
    When an existing method is updated
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a "GET" method is created on a "api gateway" "resource"
    Given mk in method_status
    When an existing method is updated
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a "api gateway" "method" is deleted along with its integration
    Given mk in method_status
    When an existing method is updated
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a 200 method response is configured
    Given mk in method_status
    When an existing method is updated
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a backend integration is attached to a "api gateway" "method"
    Given mk in method_status
    When an existing method is updated
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then an "api gateway" "integration" is deleted
    Given mk in method_status
    When an existing method is updated
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a 200 integration response is configured
    Given mk in method_status
    When an existing method is updated
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then an "api gateway" "API" deployment is created
    Given mk in method_status
    When an existing method is updated
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in method_status
    When an existing method is updated
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a prod stage is created for an "api gateway" "API"
    Given mk in method_status
    When an existing method is updated
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then the "api gateway" "prod stage" is deleted
    Given mk in method_status
    When an existing method is updated
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in method_status
    When an existing method is updated
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When an existing method is updated
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When an existing method is updated
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a request is made to the throttled prod stage
    Given mk in method_status
    When an existing method is updated
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a backend integration is called
    Given mk in method_status
    When an existing method is updated
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a "api gateway" "REST API" is created with a root resource
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a root resource is initialized for an "api gateway" "API"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a "api gateway" "REST API" is deleted
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a "GET" method is created on a "api gateway" "resource"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then an existing method is updated
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a 200 method response is configured
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a backend integration is attached to a "api gateway" "method"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then an "api gateway" "integration" is deleted
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a 200 integration response is configured
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then an "api gateway" "API" deployment is created
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a prod stage is created for an "api gateway" "API"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then the "api gateway" "prod stage" is deleted
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a request is made to the throttled prod stage
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a backend integration is called
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a "api gateway" "REST API" is created with a root resource
    Given mk in method_status
    When a 200 method response is configured
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a root resource is initialized for an "api gateway" "API"
    Given mk in method_status
    When a 200 method response is configured
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a "api gateway" "REST API" is deleted
    Given mk in method_status
    When a 200 method response is configured
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in method_status
    When a 200 method response is configured
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in method_status
    When a 200 method response is configured
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a "GET" method is created on a "api gateway" "resource"
    Given mk in method_status
    When a 200 method response is configured
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then an existing method is updated
    Given mk in method_status
    When a 200 method response is configured
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a "api gateway" "method" is deleted along with its integration
    Given mk in method_status
    When a 200 method response is configured
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a backend integration is attached to a "api gateway" "method"
    Given mk in method_status
    When a 200 method response is configured
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then an "api gateway" "integration" is deleted
    Given mk in method_status
    When a 200 method response is configured
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a 200 integration response is configured
    Given mk in method_status
    When a 200 method response is configured
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then an "api gateway" "API" deployment is created
    Given mk in method_status
    When a 200 method response is configured
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in method_status
    When a 200 method response is configured
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a prod stage is created for an "api gateway" "API"
    Given mk in method_status
    When a 200 method response is configured
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then the "api gateway" "prod stage" is deleted
    Given mk in method_status
    When a 200 method response is configured
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in method_status
    When a 200 method response is configured
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When a 200 method response is configured
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When a 200 method response is configured
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a request is made to the throttled prod stage
    Given mk in method_status
    When a 200 method response is configured
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a backend integration is called
    Given mk in method_status
    When a 200 method response is configured
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a "api gateway" "REST API" is created with a root resource
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a root resource is initialized for an "api gateway" "API"
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a "api gateway" "REST API" is deleted
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a "GET" method is created on a "api gateway" "resource"
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then an existing method is updated
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a "api gateway" "method" is deleted along with its integration
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a 200 method response is configured
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then an "api gateway" "integration" is deleted
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a 200 integration response is configured
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then an "api gateway" "API" deployment is created
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a prod stage is created for an "api gateway" "API"
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then the "api gateway" "prod stage" is deleted
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a request is made to the throttled prod stage
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a backend integration is called
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a "api gateway" "REST API" is created with a root resource
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a root resource is initialized for an "api gateway" "API"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a "api gateway" "REST API" is deleted
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a "GET" method is created on a "api gateway" "resource"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then an existing method is updated
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a "api gateway" "method" is deleted along with its integration
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a 200 method response is configured
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a backend integration is attached to a "api gateway" "method"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a 200 integration response is configured
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then an "api gateway" "API" deployment is created
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a prod stage is created for an "api gateway" "API"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then the "api gateway" "prod stage" is deleted
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a request is made to the throttled prod stage
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a backend integration is called
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a "api gateway" "REST API" is created with a root resource
    Given mk in integration_status
    When a 200 integration response is configured
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a root resource is initialized for an "api gateway" "API"
    Given mk in integration_status
    When a 200 integration response is configured
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a "api gateway" "REST API" is deleted
    Given mk in integration_status
    When a 200 integration response is configured
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in integration_status
    When a 200 integration response is configured
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in integration_status
    When a 200 integration response is configured
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a "GET" method is created on a "api gateway" "resource"
    Given mk in integration_status
    When a 200 integration response is configured
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then an existing method is updated
    Given mk in integration_status
    When a 200 integration response is configured
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a "api gateway" "method" is deleted along with its integration
    Given mk in integration_status
    When a 200 integration response is configured
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a 200 method response is configured
    Given mk in integration_status
    When a 200 integration response is configured
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a backend integration is attached to a "api gateway" "method"
    Given mk in integration_status
    When a 200 integration response is configured
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then an "api gateway" "integration" is deleted
    Given mk in integration_status
    When a 200 integration response is configured
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then an "api gateway" "API" deployment is created
    Given mk in integration_status
    When a 200 integration response is configured
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in integration_status
    When a 200 integration response is configured
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a prod stage is created for an "api gateway" "API"
    Given mk in integration_status
    When a 200 integration response is configured
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then the "api gateway" "prod stage" is deleted
    Given mk in integration_status
    When a 200 integration response is configured
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in integration_status
    When a 200 integration response is configured
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in integration_status
    When a 200 integration response is configured
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in integration_status
    When a 200 integration response is configured
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a request is made to the throttled prod stage
    Given mk in integration_status
    When a 200 integration response is configured
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a backend integration is called
    Given mk in integration_status
    When a 200 integration response is configured
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a "api gateway" "REST API" is created with a root resource
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a root resource is initialized for an "api gateway" "API"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a "api gateway" "REST API" is deleted
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a "GET" method is created on a "api gateway" "resource"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then an existing method is updated
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a "api gateway" "method" is deleted along with its integration
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a 200 method response is configured
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a backend integration is attached to a "api gateway" "method"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then an "api gateway" "integration" is deleted
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a 200 integration response is configured
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a "api gateway" "deployment" is deleted when no stage references it
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a prod stage is created for an "api gateway" "API"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then the "api gateway" "prod stage" is deleted
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then the "api gateway" "prod stage" is redeployed to a new deployment
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a request is made to the throttled prod stage
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a backend integration is called
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a "api gateway" "REST API" is created with a root resource
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a root resource is initialized for an "api gateway" "API"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a "api gateway" "REST API" is deleted
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a "GET" method is created on a "api gateway" "resource"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then an existing method is updated
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a "api gateway" "method" is deleted along with its integration
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a 200 method response is configured
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a backend integration is attached to a "api gateway" "method"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then an "api gateway" "integration" is deleted
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a 200 integration response is configured
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then an "api gateway" "API" deployment is created
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a prod stage is created for an "api gateway" "API"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then the "api gateway" "prod stage" is deleted
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then the "api gateway" "prod stage" is redeployed to a new deployment
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a request is made to the throttled prod stage
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a backend integration is called
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a "api gateway" "REST API" is created with a root resource
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a root resource is initialized for an "api gateway" "API"
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a "api gateway" "REST API" is deleted
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a "GET" method is created on a "api gateway" "resource"
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then an existing method is updated
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a "api gateway" "method" is deleted along with its integration
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a 200 method response is configured
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a backend integration is attached to a "api gateway" "method"
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then an "api gateway" "integration" is deleted
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a 200 integration response is configured
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then an "api gateway" "API" deployment is created
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a "api gateway" "deployment" is deleted when no stage references it
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then the "api gateway" "prod stage" is deleted
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a request is made to the throttled prod stage
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a backend integration is called
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a "api gateway" "REST API" is created with a root resource
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a root resource is initialized for an "api gateway" "API"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a "api gateway" "REST API" is deleted
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a "GET" method is created on a "api gateway" "resource"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then an existing method is updated
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a "api gateway" "method" is deleted along with its integration
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a 200 method response is configured
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a backend integration is attached to a "api gateway" "method"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then an "api gateway" "integration" is deleted
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a 200 integration response is configured
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then an "api gateway" "API" deployment is created
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a "api gateway" "deployment" is deleted when no stage references it
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a prod stage is created for an "api gateway" "API"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then the "api gateway" "prod stage" is redeployed to a new deployment
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a request is made to the throttled prod stage
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a backend integration is called
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a "api gateway" "REST API" is created with a root resource
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a root resource is initialized for an "api gateway" "API"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a "api gateway" "REST API" is deleted
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a "GET" method is created on a "api gateway" "resource"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then an existing method is updated
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a "api gateway" "method" is deleted along with its integration
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a 200 method response is configured
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a backend integration is attached to a "api gateway" "method"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then an "api gateway" "integration" is deleted
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a 200 integration response is configured
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then an "api gateway" "API" deployment is created
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a "api gateway" "deployment" is deleted when no stage references it
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a prod stage is created for an "api gateway" "API"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then the "api gateway" "prod stage" is deleted
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a request is made to the throttled prod stage
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a backend integration is called
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a "api gateway" "REST API" is created with a root resource
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a root resource is initialized for an "api gateway" "API"
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a "api gateway" "REST API" is deleted
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a "GET" method is created on a "api gateway" "resource"
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then an existing method is updated
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a "api gateway" "method" is deleted along with its integration
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a 200 method response is configured
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a backend integration is attached to a "api gateway" "method"
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then an "api gateway" "integration" is deleted
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a 200 integration response is configured
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then an "api gateway" "API" deployment is created
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a "api gateway" "deployment" is deleted when no stage references it
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a prod stage is created for an "api gateway" "API"
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then the "api gateway" "prod stage" is deleted
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a request is made to the throttled prod stage
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a backend integration is called
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a "api gateway" "REST API" is created with a root resource
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a root resource is initialized for an "api gateway" "API"
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a "api gateway" "REST API" is deleted
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a "GET" method is created on a "api gateway" "resource"
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then an existing method is updated
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a "api gateway" "method" is deleted along with its integration
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a 200 method response is configured
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a backend integration is attached to a "api gateway" "method"
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then an "api gateway" "integration" is deleted
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a 200 integration response is configured
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then an "api gateway" "API" deployment is created
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a "api gateway" "deployment" is deleted when no stage references it
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a prod stage is created for an "api gateway" "API"
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then the "api gateway" "prod stage" is deleted
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a request is made to the throttled prod stage
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a backend integration is called
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a "api gateway" "REST API" is created with a root resource
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a root resource is initialized for an "api gateway" "API"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a "api gateway" "REST API" is deleted
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a "GET" method is created on a "api gateway" "resource"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then an existing method is updated
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a "api gateway" "method" is deleted along with its integration
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a 200 method response is configured
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a backend integration is attached to a "api gateway" "method"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then an "api gateway" "integration" is deleted
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a 200 integration response is configured
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then an "api gateway" "API" deployment is created
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a "api gateway" "deployment" is deleted when no stage references it
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a prod stage is created for an "api gateway" "API"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then the "api gateway" "prod stage" is deleted
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then the "api gateway" "prod stage" is redeployed to a new deployment
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a backend integration is called
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a "api gateway" "REST API" is created with a root resource
    Given mk in integration_status
    When a backend integration is called
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a root resource is initialized for an "api gateway" "API"
    Given mk in integration_status
    When a backend integration is called
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a "api gateway" "REST API" is deleted
    Given mk in integration_status
    When a backend integration is called
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in integration_status
    When a backend integration is called
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in integration_status
    When a backend integration is called
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a "GET" method is created on a "api gateway" "resource"
    Given mk in integration_status
    When a backend integration is called
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then an existing method is updated
    Given mk in integration_status
    When a backend integration is called
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a "api gateway" "method" is deleted along with its integration
    Given mk in integration_status
    When a backend integration is called
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a 200 method response is configured
    Given mk in integration_status
    When a backend integration is called
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a backend integration is attached to a "api gateway" "method"
    Given mk in integration_status
    When a backend integration is called
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then an "api gateway" "integration" is deleted
    Given mk in integration_status
    When a backend integration is called
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a 200 integration response is configured
    Given mk in integration_status
    When a backend integration is called
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then an "api gateway" "API" deployment is created
    Given mk in integration_status
    When a backend integration is called
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in integration_status
    When a backend integration is called
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a prod stage is created for an "api gateway" "API"
    Given mk in integration_status
    When a backend integration is called
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then the "api gateway" "prod stage" is deleted
    Given mk in integration_status
    When a backend integration is called
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in integration_status
    When a backend integration is called
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in integration_status
    When a backend integration is called
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in integration_status
    When a backend integration is called
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a request is made to the throttled prod stage
    Given mk in integration_status
    When a backend integration is called
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a root resource is initialized for an "api gateway" "API" then a "api gateway" "REST API" is deleted
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a root resource is initialized for an "api gateway" "API"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a "api gateway" "REST API" is deleted then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a "api gateway" "REST API" is deleted
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "GET" method is created on a "api gateway" "resource"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a "GET" method is created on a "api gateway" "resource" then an existing method is updated
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a "GET" method is created on a "api gateway" "resource"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then an existing method is updated then a "api gateway" "method" is deleted along with its integration
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When an existing method is updated
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a "api gateway" "method" is deleted along with its integration then a 200 method response is configured
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a "api gateway" "method" is deleted along with its integration
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a 200 method response is configured then a backend integration is attached to a "api gateway" "method"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a 200 method response is configured
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a backend integration is attached to a "api gateway" "method" then an "api gateway" "integration" is deleted
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a backend integration is attached to a "api gateway" "method"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then an "api gateway" "integration" is deleted then a 200 integration response is configured
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When an "api gateway" "integration" is deleted
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a 200 integration response is configured then an "api gateway" "API" deployment is created
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a 200 integration response is configured
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then an "api gateway" "API" deployment is created then a "api gateway" "deployment" is deleted when no stage references it
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When an "api gateway" "API" deployment is created
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a "api gateway" "deployment" is deleted when no stage references it then a prod stage is created for an "api gateway" "API"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a "api gateway" "deployment" is deleted when no stage references it
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a prod stage is created for an "api gateway" "API" then the "api gateway" "prod stage" is deleted
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a prod stage is created for an "api gateway" "API"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then the "api gateway" "prod stage" is deleted then the "api gateway" "prod stage" is redeployed to a new deployment
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When the "api gateway" "prod stage" is deleted
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then the "api gateway" "prod stage" is redeployed to a new deployment then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then throttling was "ENABLED" for the "api gateway" "prod stage" then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then throttling was "DISABLED" for the "api gateway" "prod stage" then a request is made to the throttled prod stage
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a request is made to the throttled prod stage then a backend integration is called
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a request is made to the throttled prod stage
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is created with a root resource then a backend integration is called then a root resource is initialized for an "api gateway" "API"
    Given aid not in api_status
    When a "api gateway" "REST API" is created with a root resource
    When a backend integration is called
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a "api gateway" "REST API" is created with a root resource then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a "api gateway" "REST API" is created with a root resource
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a "api gateway" "REST API" is deleted then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a "api gateway" "REST API" is deleted
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "GET" method is created on a "api gateway" "resource"
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a non-root "api gateway" "resource" is deleted along with its methods and integrations then an existing method is updated
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a "GET" method is created on a "api gateway" "resource" then a "api gateway" "method" is deleted along with its integration
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a "GET" method is created on a "api gateway" "resource"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then an existing method is updated then a 200 method response is configured
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When an existing method is updated
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a "api gateway" "method" is deleted along with its integration then a backend integration is attached to a "api gateway" "method"
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a "api gateway" "method" is deleted along with its integration
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a 200 method response is configured then an "api gateway" "integration" is deleted
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a 200 method response is configured
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a backend integration is attached to a "api gateway" "method" then a 200 integration response is configured
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a backend integration is attached to a "api gateway" "method"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then an "api gateway" "integration" is deleted then an "api gateway" "API" deployment is created
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When an "api gateway" "integration" is deleted
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a 200 integration response is configured then a "api gateway" "deployment" is deleted when no stage references it
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a 200 integration response is configured
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then an "api gateway" "API" deployment is created then a prod stage is created for an "api gateway" "API"
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When an "api gateway" "API" deployment is created
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a "api gateway" "deployment" is deleted when no stage references it then the "api gateway" "prod stage" is deleted
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a "api gateway" "deployment" is deleted when no stage references it
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a prod stage is created for an "api gateway" "API" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a prod stage is created for an "api gateway" "API"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then the "api gateway" "prod stage" is deleted then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When the "api gateway" "prod stage" is deleted
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then the "api gateway" "prod stage" is redeployed to a new deployment then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then throttling was "ENABLED" for the "api gateway" "prod stage" then a request is made to the throttled prod stage
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then throttling was "DISABLED" for the "api gateway" "prod stage" then a backend integration is called
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a request is made to the throttled prod stage then a "api gateway" "REST API" is created with a root resource
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a request is made to the throttled prod stage
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a root resource is initialized for an "api gateway" "API" then a backend integration is called then a "api gateway" "REST API" is deleted
    Given aid in api_status
    When a root resource is initialized for an "api gateway" "API"
    When a backend integration is called
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a "api gateway" "REST API" is created with a root resource then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a "api gateway" "REST API" is created with a root resource
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a root resource is initialized for an "api gateway" "API" then a "GET" method is created on a "api gateway" "resource"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a root resource is initialized for an "api gateway" "API"
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then an existing method is updated
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "api gateway" "method" is deleted along with its integration
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a "GET" method is created on a "api gateway" "resource" then a 200 method response is configured
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a "GET" method is created on a "api gateway" "resource"
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then an existing method is updated then a backend integration is attached to a "api gateway" "method"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When an existing method is updated
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a "api gateway" "method" is deleted along with its integration then an "api gateway" "integration" is deleted
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a "api gateway" "method" is deleted along with its integration
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a 200 method response is configured then a 200 integration response is configured
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a 200 method response is configured
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a backend integration is attached to a "api gateway" "method" then an "api gateway" "API" deployment is created
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a backend integration is attached to a "api gateway" "method"
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then an "api gateway" "integration" is deleted then a "api gateway" "deployment" is deleted when no stage references it
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When an "api gateway" "integration" is deleted
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a 200 integration response is configured then a prod stage is created for an "api gateway" "API"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a 200 integration response is configured
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then an "api gateway" "API" deployment is created then the "api gateway" "prod stage" is deleted
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When an "api gateway" "API" deployment is created
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a "api gateway" "deployment" is deleted when no stage references it then the "api gateway" "prod stage" is redeployed to a new deployment
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a "api gateway" "deployment" is deleted when no stage references it
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a prod stage is created for an "api gateway" "API" then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a prod stage is created for an "api gateway" "API"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then the "api gateway" "prod stage" is deleted then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When the "api gateway" "prod stage" is deleted
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then the "api gateway" "prod stage" is redeployed to a new deployment then a request is made to the throttled prod stage
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then throttling was "ENABLED" for the "api gateway" "prod stage" then a backend integration is called
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then throttling was "DISABLED" for the "api gateway" "prod stage" then a "api gateway" "REST API" is created with a root resource
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a request is made to the throttled prod stage then a root resource is initialized for an "api gateway" "API"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a request is made to the throttled prod stage
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "REST API" is deleted then a backend integration is called then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given aid in api_status
    When a "api gateway" "REST API" is deleted
    When a backend integration is called
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "api gateway" "REST API" is created with a root resource then a "GET" method is created on a "api gateway" "resource"
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "api gateway" "REST API" is created with a root resource
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a root resource is initialized for an "api gateway" "API" then an existing method is updated
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a root resource is initialized for an "api gateway" "API"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "api gateway" "REST API" is deleted then a "api gateway" "method" is deleted along with its integration
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "api gateway" "REST API" is deleted
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a non-root "api gateway" "resource" is deleted along with its methods and integrations then a 200 method response is configured
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "GET" method is created on a "api gateway" "resource" then a backend integration is attached to a "api gateway" "method"
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "GET" method is created on a "api gateway" "resource"
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then an existing method is updated then an "api gateway" "integration" is deleted
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When an existing method is updated
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "api gateway" "method" is deleted along with its integration then a 200 integration response is configured
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "api gateway" "method" is deleted along with its integration
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a 200 method response is configured then an "api gateway" "API" deployment is created
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a 200 method response is configured
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a backend integration is attached to a "api gateway" "method" then a "api gateway" "deployment" is deleted when no stage references it
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a backend integration is attached to a "api gateway" "method"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then an "api gateway" "integration" is deleted then a prod stage is created for an "api gateway" "API"
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When an "api gateway" "integration" is deleted
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a 200 integration response is configured then the "api gateway" "prod stage" is deleted
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a 200 integration response is configured
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then an "api gateway" "API" deployment is created then the "api gateway" "prod stage" is redeployed to a new deployment
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When an "api gateway" "API" deployment is created
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "api gateway" "deployment" is deleted when no stage references it then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "api gateway" "deployment" is deleted when no stage references it
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a prod stage is created for an "api gateway" "API" then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a prod stage is created for an "api gateway" "API"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then the "api gateway" "prod stage" is deleted then a request is made to the throttled prod stage
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When the "api gateway" "prod stage" is deleted
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then the "api gateway" "prod stage" is redeployed to a new deployment then a backend integration is called
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then throttling was "ENABLED" for the "api gateway" "prod stage" then a "api gateway" "REST API" is created with a root resource
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then throttling was "DISABLED" for the "api gateway" "prod stage" then a root resource is initialized for an "api gateway" "API"
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a request is made to the throttled prod stage then a "api gateway" "REST API" is deleted
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a request is made to the throttled prod stage
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a backend integration is called then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given rid not in resource_api
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a backend integration is called
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "api gateway" "REST API" is created with a root resource then an existing method is updated
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "api gateway" "REST API" is created with a root resource
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a root resource is initialized for an "api gateway" "API" then a "api gateway" "method" is deleted along with its integration
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a root resource is initialized for an "api gateway" "API"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "api gateway" "REST API" is deleted then a 200 method response is configured
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "api gateway" "REST API" is deleted
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a backend integration is attached to a "api gateway" "method"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "GET" method is created on a "api gateway" "resource" then an "api gateway" "integration" is deleted
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "GET" method is created on a "api gateway" "resource"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then an existing method is updated then a 200 integration response is configured
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When an existing method is updated
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "api gateway" "method" is deleted along with its integration then an "api gateway" "API" deployment is created
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "api gateway" "method" is deleted along with its integration
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a 200 method response is configured then a "api gateway" "deployment" is deleted when no stage references it
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a 200 method response is configured
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a backend integration is attached to a "api gateway" "method" then a prod stage is created for an "api gateway" "API"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a backend integration is attached to a "api gateway" "method"
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then an "api gateway" "integration" is deleted then the "api gateway" "prod stage" is deleted
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When an "api gateway" "integration" is deleted
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a 200 integration response is configured then the "api gateway" "prod stage" is redeployed to a new deployment
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a 200 integration response is configured
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then an "api gateway" "API" deployment is created then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When an "api gateway" "API" deployment is created
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "api gateway" "deployment" is deleted when no stage references it then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "api gateway" "deployment" is deleted when no stage references it
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a prod stage is created for an "api gateway" "API" then a request is made to the throttled prod stage
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a prod stage is created for an "api gateway" "API"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then the "api gateway" "prod stage" is deleted then a backend integration is called
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When the "api gateway" "prod stage" is deleted
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then the "api gateway" "prod stage" is redeployed to a new deployment then a "api gateway" "REST API" is created with a root resource
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then throttling was "ENABLED" for the "api gateway" "prod stage" then a root resource is initialized for an "api gateway" "API"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then throttling was "DISABLED" for the "api gateway" "prod stage" then a "api gateway" "REST API" is deleted
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a request is made to the throttled prod stage then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a request is made to the throttled prod stage
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a non-root "api gateway" "resource" is deleted along with its methods and integrations then a backend integration is called then a "GET" method is created on a "api gateway" "resource"
    Given rid in resource_status
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a backend integration is called
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a "api gateway" "REST API" is created with a root resource then a "api gateway" "method" is deleted along with its integration
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a "api gateway" "REST API" is created with a root resource
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a root resource is initialized for an "api gateway" "API" then a 200 method response is configured
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a root resource is initialized for an "api gateway" "API"
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a "api gateway" "REST API" is deleted then a backend integration is attached to a "api gateway" "method"
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a "api gateway" "REST API" is deleted
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then an "api gateway" "integration" is deleted
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a non-root "api gateway" "resource" is deleted along with its methods and integrations then a 200 integration response is configured
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then an existing method is updated then an "api gateway" "API" deployment is created
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When an existing method is updated
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a "api gateway" "method" is deleted along with its integration then a "api gateway" "deployment" is deleted when no stage references it
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a "api gateway" "method" is deleted along with its integration
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a 200 method response is configured then a prod stage is created for an "api gateway" "API"
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a 200 method response is configured
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a backend integration is attached to a "api gateway" "method" then the "api gateway" "prod stage" is deleted
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a backend integration is attached to a "api gateway" "method"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then an "api gateway" "integration" is deleted then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When an "api gateway" "integration" is deleted
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a 200 integration response is configured then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a 200 integration response is configured
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then an "api gateway" "API" deployment is created then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When an "api gateway" "API" deployment is created
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a "api gateway" "deployment" is deleted when no stage references it then a request is made to the throttled prod stage
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a "api gateway" "deployment" is deleted when no stage references it
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a prod stage is created for an "api gateway" "API" then a backend integration is called
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a prod stage is created for an "api gateway" "API"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then the "api gateway" "prod stage" is deleted then a "api gateway" "REST API" is created with a root resource
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When the "api gateway" "prod stage" is deleted
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then the "api gateway" "prod stage" is redeployed to a new deployment then a root resource is initialized for an "api gateway" "API"
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then throttling was "ENABLED" for the "api gateway" "prod stage" then a "api gateway" "REST API" is deleted
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then throttling was "DISABLED" for the "api gateway" "prod stage" then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a request is made to the throttled prod stage then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a request is made to the throttled prod stage
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "GET" method is created on a "api gateway" "resource" then a backend integration is called then an existing method is updated
    Given mk not in method_status
    When a "GET" method is created on a "api gateway" "resource"
    When a backend integration is called
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a "api gateway" "REST API" is created with a root resource then a 200 method response is configured
    Given mk in method_status
    When an existing method is updated
    When a "api gateway" "REST API" is created with a root resource
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a root resource is initialized for an "api gateway" "API" then a backend integration is attached to a "api gateway" "method"
    Given mk in method_status
    When an existing method is updated
    When a root resource is initialized for an "api gateway" "API"
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a "api gateway" "REST API" is deleted then an "api gateway" "integration" is deleted
    Given mk in method_status
    When an existing method is updated
    When a "api gateway" "REST API" is deleted
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a 200 integration response is configured
    Given mk in method_status
    When an existing method is updated
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a non-root "api gateway" "resource" is deleted along with its methods and integrations then an "api gateway" "API" deployment is created
    Given mk in method_status
    When an existing method is updated
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a "GET" method is created on a "api gateway" "resource" then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in method_status
    When an existing method is updated
    When a "GET" method is created on a "api gateway" "resource"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a "api gateway" "method" is deleted along with its integration then a prod stage is created for an "api gateway" "API"
    Given mk in method_status
    When an existing method is updated
    When a "api gateway" "method" is deleted along with its integration
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a 200 method response is configured then the "api gateway" "prod stage" is deleted
    Given mk in method_status
    When an existing method is updated
    When a 200 method response is configured
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a backend integration is attached to a "api gateway" "method" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in method_status
    When an existing method is updated
    When a backend integration is attached to a "api gateway" "method"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then an "api gateway" "integration" is deleted then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When an existing method is updated
    When an "api gateway" "integration" is deleted
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a 200 integration response is configured then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When an existing method is updated
    When a 200 integration response is configured
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then an "api gateway" "API" deployment is created then a request is made to the throttled prod stage
    Given mk in method_status
    When an existing method is updated
    When an "api gateway" "API" deployment is created
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a "api gateway" "deployment" is deleted when no stage references it then a backend integration is called
    Given mk in method_status
    When an existing method is updated
    When a "api gateway" "deployment" is deleted when no stage references it
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a prod stage is created for an "api gateway" "API" then a "api gateway" "REST API" is created with a root resource
    Given mk in method_status
    When an existing method is updated
    When a prod stage is created for an "api gateway" "API"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then the "api gateway" "prod stage" is deleted then a root resource is initialized for an "api gateway" "API"
    Given mk in method_status
    When an existing method is updated
    When the "api gateway" "prod stage" is deleted
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then the "api gateway" "prod stage" is redeployed to a new deployment then a "api gateway" "REST API" is deleted
    Given mk in method_status
    When an existing method is updated
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then throttling was "ENABLED" for the "api gateway" "prod stage" then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in method_status
    When an existing method is updated
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then throttling was "DISABLED" for the "api gateway" "prod stage" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in method_status
    When an existing method is updated
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a request is made to the throttled prod stage then a "GET" method is created on a "api gateway" "resource"
    Given mk in method_status
    When an existing method is updated
    When a request is made to the throttled prod stage
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an existing method is updated then a backend integration is called then a "api gateway" "method" is deleted along with its integration
    Given mk in method_status
    When an existing method is updated
    When a backend integration is called
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a "api gateway" "REST API" is created with a root resource then a backend integration is attached to a "api gateway" "method"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a "api gateway" "REST API" is created with a root resource
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a root resource is initialized for an "api gateway" "API" then an "api gateway" "integration" is deleted
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a root resource is initialized for an "api gateway" "API"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a "api gateway" "REST API" is deleted then a 200 integration response is configured
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a "api gateway" "REST API" is deleted
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then an "api gateway" "API" deployment is created
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a "GET" method is created on a "api gateway" "resource" then a prod stage is created for an "api gateway" "API"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a "GET" method is created on a "api gateway" "resource"
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then an existing method is updated then the "api gateway" "prod stage" is deleted
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When an existing method is updated
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a 200 method response is configured then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a 200 method response is configured
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a backend integration is attached to a "api gateway" "method" then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a backend integration is attached to a "api gateway" "method"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then an "api gateway" "integration" is deleted then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When an "api gateway" "integration" is deleted
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a 200 integration response is configured then a request is made to the throttled prod stage
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a 200 integration response is configured
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then an "api gateway" "API" deployment is created then a backend integration is called
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When an "api gateway" "API" deployment is created
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a "api gateway" "deployment" is deleted when no stage references it then a "api gateway" "REST API" is created with a root resource
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a "api gateway" "deployment" is deleted when no stage references it
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a prod stage is created for an "api gateway" "API" then a root resource is initialized for an "api gateway" "API"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a prod stage is created for an "api gateway" "API"
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then the "api gateway" "prod stage" is deleted then a "api gateway" "REST API" is deleted
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When the "api gateway" "prod stage" is deleted
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then the "api gateway" "prod stage" is redeployed to a new deployment then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then throttling was "ENABLED" for the "api gateway" "prod stage" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then throttling was "DISABLED" for the "api gateway" "prod stage" then a "GET" method is created on a "api gateway" "resource"
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a request is made to the throttled prod stage then an existing method is updated
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a request is made to the throttled prod stage
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "method" is deleted along with its integration then a backend integration is called then a 200 method response is configured
    Given mk in method_status
    When a "api gateway" "method" is deleted along with its integration
    When a backend integration is called
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a "api gateway" "REST API" is created with a root resource then an "api gateway" "integration" is deleted
    Given mk in method_status
    When a 200 method response is configured
    When a "api gateway" "REST API" is created with a root resource
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a root resource is initialized for an "api gateway" "API" then a 200 integration response is configured
    Given mk in method_status
    When a 200 method response is configured
    When a root resource is initialized for an "api gateway" "API"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a "api gateway" "REST API" is deleted then an "api gateway" "API" deployment is created
    Given mk in method_status
    When a 200 method response is configured
    When a "api gateway" "REST API" is deleted
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in method_status
    When a 200 method response is configured
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a non-root "api gateway" "resource" is deleted along with its methods and integrations then a prod stage is created for an "api gateway" "API"
    Given mk in method_status
    When a 200 method response is configured
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a "GET" method is created on a "api gateway" "resource" then the "api gateway" "prod stage" is deleted
    Given mk in method_status
    When a 200 method response is configured
    When a "GET" method is created on a "api gateway" "resource"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then an existing method is updated then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in method_status
    When a 200 method response is configured
    When an existing method is updated
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a "api gateway" "method" is deleted along with its integration then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When a 200 method response is configured
    When a "api gateway" "method" is deleted along with its integration
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a backend integration is attached to a "api gateway" "method" then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When a 200 method response is configured
    When a backend integration is attached to a "api gateway" "method"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then an "api gateway" "integration" is deleted then a request is made to the throttled prod stage
    Given mk in method_status
    When a 200 method response is configured
    When an "api gateway" "integration" is deleted
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a 200 integration response is configured then a backend integration is called
    Given mk in method_status
    When a 200 method response is configured
    When a 200 integration response is configured
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then an "api gateway" "API" deployment is created then a "api gateway" "REST API" is created with a root resource
    Given mk in method_status
    When a 200 method response is configured
    When an "api gateway" "API" deployment is created
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a "api gateway" "deployment" is deleted when no stage references it then a root resource is initialized for an "api gateway" "API"
    Given mk in method_status
    When a 200 method response is configured
    When a "api gateway" "deployment" is deleted when no stage references it
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a prod stage is created for an "api gateway" "API" then a "api gateway" "REST API" is deleted
    Given mk in method_status
    When a 200 method response is configured
    When a prod stage is created for an "api gateway" "API"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then the "api gateway" "prod stage" is deleted then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in method_status
    When a 200 method response is configured
    When the "api gateway" "prod stage" is deleted
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then the "api gateway" "prod stage" is redeployed to a new deployment then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in method_status
    When a 200 method response is configured
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then throttling was "ENABLED" for the "api gateway" "prod stage" then a "GET" method is created on a "api gateway" "resource"
    Given mk in method_status
    When a 200 method response is configured
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then throttling was "DISABLED" for the "api gateway" "prod stage" then an existing method is updated
    Given mk in method_status
    When a 200 method response is configured
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a request is made to the throttled prod stage then a "api gateway" "method" is deleted along with its integration
    Given mk in method_status
    When a 200 method response is configured
    When a request is made to the throttled prod stage
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 method response is configured then a backend integration is called then a backend integration is attached to a "api gateway" "method"
    Given mk in method_status
    When a 200 method response is configured
    When a backend integration is called
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a "api gateway" "REST API" is created with a root resource then a 200 integration response is configured
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a "api gateway" "REST API" is created with a root resource
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a root resource is initialized for an "api gateway" "API" then an "api gateway" "API" deployment is created
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a root resource is initialized for an "api gateway" "API"
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a "api gateway" "REST API" is deleted then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a "api gateway" "REST API" is deleted
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a prod stage is created for an "api gateway" "API"
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a non-root "api gateway" "resource" is deleted along with its methods and integrations then the "api gateway" "prod stage" is deleted
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a "GET" method is created on a "api gateway" "resource" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a "GET" method is created on a "api gateway" "resource"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then an existing method is updated then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When an existing method is updated
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a "api gateway" "method" is deleted along with its integration then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a "api gateway" "method" is deleted along with its integration
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a 200 method response is configured then a request is made to the throttled prod stage
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a 200 method response is configured
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then an "api gateway" "integration" is deleted then a backend integration is called
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When an "api gateway" "integration" is deleted
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a 200 integration response is configured then a "api gateway" "REST API" is created with a root resource
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a 200 integration response is configured
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then an "api gateway" "API" deployment is created then a root resource is initialized for an "api gateway" "API"
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When an "api gateway" "API" deployment is created
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a "api gateway" "deployment" is deleted when no stage references it then a "api gateway" "REST API" is deleted
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a "api gateway" "deployment" is deleted when no stage references it
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a prod stage is created for an "api gateway" "API" then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a prod stage is created for an "api gateway" "API"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then the "api gateway" "prod stage" is deleted then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When the "api gateway" "prod stage" is deleted
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then the "api gateway" "prod stage" is redeployed to a new deployment then a "GET" method is created on a "api gateway" "resource"
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then throttling was "ENABLED" for the "api gateway" "prod stage" then an existing method is updated
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then throttling was "DISABLED" for the "api gateway" "prod stage" then a "api gateway" "method" is deleted along with its integration
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a request is made to the throttled prod stage then a 200 method response is configured
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a request is made to the throttled prod stage
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is attached to a "api gateway" "method" then a backend integration is called then an "api gateway" "integration" is deleted
    Given mk in method_status
    When a backend integration is attached to a "api gateway" "method"
    When a backend integration is called
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a "api gateway" "REST API" is created with a root resource then an "api gateway" "API" deployment is created
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a "api gateway" "REST API" is created with a root resource
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a root resource is initialized for an "api gateway" "API" then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a root resource is initialized for an "api gateway" "API"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a "api gateway" "REST API" is deleted then a prod stage is created for an "api gateway" "API"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a "api gateway" "REST API" is deleted
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then the "api gateway" "prod stage" is deleted
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a non-root "api gateway" "resource" is deleted along with its methods and integrations then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a "GET" method is created on a "api gateway" "resource" then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a "GET" method is created on a "api gateway" "resource"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then an existing method is updated then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When an existing method is updated
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a "api gateway" "method" is deleted along with its integration then a request is made to the throttled prod stage
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a "api gateway" "method" is deleted along with its integration
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a 200 method response is configured then a backend integration is called
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a 200 method response is configured
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a backend integration is attached to a "api gateway" "method" then a "api gateway" "REST API" is created with a root resource
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a backend integration is attached to a "api gateway" "method"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a 200 integration response is configured then a root resource is initialized for an "api gateway" "API"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a 200 integration response is configured
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then an "api gateway" "API" deployment is created then a "api gateway" "REST API" is deleted
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When an "api gateway" "API" deployment is created
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a "api gateway" "deployment" is deleted when no stage references it then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a "api gateway" "deployment" is deleted when no stage references it
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a prod stage is created for an "api gateway" "API" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a prod stage is created for an "api gateway" "API"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then the "api gateway" "prod stage" is deleted then a "GET" method is created on a "api gateway" "resource"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When the "api gateway" "prod stage" is deleted
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then the "api gateway" "prod stage" is redeployed to a new deployment then an existing method is updated
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then throttling was "ENABLED" for the "api gateway" "prod stage" then a "api gateway" "method" is deleted along with its integration
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then throttling was "DISABLED" for the "api gateway" "prod stage" then a 200 method response is configured
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a request is made to the throttled prod stage then a backend integration is attached to a "api gateway" "method"
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a request is made to the throttled prod stage
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "integration" is deleted then a backend integration is called then a 200 integration response is configured
    Given mk in integration_status
    When an "api gateway" "integration" is deleted
    When a backend integration is called
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a "api gateway" "REST API" is created with a root resource then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in integration_status
    When a 200 integration response is configured
    When a "api gateway" "REST API" is created with a root resource
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a root resource is initialized for an "api gateway" "API" then a prod stage is created for an "api gateway" "API"
    Given mk in integration_status
    When a 200 integration response is configured
    When a root resource is initialized for an "api gateway" "API"
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a "api gateway" "REST API" is deleted then the "api gateway" "prod stage" is deleted
    Given mk in integration_status
    When a 200 integration response is configured
    When a "api gateway" "REST API" is deleted
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in integration_status
    When a 200 integration response is configured
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a non-root "api gateway" "resource" is deleted along with its methods and integrations then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in integration_status
    When a 200 integration response is configured
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a "GET" method is created on a "api gateway" "resource" then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in integration_status
    When a 200 integration response is configured
    When a "GET" method is created on a "api gateway" "resource"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then an existing method is updated then a request is made to the throttled prod stage
    Given mk in integration_status
    When a 200 integration response is configured
    When an existing method is updated
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a "api gateway" "method" is deleted along with its integration then a backend integration is called
    Given mk in integration_status
    When a 200 integration response is configured
    When a "api gateway" "method" is deleted along with its integration
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a 200 method response is configured then a "api gateway" "REST API" is created with a root resource
    Given mk in integration_status
    When a 200 integration response is configured
    When a 200 method response is configured
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a backend integration is attached to a "api gateway" "method" then a root resource is initialized for an "api gateway" "API"
    Given mk in integration_status
    When a 200 integration response is configured
    When a backend integration is attached to a "api gateway" "method"
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then an "api gateway" "integration" is deleted then a "api gateway" "REST API" is deleted
    Given mk in integration_status
    When a 200 integration response is configured
    When an "api gateway" "integration" is deleted
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then an "api gateway" "API" deployment is created then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in integration_status
    When a 200 integration response is configured
    When an "api gateway" "API" deployment is created
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a "api gateway" "deployment" is deleted when no stage references it then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in integration_status
    When a 200 integration response is configured
    When a "api gateway" "deployment" is deleted when no stage references it
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a prod stage is created for an "api gateway" "API" then a "GET" method is created on a "api gateway" "resource"
    Given mk in integration_status
    When a 200 integration response is configured
    When a prod stage is created for an "api gateway" "API"
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then the "api gateway" "prod stage" is deleted then an existing method is updated
    Given mk in integration_status
    When a 200 integration response is configured
    When the "api gateway" "prod stage" is deleted
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then the "api gateway" "prod stage" is redeployed to a new deployment then a "api gateway" "method" is deleted along with its integration
    Given mk in integration_status
    When a 200 integration response is configured
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then throttling was "ENABLED" for the "api gateway" "prod stage" then a 200 method response is configured
    Given mk in integration_status
    When a 200 integration response is configured
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then throttling was "DISABLED" for the "api gateway" "prod stage" then a backend integration is attached to a "api gateway" "method"
    Given mk in integration_status
    When a 200 integration response is configured
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a request is made to the throttled prod stage then an "api gateway" "integration" is deleted
    Given mk in integration_status
    When a 200 integration response is configured
    When a request is made to the throttled prod stage
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a 200 integration response is configured then a backend integration is called then an "api gateway" "API" deployment is created
    Given mk in integration_status
    When a 200 integration response is configured
    When a backend integration is called
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a "api gateway" "REST API" is created with a root resource then a prod stage is created for an "api gateway" "API"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a "api gateway" "REST API" is created with a root resource
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a root resource is initialized for an "api gateway" "API" then the "api gateway" "prod stage" is deleted
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a root resource is initialized for an "api gateway" "API"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a "api gateway" "REST API" is deleted then the "api gateway" "prod stage" is redeployed to a new deployment
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a "api gateway" "REST API" is deleted
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a non-root "api gateway" "resource" is deleted along with its methods and integrations then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a "GET" method is created on a "api gateway" "resource" then a request is made to the throttled prod stage
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a "GET" method is created on a "api gateway" "resource"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then an existing method is updated then a backend integration is called
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When an existing method is updated
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a "api gateway" "method" is deleted along with its integration then a "api gateway" "REST API" is created with a root resource
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a "api gateway" "method" is deleted along with its integration
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a 200 method response is configured then a root resource is initialized for an "api gateway" "API"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a 200 method response is configured
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a backend integration is attached to a "api gateway" "method" then a "api gateway" "REST API" is deleted
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a backend integration is attached to a "api gateway" "method"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then an "api gateway" "integration" is deleted then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When an "api gateway" "integration" is deleted
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a 200 integration response is configured then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a 200 integration response is configured
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a "api gateway" "deployment" is deleted when no stage references it then a "GET" method is created on a "api gateway" "resource"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a "api gateway" "deployment" is deleted when no stage references it
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a prod stage is created for an "api gateway" "API" then an existing method is updated
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a prod stage is created for an "api gateway" "API"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then the "api gateway" "prod stage" is deleted then a "api gateway" "method" is deleted along with its integration
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When the "api gateway" "prod stage" is deleted
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then the "api gateway" "prod stage" is redeployed to a new deployment then a 200 method response is configured
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then throttling was "ENABLED" for the "api gateway" "prod stage" then a backend integration is attached to a "api gateway" "method"
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then throttling was "DISABLED" for the "api gateway" "prod stage" then an "api gateway" "integration" is deleted
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a request is made to the throttled prod stage then a 200 integration response is configured
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a request is made to the throttled prod stage
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: an "api gateway" "API" deployment is created then a backend integration is called then a "api gateway" "deployment" is deleted when no stage references it
    Given did not in deployment_status
    When an "api gateway" "API" deployment is created
    When a backend integration is called
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a "api gateway" "REST API" is created with a root resource then the "api gateway" "prod stage" is deleted
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a "api gateway" "REST API" is created with a root resource
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a root resource is initialized for an "api gateway" "API" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a root resource is initialized for an "api gateway" "API"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a "api gateway" "REST API" is deleted then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a "api gateway" "REST API" is deleted
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a non-root "api gateway" "resource" is deleted along with its methods and integrations then a request is made to the throttled prod stage
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a "GET" method is created on a "api gateway" "resource" then a backend integration is called
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a "GET" method is created on a "api gateway" "resource"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then an existing method is updated then a "api gateway" "REST API" is created with a root resource
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When an existing method is updated
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a "api gateway" "method" is deleted along with its integration then a root resource is initialized for an "api gateway" "API"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a "api gateway" "method" is deleted along with its integration
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a 200 method response is configured then a "api gateway" "REST API" is deleted
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a 200 method response is configured
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a backend integration is attached to a "api gateway" "method" then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a backend integration is attached to a "api gateway" "method"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then an "api gateway" "integration" is deleted then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When an "api gateway" "integration" is deleted
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a 200 integration response is configured then a "GET" method is created on a "api gateway" "resource"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a 200 integration response is configured
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then an "api gateway" "API" deployment is created then an existing method is updated
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When an "api gateway" "API" deployment is created
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a prod stage is created for an "api gateway" "API" then a "api gateway" "method" is deleted along with its integration
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a prod stage is created for an "api gateway" "API"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then the "api gateway" "prod stage" is deleted then a 200 method response is configured
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When the "api gateway" "prod stage" is deleted
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then the "api gateway" "prod stage" is redeployed to a new deployment then a backend integration is attached to a "api gateway" "method"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then throttling was "ENABLED" for the "api gateway" "prod stage" then an "api gateway" "integration" is deleted
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then throttling was "DISABLED" for the "api gateway" "prod stage" then a 200 integration response is configured
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a request is made to the throttled prod stage then an "api gateway" "API" deployment is created
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a request is made to the throttled prod stage
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a "api gateway" "deployment" is deleted when no stage references it then a backend integration is called then a prod stage is created for an "api gateway" "API"
    Given did in deployment_status
    When a "api gateway" "deployment" is deleted when no stage references it
    When a backend integration is called
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a "api gateway" "REST API" is created with a root resource then the "api gateway" "prod stage" is redeployed to a new deployment
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a "api gateway" "REST API" is created with a root resource
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a root resource is initialized for an "api gateway" "API" then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a root resource is initialized for an "api gateway" "API"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a "api gateway" "REST API" is deleted then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a "api gateway" "REST API" is deleted
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a request is made to the throttled prod stage
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a non-root "api gateway" "resource" is deleted along with its methods and integrations then a backend integration is called
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a "GET" method is created on a "api gateway" "resource" then a "api gateway" "REST API" is created with a root resource
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a "GET" method is created on a "api gateway" "resource"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then an existing method is updated then a root resource is initialized for an "api gateway" "API"
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When an existing method is updated
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a "api gateway" "method" is deleted along with its integration then a "api gateway" "REST API" is deleted
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a "api gateway" "method" is deleted along with its integration
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a 200 method response is configured then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a 200 method response is configured
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a backend integration is attached to a "api gateway" "method" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a backend integration is attached to a "api gateway" "method"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then an "api gateway" "integration" is deleted then a "GET" method is created on a "api gateway" "resource"
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When an "api gateway" "integration" is deleted
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a 200 integration response is configured then an existing method is updated
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a 200 integration response is configured
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then an "api gateway" "API" deployment is created then a "api gateway" "method" is deleted along with its integration
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When an "api gateway" "API" deployment is created
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a "api gateway" "deployment" is deleted when no stage references it then a 200 method response is configured
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a "api gateway" "deployment" is deleted when no stage references it
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then the "api gateway" "prod stage" is deleted then a backend integration is attached to a "api gateway" "method"
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When the "api gateway" "prod stage" is deleted
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then the "api gateway" "prod stage" is redeployed to a new deployment then an "api gateway" "integration" is deleted
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then throttling was "ENABLED" for the "api gateway" "prod stage" then a 200 integration response is configured
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then throttling was "DISABLED" for the "api gateway" "prod stage" then an "api gateway" "API" deployment is created
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a request is made to the throttled prod stage then a "api gateway" "deployment" is deleted when no stage references it
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a request is made to the throttled prod stage
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a prod stage is created for an "api gateway" "API" then a backend integration is called then the "api gateway" "prod stage" is deleted
    Given did in deployment_status
    When a prod stage is created for an "api gateway" "API"
    When a backend integration is called
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a "api gateway" "REST API" is created with a root resource then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a "api gateway" "REST API" is created with a root resource
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a root resource is initialized for an "api gateway" "API" then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a root resource is initialized for an "api gateway" "API"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a "api gateway" "REST API" is deleted then a request is made to the throttled prod stage
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a "api gateway" "REST API" is deleted
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a backend integration is called
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "api gateway" "REST API" is created with a root resource
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a "GET" method is created on a "api gateway" "resource" then a root resource is initialized for an "api gateway" "API"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a "GET" method is created on a "api gateway" "resource"
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then an existing method is updated then a "api gateway" "REST API" is deleted
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When an existing method is updated
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a "api gateway" "method" is deleted along with its integration then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a "api gateway" "method" is deleted along with its integration
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a 200 method response is configured then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a 200 method response is configured
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a backend integration is attached to a "api gateway" "method" then a "GET" method is created on a "api gateway" "resource"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a backend integration is attached to a "api gateway" "method"
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then an "api gateway" "integration" is deleted then an existing method is updated
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When an "api gateway" "integration" is deleted
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a 200 integration response is configured then a "api gateway" "method" is deleted along with its integration
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a 200 integration response is configured
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then an "api gateway" "API" deployment is created then a 200 method response is configured
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When an "api gateway" "API" deployment is created
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a "api gateway" "deployment" is deleted when no stage references it then a backend integration is attached to a "api gateway" "method"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a "api gateway" "deployment" is deleted when no stage references it
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a prod stage is created for an "api gateway" "API" then an "api gateway" "integration" is deleted
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a prod stage is created for an "api gateway" "API"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then the "api gateway" "prod stage" is redeployed to a new deployment then a 200 integration response is configured
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then throttling was "ENABLED" for the "api gateway" "prod stage" then an "api gateway" "API" deployment is created
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then throttling was "DISABLED" for the "api gateway" "prod stage" then a "api gateway" "deployment" is deleted when no stage references it
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a request is made to the throttled prod stage then a prod stage is created for an "api gateway" "API"
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a request is made to the throttled prod stage
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is deleted then a backend integration is called then the "api gateway" "prod stage" is redeployed to a new deployment
    Given sk in stage_exists
    When the "api gateway" "prod stage" is deleted
    When a backend integration is called
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a "api gateway" "REST API" is created with a root resource then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "api gateway" "REST API" is created with a root resource
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a root resource is initialized for an "api gateway" "API" then a request is made to the throttled prod stage
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a root resource is initialized for an "api gateway" "API"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a "api gateway" "REST API" is deleted then a backend integration is called
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "api gateway" "REST API" is deleted
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "api gateway" "REST API" is created with a root resource
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a non-root "api gateway" "resource" is deleted along with its methods and integrations then a root resource is initialized for an "api gateway" "API"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a "GET" method is created on a "api gateway" "resource" then a "api gateway" "REST API" is deleted
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "GET" method is created on a "api gateway" "resource"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then an existing method is updated then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When an existing method is updated
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a "api gateway" "method" is deleted along with its integration then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "api gateway" "method" is deleted along with its integration
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a 200 method response is configured then a "GET" method is created on a "api gateway" "resource"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a 200 method response is configured
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a backend integration is attached to a "api gateway" "method" then an existing method is updated
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a backend integration is attached to a "api gateway" "method"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then an "api gateway" "integration" is deleted then a "api gateway" "method" is deleted along with its integration
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When an "api gateway" "integration" is deleted
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a 200 integration response is configured then a 200 method response is configured
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a 200 integration response is configured
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then an "api gateway" "API" deployment is created then a backend integration is attached to a "api gateway" "method"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When an "api gateway" "API" deployment is created
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a "api gateway" "deployment" is deleted when no stage references it then an "api gateway" "integration" is deleted
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a "api gateway" "deployment" is deleted when no stage references it
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a prod stage is created for an "api gateway" "API" then a 200 integration response is configured
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a prod stage is created for an "api gateway" "API"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then the "api gateway" "prod stage" is deleted then an "api gateway" "API" deployment is created
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When the "api gateway" "prod stage" is deleted
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then throttling was "ENABLED" for the "api gateway" "prod stage" then a "api gateway" "deployment" is deleted when no stage references it
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then throttling was "DISABLED" for the "api gateway" "prod stage" then a prod stage is created for an "api gateway" "API"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a request is made to the throttled prod stage then the "api gateway" "prod stage" is deleted
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a request is made to the throttled prod stage
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: the "api gateway" "prod stage" is redeployed to a new deployment then a backend integration is called then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given did in deployment_status
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a backend integration is called
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a "api gateway" "REST API" is created with a root resource then a request is made to the throttled prod stage
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "api gateway" "REST API" is created with a root resource
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a root resource is initialized for an "api gateway" "API" then a backend integration is called
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a root resource is initialized for an "api gateway" "API"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a "api gateway" "REST API" is deleted then a "api gateway" "REST API" is created with a root resource
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "api gateway" "REST API" is deleted
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a root resource is initialized for an "api gateway" "API"
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "api gateway" "REST API" is deleted
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a "GET" method is created on a "api gateway" "resource" then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "GET" method is created on a "api gateway" "resource"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then an existing method is updated then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When an existing method is updated
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a "api gateway" "method" is deleted along with its integration then a "GET" method is created on a "api gateway" "resource"
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "api gateway" "method" is deleted along with its integration
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a 200 method response is configured then an existing method is updated
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a 200 method response is configured
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a backend integration is attached to a "api gateway" "method" then a "api gateway" "method" is deleted along with its integration
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a backend integration is attached to a "api gateway" "method"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then an "api gateway" "integration" is deleted then a 200 method response is configured
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When an "api gateway" "integration" is deleted
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a 200 integration response is configured then a backend integration is attached to a "api gateway" "method"
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a 200 integration response is configured
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then an "api gateway" "API" deployment is created then an "api gateway" "integration" is deleted
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When an "api gateway" "API" deployment is created
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a "api gateway" "deployment" is deleted when no stage references it then a 200 integration response is configured
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a "api gateway" "deployment" is deleted when no stage references it
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a prod stage is created for an "api gateway" "API" then an "api gateway" "API" deployment is created
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a prod stage is created for an "api gateway" "API"
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then the "api gateway" "prod stage" is deleted then a "api gateway" "deployment" is deleted when no stage references it
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When the "api gateway" "prod stage" is deleted
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then the "api gateway" "prod stage" is redeployed to a new deployment then a prod stage is created for an "api gateway" "API"
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then throttling was "DISABLED" for the "api gateway" "prod stage" then the "api gateway" "prod stage" is deleted
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a request is made to the throttled prod stage then the "api gateway" "prod stage" is redeployed to a new deployment
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a request is made to the throttled prod stage
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "ENABLED" for the "api gateway" "prod stage" then a backend integration is called then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given sk in stage_exists
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a backend integration is called
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a "api gateway" "REST API" is created with a root resource then a backend integration is called
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "api gateway" "REST API" is created with a root resource
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a root resource is initialized for an "api gateway" "API" then a "api gateway" "REST API" is created with a root resource
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a root resource is initialized for an "api gateway" "API"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a "api gateway" "REST API" is deleted then a root resource is initialized for an "api gateway" "API"
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "api gateway" "REST API" is deleted
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "api gateway" "REST API" is deleted
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a non-root "api gateway" "resource" is deleted along with its methods and integrations then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a "GET" method is created on a "api gateway" "resource" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "GET" method is created on a "api gateway" "resource"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then an existing method is updated then a "GET" method is created on a "api gateway" "resource"
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When an existing method is updated
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a "api gateway" "method" is deleted along with its integration then an existing method is updated
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "api gateway" "method" is deleted along with its integration
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a 200 method response is configured then a "api gateway" "method" is deleted along with its integration
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a 200 method response is configured
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a backend integration is attached to a "api gateway" "method" then a 200 method response is configured
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a backend integration is attached to a "api gateway" "method"
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then an "api gateway" "integration" is deleted then a backend integration is attached to a "api gateway" "method"
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When an "api gateway" "integration" is deleted
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a 200 integration response is configured then an "api gateway" "integration" is deleted
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a 200 integration response is configured
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then an "api gateway" "API" deployment is created then a 200 integration response is configured
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When an "api gateway" "API" deployment is created
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a "api gateway" "deployment" is deleted when no stage references it then an "api gateway" "API" deployment is created
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "api gateway" "deployment" is deleted when no stage references it
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a prod stage is created for an "api gateway" "API" then a "api gateway" "deployment" is deleted when no stage references it
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a prod stage is created for an "api gateway" "API"
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then the "api gateway" "prod stage" is deleted then a prod stage is created for an "api gateway" "API"
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When the "api gateway" "prod stage" is deleted
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then the "api gateway" "prod stage" is redeployed to a new deployment then the "api gateway" "prod stage" is deleted
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then throttling was "ENABLED" for the "api gateway" "prod stage" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a request is made to the throttled prod stage then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a request is made to the throttled prod stage
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: throttling was "DISABLED" for the "api gateway" "prod stage" then a backend integration is called then a request is made to the throttled prod stage
    Given sk in stage_exists
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a backend integration is called
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a "api gateway" "REST API" is created with a root resource then a root resource is initialized for an "api gateway" "API"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a "api gateway" "REST API" is created with a root resource
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a root resource is initialized for an "api gateway" "API" then a "api gateway" "REST API" is deleted
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a root resource is initialized for an "api gateway" "API"
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a "api gateway" "REST API" is deleted then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a "api gateway" "REST API" is deleted
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a non-root "api gateway" "resource" is deleted along with its methods and integrations then a "GET" method is created on a "api gateway" "resource"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a "GET" method is created on a "api gateway" "resource" then an existing method is updated
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a "GET" method is created on a "api gateway" "resource"
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then an existing method is updated then a "api gateway" "method" is deleted along with its integration
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When an existing method is updated
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a "api gateway" "method" is deleted along with its integration then a 200 method response is configured
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a "api gateway" "method" is deleted along with its integration
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a 200 method response is configured then a backend integration is attached to a "api gateway" "method"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a 200 method response is configured
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a backend integration is attached to a "api gateway" "method" then an "api gateway" "integration" is deleted
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a backend integration is attached to a "api gateway" "method"
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then an "api gateway" "integration" is deleted then a 200 integration response is configured
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When an "api gateway" "integration" is deleted
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a 200 integration response is configured then an "api gateway" "API" deployment is created
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a 200 integration response is configured
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then an "api gateway" "API" deployment is created then a "api gateway" "deployment" is deleted when no stage references it
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When an "api gateway" "API" deployment is created
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a "api gateway" "deployment" is deleted when no stage references it then a prod stage is created for an "api gateway" "API"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a "api gateway" "deployment" is deleted when no stage references it
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a prod stage is created for an "api gateway" "API" then the "api gateway" "prod stage" is deleted
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a prod stage is created for an "api gateway" "API"
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then the "api gateway" "prod stage" is deleted then the "api gateway" "prod stage" is redeployed to a new deployment
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When the "api gateway" "prod stage" is deleted
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then the "api gateway" "prod stage" is redeployed to a new deployment then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then throttling was "ENABLED" for the "api gateway" "prod stage" then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then throttling was "DISABLED" for the "api gateway" "prod stage" then a backend integration is called
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a backend integration is called
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a request is made to the throttled prod stage then a backend integration is called then a "api gateway" "REST API" is created with a root resource
    Given sk in stage_throttling
    When a request is made to the throttled prod stage
    When a backend integration is called
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a "api gateway" "REST API" is created with a root resource then a "api gateway" "REST API" is deleted
    Given mk in integration_status
    When a backend integration is called
    When a "api gateway" "REST API" is created with a root resource
    When a "api gateway" "REST API" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a root resource is initialized for an "api gateway" "API" then a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    Given mk in integration_status
    When a backend integration is called
    When a root resource is initialized for an "api gateway" "API"
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a "api gateway" "REST API" is deleted then a non-root "api gateway" "resource" is deleted along with its methods and integrations
    Given mk in integration_status
    When a backend integration is called
    When a "api gateway" "REST API" is deleted
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a child "api gateway" "resource" is created under an existing "api gateway" "resource" then a "GET" method is created on a "api gateway" "resource"
    Given mk in integration_status
    When a backend integration is called
    When a child "api gateway" "resource" is created under an existing "api gateway" "resource"
    When a "GET" method is created on a "api gateway" "resource"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a non-root "api gateway" "resource" is deleted along with its methods and integrations then an existing method is updated
    Given mk in integration_status
    When a backend integration is called
    When a non-root "api gateway" "resource" is deleted along with its methods and integrations
    When an existing method is updated
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a "GET" method is created on a "api gateway" "resource" then a "api gateway" "method" is deleted along with its integration
    Given mk in integration_status
    When a backend integration is called
    When a "GET" method is created on a "api gateway" "resource"
    When a "api gateway" "method" is deleted along with its integration
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then an existing method is updated then a 200 method response is configured
    Given mk in integration_status
    When a backend integration is called
    When an existing method is updated
    When a 200 method response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a "api gateway" "method" is deleted along with its integration then a backend integration is attached to a "api gateway" "method"
    Given mk in integration_status
    When a backend integration is called
    When a "api gateway" "method" is deleted along with its integration
    When a backend integration is attached to a "api gateway" "method"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a 200 method response is configured then an "api gateway" "integration" is deleted
    Given mk in integration_status
    When a backend integration is called
    When a 200 method response is configured
    When an "api gateway" "integration" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a backend integration is attached to a "api gateway" "method" then a 200 integration response is configured
    Given mk in integration_status
    When a backend integration is called
    When a backend integration is attached to a "api gateway" "method"
    When a 200 integration response is configured
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then an "api gateway" "integration" is deleted then an "api gateway" "API" deployment is created
    Given mk in integration_status
    When a backend integration is called
    When an "api gateway" "integration" is deleted
    When an "api gateway" "API" deployment is created
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a 200 integration response is configured then a "api gateway" "deployment" is deleted when no stage references it
    Given mk in integration_status
    When a backend integration is called
    When a 200 integration response is configured
    When a "api gateway" "deployment" is deleted when no stage references it
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then an "api gateway" "API" deployment is created then a prod stage is created for an "api gateway" "API"
    Given mk in integration_status
    When a backend integration is called
    When an "api gateway" "API" deployment is created
    When a prod stage is created for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a "api gateway" "deployment" is deleted when no stage references it then the "api gateway" "prod stage" is deleted
    Given mk in integration_status
    When a backend integration is called
    When a "api gateway" "deployment" is deleted when no stage references it
    When the "api gateway" "prod stage" is deleted
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a prod stage is created for an "api gateway" "API" then the "api gateway" "prod stage" is redeployed to a new deployment
    Given mk in integration_status
    When a backend integration is called
    When a prod stage is created for an "api gateway" "API"
    When the "api gateway" "prod stage" is redeployed to a new deployment
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then the "api gateway" "prod stage" is deleted then throttling was "ENABLED" for the "api gateway" "prod stage"
    Given mk in integration_status
    When a backend integration is called
    When the "api gateway" "prod stage" is deleted
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then the "api gateway" "prod stage" is redeployed to a new deployment then throttling was "DISABLED" for the "api gateway" "prod stage"
    Given mk in integration_status
    When a backend integration is called
    When the "api gateway" "prod stage" is redeployed to a new deployment
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then throttling was "ENABLED" for the "api gateway" "prod stage" then a request is made to the throttled prod stage
    Given mk in integration_status
    When a backend integration is called
    When throttling was "ENABLED" for the "api gateway" "prod stage"
    When a request is made to the throttled prod stage
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then throttling was "DISABLED" for the "api gateway" "prod stage" then a "api gateway" "REST API" is created with a root resource
    Given mk in integration_status
    When a backend integration is called
    When throttling was "DISABLED" for the "api gateway" "prod stage"
    When a "api gateway" "REST API" is created with a root resource
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @sequence
  Scenario: a backend integration is called then a request is made to the throttled prod stage then a root resource is initialized for an "api gateway" "API"
    Given mk in integration_status
    When a backend integration is called
    When a request is made to the throttled prod stage
    When a root resource is initialized for an "api gateway" "API"
    And all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource
