@apigateway @generated
Feature: Apigateway - Action Sequences

  # Generated from FizzBee spec: apigateway.fizz
  # Safety invariants: ResourcesBelongToExistingApis, MethodsBelongToExistingResources, IntegrationsBelongToExistingMethods, DeploymentsBelongToExistingApis, StagesReferenceExistingDeployments, StagesBelongToExistingApis, RootResourcePreserved

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a root resource is initialized for an "API"
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a "REST" "API" is deleted
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a child resource is created under an existing resource
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a non-root resource is deleted along with its methods and integrations
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a "GET" method is created on a resource
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then an existing method is updated
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a method is deleted along with its integration
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a 200 method response is configured
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a backend integration is attached to a method
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then an integration is deleted
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a 200 integration response is configured
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then an "API" deployment is created
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a deployment is deleted when no stage references it
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a prod stage is created for an "API"
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then the prod stage is deleted
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then the prod stage is redeployed to a new deployment
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then throttling is enabled for the prod stage
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then throttling is disabled for the prod stage
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a request is made to the throttled prod stage
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a backend integration is called
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a "REST" "API" is created with a root resource
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a "REST" "API" is deleted
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a child resource is created under an existing resource
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a non-root resource is deleted along with its methods and integrations
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a "GET" method is created on a resource
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then an existing method is updated
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a method is deleted along with its integration
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a 200 method response is configured
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a backend integration is attached to a method
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then an integration is deleted
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a 200 integration response is configured
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then an "API" deployment is created
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a deployment is deleted when no stage references it
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a prod stage is created for an "API"
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then the prod stage is deleted
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then the prod stage is redeployed to a new deployment
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then throttling is enabled for the prod stage
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then throttling is disabled for the prod stage
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a request is made to the throttled prod stage
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a backend integration is called
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a "REST" "API" is created with a root resource
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a root resource is initialized for an "API"
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a child resource is created under an existing resource
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a non-root resource is deleted along with its methods and integrations
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a "GET" method is created on a resource
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then an existing method is updated
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a method is deleted along with its integration
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a 200 method response is configured
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a backend integration is attached to a method
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then an integration is deleted
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a 200 integration response is configured
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then an "API" deployment is created
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a deployment is deleted when no stage references it
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a prod stage is created for an "API"
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then the prod stage is deleted
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then the prod stage is redeployed to a new deployment
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then throttling is enabled for the prod stage
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then throttling is disabled for the prod stage
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a request is made to the throttled prod stage
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a backend integration is called
    Given aid in api_status
    Given a "REST" "API" has been deleted
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a "REST" "API" is created with a root resource
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a root resource is initialized for an "API"
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a "REST" "API" is deleted
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a non-root resource is deleted along with its methods and integrations
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a "GET" method is created on a resource
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then an existing method is updated
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a method is deleted along with its integration
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a 200 method response is configured
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a backend integration is attached to a method
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then an integration is deleted
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a 200 integration response is configured
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then an "API" deployment is created
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a deployment is deleted when no stage references it
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a prod stage is created for an "API"
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then the prod stage is deleted
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then the prod stage is redeployed to a new deployment
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then throttling is enabled for the prod stage
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then throttling is disabled for the prod stage
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a request is made to the throttled prod stage
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a backend integration is called
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a "REST" "API" is created with a root resource
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a root resource is initialized for an "API"
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a "REST" "API" is deleted
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a child resource is created under an existing resource
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a "GET" method is created on a resource
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then an existing method is updated
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a method is deleted along with its integration
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a 200 method response is configured
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a backend integration is attached to a method
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then an integration is deleted
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a 200 integration response is configured
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then an "API" deployment is created
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a deployment is deleted when no stage references it
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a prod stage is created for an "API"
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then the prod stage is deleted
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then the prod stage is redeployed to a new deployment
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then throttling is enabled for the prod stage
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then throttling is disabled for the prod stage
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a request is made to the throttled prod stage
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a backend integration is called
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a "REST" "API" is created with a root resource
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a root resource is initialized for an "API"
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a "REST" "API" is deleted
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a child resource is created under an existing resource
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a non-root resource is deleted along with its methods and integrations
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then an existing method is updated
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a method is deleted along with its integration
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a 200 method response is configured
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a backend integration is attached to a method
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then an integration is deleted
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a 200 integration response is configured
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then an "API" deployment is created
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a deployment is deleted when no stage references it
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a prod stage is created for an "API"
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then the prod stage is deleted
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then the prod stage is redeployed to a new deployment
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then throttling is enabled for the prod stage
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then throttling is disabled for the prod stage
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a request is made to the throttled prod stage
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a backend integration is called
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a "REST" "API" is created with a root resource
    Given mk in method_status
    Given an existing method has been updated
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a root resource is initialized for an "API"
    Given mk in method_status
    Given an existing method has been updated
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a "REST" "API" is deleted
    Given mk in method_status
    Given an existing method has been updated
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a child resource is created under an existing resource
    Given mk in method_status
    Given an existing method has been updated
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a non-root resource is deleted along with its methods and integrations
    Given mk in method_status
    Given an existing method has been updated
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a "GET" method is created on a resource
    Given mk in method_status
    Given an existing method has been updated
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a method is deleted along with its integration
    Given mk in method_status
    Given an existing method has been updated
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a 200 method response is configured
    Given mk in method_status
    Given an existing method has been updated
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a backend integration is attached to a method
    Given mk in method_status
    Given an existing method has been updated
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then an integration is deleted
    Given mk in method_status
    Given an existing method has been updated
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a 200 integration response is configured
    Given mk in method_status
    Given an existing method has been updated
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then an "API" deployment is created
    Given mk in method_status
    Given an existing method has been updated
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a deployment is deleted when no stage references it
    Given mk in method_status
    Given an existing method has been updated
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a prod stage is created for an "API"
    Given mk in method_status
    Given an existing method has been updated
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then the prod stage is deleted
    Given mk in method_status
    Given an existing method has been updated
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then the prod stage is redeployed to a new deployment
    Given mk in method_status
    Given an existing method has been updated
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then throttling is enabled for the prod stage
    Given mk in method_status
    Given an existing method has been updated
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then throttling is disabled for the prod stage
    Given mk in method_status
    Given an existing method has been updated
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a request is made to the throttled prod stage
    Given mk in method_status
    Given an existing method has been updated
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a backend integration is called
    Given mk in method_status
    Given an existing method has been updated
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a "REST" "API" is created with a root resource
    Given mk in method_status
    Given a method has been deleted along with its integration
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a root resource is initialized for an "API"
    Given mk in method_status
    Given a method has been deleted along with its integration
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a "REST" "API" is deleted
    Given mk in method_status
    Given a method has been deleted along with its integration
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a child resource is created under an existing resource
    Given mk in method_status
    Given a method has been deleted along with its integration
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a non-root resource is deleted along with its methods and integrations
    Given mk in method_status
    Given a method has been deleted along with its integration
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a "GET" method is created on a resource
    Given mk in method_status
    Given a method has been deleted along with its integration
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then an existing method is updated
    Given mk in method_status
    Given a method has been deleted along with its integration
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a 200 method response is configured
    Given mk in method_status
    Given a method has been deleted along with its integration
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a backend integration is attached to a method
    Given mk in method_status
    Given a method has been deleted along with its integration
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then an integration is deleted
    Given mk in method_status
    Given a method has been deleted along with its integration
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a 200 integration response is configured
    Given mk in method_status
    Given a method has been deleted along with its integration
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then an "API" deployment is created
    Given mk in method_status
    Given a method has been deleted along with its integration
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a deployment is deleted when no stage references it
    Given mk in method_status
    Given a method has been deleted along with its integration
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a prod stage is created for an "API"
    Given mk in method_status
    Given a method has been deleted along with its integration
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then the prod stage is deleted
    Given mk in method_status
    Given a method has been deleted along with its integration
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then the prod stage is redeployed to a new deployment
    Given mk in method_status
    Given a method has been deleted along with its integration
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then throttling is enabled for the prod stage
    Given mk in method_status
    Given a method has been deleted along with its integration
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then throttling is disabled for the prod stage
    Given mk in method_status
    Given a method has been deleted along with its integration
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a request is made to the throttled prod stage
    Given mk in method_status
    Given a method has been deleted along with its integration
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a backend integration is called
    Given mk in method_status
    Given a method has been deleted along with its integration
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a "REST" "API" is created with a root resource
    Given mk in method_status
    Given a 200 method response has been configured
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a root resource is initialized for an "API"
    Given mk in method_status
    Given a 200 method response has been configured
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a "REST" "API" is deleted
    Given mk in method_status
    Given a 200 method response has been configured
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a child resource is created under an existing resource
    Given mk in method_status
    Given a 200 method response has been configured
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a non-root resource is deleted along with its methods and integrations
    Given mk in method_status
    Given a 200 method response has been configured
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a "GET" method is created on a resource
    Given mk in method_status
    Given a 200 method response has been configured
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then an existing method is updated
    Given mk in method_status
    Given a 200 method response has been configured
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a method is deleted along with its integration
    Given mk in method_status
    Given a 200 method response has been configured
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a backend integration is attached to a method
    Given mk in method_status
    Given a 200 method response has been configured
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then an integration is deleted
    Given mk in method_status
    Given a 200 method response has been configured
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a 200 integration response is configured
    Given mk in method_status
    Given a 200 method response has been configured
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then an "API" deployment is created
    Given mk in method_status
    Given a 200 method response has been configured
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a deployment is deleted when no stage references it
    Given mk in method_status
    Given a 200 method response has been configured
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a prod stage is created for an "API"
    Given mk in method_status
    Given a 200 method response has been configured
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then the prod stage is deleted
    Given mk in method_status
    Given a 200 method response has been configured
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then the prod stage is redeployed to a new deployment
    Given mk in method_status
    Given a 200 method response has been configured
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then throttling is enabled for the prod stage
    Given mk in method_status
    Given a 200 method response has been configured
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then throttling is disabled for the prod stage
    Given mk in method_status
    Given a 200 method response has been configured
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a request is made to the throttled prod stage
    Given mk in method_status
    Given a 200 method response has been configured
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a backend integration is called
    Given mk in method_status
    Given a 200 method response has been configured
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a "REST" "API" is created with a root resource
    Given mk in method_status
    Given a backend integration has been attached to a method
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a root resource is initialized for an "API"
    Given mk in method_status
    Given a backend integration has been attached to a method
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a "REST" "API" is deleted
    Given mk in method_status
    Given a backend integration has been attached to a method
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a child resource is created under an existing resource
    Given mk in method_status
    Given a backend integration has been attached to a method
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a non-root resource is deleted along with its methods and integrations
    Given mk in method_status
    Given a backend integration has been attached to a method
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a "GET" method is created on a resource
    Given mk in method_status
    Given a backend integration has been attached to a method
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then an existing method is updated
    Given mk in method_status
    Given a backend integration has been attached to a method
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a method is deleted along with its integration
    Given mk in method_status
    Given a backend integration has been attached to a method
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a 200 method response is configured
    Given mk in method_status
    Given a backend integration has been attached to a method
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then an integration is deleted
    Given mk in method_status
    Given a backend integration has been attached to a method
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a 200 integration response is configured
    Given mk in method_status
    Given a backend integration has been attached to a method
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then an "API" deployment is created
    Given mk in method_status
    Given a backend integration has been attached to a method
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a deployment is deleted when no stage references it
    Given mk in method_status
    Given a backend integration has been attached to a method
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a prod stage is created for an "API"
    Given mk in method_status
    Given a backend integration has been attached to a method
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then the prod stage is deleted
    Given mk in method_status
    Given a backend integration has been attached to a method
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then the prod stage is redeployed to a new deployment
    Given mk in method_status
    Given a backend integration has been attached to a method
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then throttling is enabled for the prod stage
    Given mk in method_status
    Given a backend integration has been attached to a method
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then throttling is disabled for the prod stage
    Given mk in method_status
    Given a backend integration has been attached to a method
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a request is made to the throttled prod stage
    Given mk in method_status
    Given a backend integration has been attached to a method
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a backend integration is called
    Given mk in method_status
    Given a backend integration has been attached to a method
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a "REST" "API" is created with a root resource
    Given mk in integration_status
    Given an integration has been deleted
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a root resource is initialized for an "API"
    Given mk in integration_status
    Given an integration has been deleted
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a "REST" "API" is deleted
    Given mk in integration_status
    Given an integration has been deleted
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a child resource is created under an existing resource
    Given mk in integration_status
    Given an integration has been deleted
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a non-root resource is deleted along with its methods and integrations
    Given mk in integration_status
    Given an integration has been deleted
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a "GET" method is created on a resource
    Given mk in integration_status
    Given an integration has been deleted
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then an existing method is updated
    Given mk in integration_status
    Given an integration has been deleted
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a method is deleted along with its integration
    Given mk in integration_status
    Given an integration has been deleted
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a 200 method response is configured
    Given mk in integration_status
    Given an integration has been deleted
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a backend integration is attached to a method
    Given mk in integration_status
    Given an integration has been deleted
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a 200 integration response is configured
    Given mk in integration_status
    Given an integration has been deleted
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then an "API" deployment is created
    Given mk in integration_status
    Given an integration has been deleted
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a deployment is deleted when no stage references it
    Given mk in integration_status
    Given an integration has been deleted
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a prod stage is created for an "API"
    Given mk in integration_status
    Given an integration has been deleted
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then the prod stage is deleted
    Given mk in integration_status
    Given an integration has been deleted
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then the prod stage is redeployed to a new deployment
    Given mk in integration_status
    Given an integration has been deleted
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then throttling is enabled for the prod stage
    Given mk in integration_status
    Given an integration has been deleted
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then throttling is disabled for the prod stage
    Given mk in integration_status
    Given an integration has been deleted
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a request is made to the throttled prod stage
    Given mk in integration_status
    Given an integration has been deleted
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a backend integration is called
    Given mk in integration_status
    Given an integration has been deleted
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a "REST" "API" is created with a root resource
    Given mk in integration_status
    Given a 200 integration response has been configured
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a root resource is initialized for an "API"
    Given mk in integration_status
    Given a 200 integration response has been configured
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a "REST" "API" is deleted
    Given mk in integration_status
    Given a 200 integration response has been configured
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a child resource is created under an existing resource
    Given mk in integration_status
    Given a 200 integration response has been configured
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a non-root resource is deleted along with its methods and integrations
    Given mk in integration_status
    Given a 200 integration response has been configured
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a "GET" method is created on a resource
    Given mk in integration_status
    Given a 200 integration response has been configured
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then an existing method is updated
    Given mk in integration_status
    Given a 200 integration response has been configured
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a method is deleted along with its integration
    Given mk in integration_status
    Given a 200 integration response has been configured
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a 200 method response is configured
    Given mk in integration_status
    Given a 200 integration response has been configured
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a backend integration is attached to a method
    Given mk in integration_status
    Given a 200 integration response has been configured
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then an integration is deleted
    Given mk in integration_status
    Given a 200 integration response has been configured
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then an "API" deployment is created
    Given mk in integration_status
    Given a 200 integration response has been configured
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a deployment is deleted when no stage references it
    Given mk in integration_status
    Given a 200 integration response has been configured
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a prod stage is created for an "API"
    Given mk in integration_status
    Given a 200 integration response has been configured
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then the prod stage is deleted
    Given mk in integration_status
    Given a 200 integration response has been configured
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then the prod stage is redeployed to a new deployment
    Given mk in integration_status
    Given a 200 integration response has been configured
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then throttling is enabled for the prod stage
    Given mk in integration_status
    Given a 200 integration response has been configured
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then throttling is disabled for the prod stage
    Given mk in integration_status
    Given a 200 integration response has been configured
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a request is made to the throttled prod stage
    Given mk in integration_status
    Given a 200 integration response has been configured
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a backend integration is called
    Given mk in integration_status
    Given a 200 integration response has been configured
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a "REST" "API" is created with a root resource
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a root resource is initialized for an "API"
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a "REST" "API" is deleted
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a child resource is created under an existing resource
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a non-root resource is deleted along with its methods and integrations
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a "GET" method is created on a resource
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then an existing method is updated
    Given did not in deployment_status
    Given an "API" deployment has been created
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a method is deleted along with its integration
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a 200 method response is configured
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a backend integration is attached to a method
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then an integration is deleted
    Given did not in deployment_status
    Given an "API" deployment has been created
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a 200 integration response is configured
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a deployment is deleted when no stage references it
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a prod stage is created for an "API"
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then the prod stage is deleted
    Given did not in deployment_status
    Given an "API" deployment has been created
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then the prod stage is redeployed to a new deployment
    Given did not in deployment_status
    Given an "API" deployment has been created
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then throttling is enabled for the prod stage
    Given did not in deployment_status
    Given an "API" deployment has been created
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then throttling is disabled for the prod stage
    Given did not in deployment_status
    Given an "API" deployment has been created
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a request is made to the throttled prod stage
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a backend integration is called
    Given did not in deployment_status
    Given an "API" deployment has been created
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a "REST" "API" is created with a root resource
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a root resource is initialized for an "API"
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a "REST" "API" is deleted
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a child resource is created under an existing resource
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a non-root resource is deleted along with its methods and integrations
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a "GET" method is created on a resource
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then an existing method is updated
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a method is deleted along with its integration
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a 200 method response is configured
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a backend integration is attached to a method
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then an integration is deleted
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a 200 integration response is configured
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then an "API" deployment is created
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a prod stage is created for an "API"
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then the prod stage is deleted
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then the prod stage is redeployed to a new deployment
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then throttling is enabled for the prod stage
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then throttling is disabled for the prod stage
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a request is made to the throttled prod stage
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a backend integration is called
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a "REST" "API" is created with a root resource
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a root resource is initialized for an "API"
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a "REST" "API" is deleted
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a child resource is created under an existing resource
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a non-root resource is deleted along with its methods and integrations
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a "GET" method is created on a resource
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then an existing method is updated
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a method is deleted along with its integration
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a 200 method response is configured
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a backend integration is attached to a method
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then an integration is deleted
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a 200 integration response is configured
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then an "API" deployment is created
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a deployment is deleted when no stage references it
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then the prod stage is deleted
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then the prod stage is redeployed to a new deployment
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then throttling is enabled for the prod stage
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then throttling is disabled for the prod stage
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a request is made to the throttled prod stage
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a backend integration is called
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a "REST" "API" is created with a root resource
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a root resource is initialized for an "API"
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a "REST" "API" is deleted
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a child resource is created under an existing resource
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a non-root resource is deleted along with its methods and integrations
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a "GET" method is created on a resource
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then an existing method is updated
    Given sk in stage_exists
    Given the prod stage has been deleted
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a method is deleted along with its integration
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a 200 method response is configured
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a backend integration is attached to a method
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then an integration is deleted
    Given sk in stage_exists
    Given the prod stage has been deleted
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a 200 integration response is configured
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then an "API" deployment is created
    Given sk in stage_exists
    Given the prod stage has been deleted
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a deployment is deleted when no stage references it
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a prod stage is created for an "API"
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then the prod stage is redeployed to a new deployment
    Given sk in stage_exists
    Given the prod stage has been deleted
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then throttling is enabled for the prod stage
    Given sk in stage_exists
    Given the prod stage has been deleted
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then throttling is disabled for the prod stage
    Given sk in stage_exists
    Given the prod stage has been deleted
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a request is made to the throttled prod stage
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a backend integration is called
    Given sk in stage_exists
    Given the prod stage has been deleted
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a "REST" "API" is created with a root resource
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a root resource is initialized for an "API"
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a "REST" "API" is deleted
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a child resource is created under an existing resource
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a non-root resource is deleted along with its methods and integrations
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a "GET" method is created on a resource
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then an existing method is updated
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a method is deleted along with its integration
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a 200 method response is configured
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a backend integration is attached to a method
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then an integration is deleted
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a 200 integration response is configured
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then an "API" deployment is created
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a deployment is deleted when no stage references it
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a prod stage is created for an "API"
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then the prod stage is deleted
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then throttling is enabled for the prod stage
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then throttling is disabled for the prod stage
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a request is made to the throttled prod stage
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a backend integration is called
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a "REST" "API" is created with a root resource
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a root resource is initialized for an "API"
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a "REST" "API" is deleted
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a child resource is created under an existing resource
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a non-root resource is deleted along with its methods and integrations
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a "GET" method is created on a resource
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then an existing method is updated
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a method is deleted along with its integration
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a 200 method response is configured
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a backend integration is attached to a method
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then an integration is deleted
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a 200 integration response is configured
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then an "API" deployment is created
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a deployment is deleted when no stage references it
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a prod stage is created for an "API"
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then the prod stage is deleted
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then the prod stage is redeployed to a new deployment
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then throttling is disabled for the prod stage
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a request is made to the throttled prod stage
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a backend integration is called
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a "REST" "API" is created with a root resource
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a root resource is initialized for an "API"
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a "REST" "API" is deleted
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a child resource is created under an existing resource
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a non-root resource is deleted along with its methods and integrations
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a "GET" method is created on a resource
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then an existing method is updated
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a method is deleted along with its integration
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a 200 method response is configured
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a backend integration is attached to a method
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then an integration is deleted
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a 200 integration response is configured
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then an "API" deployment is created
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a deployment is deleted when no stage references it
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a prod stage is created for an "API"
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then the prod stage is deleted
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then the prod stage is redeployed to a new deployment
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then throttling is enabled for the prod stage
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a request is made to the throttled prod stage
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a backend integration is called
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a "REST" "API" is created with a root resource
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a root resource is initialized for an "API"
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a "REST" "API" is deleted
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a child resource is created under an existing resource
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a non-root resource is deleted along with its methods and integrations
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a "GET" method is created on a resource
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then an existing method is updated
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a method is deleted along with its integration
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a 200 method response is configured
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a backend integration is attached to a method
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then an integration is deleted
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a 200 integration response is configured
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then an "API" deployment is created
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a deployment is deleted when no stage references it
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a prod stage is created for an "API"
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then the prod stage is deleted
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then the prod stage is redeployed to a new deployment
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then throttling is enabled for the prod stage
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then throttling is disabled for the prod stage
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a backend integration is called
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a "REST" "API" is created with a root resource
    Given mk in integration_status
    Given a backend integration has been called
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a root resource is initialized for an "API"
    Given mk in integration_status
    Given a backend integration has been called
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a "REST" "API" is deleted
    Given mk in integration_status
    Given a backend integration has been called
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a child resource is created under an existing resource
    Given mk in integration_status
    Given a backend integration has been called
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a non-root resource is deleted along with its methods and integrations
    Given mk in integration_status
    Given a backend integration has been called
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a "GET" method is created on a resource
    Given mk in integration_status
    Given a backend integration has been called
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then an existing method is updated
    Given mk in integration_status
    Given a backend integration has been called
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a method is deleted along with its integration
    Given mk in integration_status
    Given a backend integration has been called
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a 200 method response is configured
    Given mk in integration_status
    Given a backend integration has been called
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a backend integration is attached to a method
    Given mk in integration_status
    Given a backend integration has been called
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then an integration is deleted
    Given mk in integration_status
    Given a backend integration has been called
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a 200 integration response is configured
    Given mk in integration_status
    Given a backend integration has been called
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then an "API" deployment is created
    Given mk in integration_status
    Given a backend integration has been called
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a deployment is deleted when no stage references it
    Given mk in integration_status
    Given a backend integration has been called
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a prod stage is created for an "API"
    Given mk in integration_status
    Given a backend integration has been called
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then the prod stage is deleted
    Given mk in integration_status
    Given a backend integration has been called
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then the prod stage is redeployed to a new deployment
    Given mk in integration_status
    Given a backend integration has been called
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then throttling is enabled for the prod stage
    Given mk in integration_status
    Given a backend integration has been called
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then throttling is disabled for the prod stage
    Given mk in integration_status
    Given a backend integration has been called
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a request is made to the throttled prod stage
    Given mk in integration_status
    Given a backend integration has been called
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a root resource is initialized for an "API" then a "REST" "API" is deleted
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given a root resource has been initialized for an "API"
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a "REST" "API" is deleted then a child resource is created under an existing resource
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given a "REST" "API" has been deleted
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a child resource is created under an existing resource then a non-root resource is deleted along with its methods and integrations
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given a child resource has been created under an existing resource
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a non-root resource is deleted along with its methods and integrations then a "GET" method is created on a resource
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given a non-root resource has been deleted along with its methods and integrations
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a "GET" method is created on a resource then an existing method is updated
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given a "GET" method has been created on a resource
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then an existing method is updated then a method is deleted along with its integration
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given an existing method has been updated
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a method is deleted along with its integration then a 200 method response is configured
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given a method has been deleted along with its integration
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a 200 method response is configured then a backend integration is attached to a method
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given a 200 method response has been configured
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a backend integration is attached to a method then an integration is deleted
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given a backend integration has been attached to a method
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then an integration is deleted then a 200 integration response is configured
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given an integration has been deleted
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a 200 integration response is configured then an "API" deployment is created
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given a 200 integration response has been configured
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then an "API" deployment is created then a deployment is deleted when no stage references it
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given an "API" deployment has been created
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a deployment is deleted when no stage references it then a prod stage is created for an "API"
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given a deployment has been deleted when no stage references it
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a prod stage is created for an "API" then the prod stage is deleted
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given a prod stage has been created for an "API"
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then the prod stage is deleted then the prod stage is redeployed to a new deployment
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given the prod stage has been deleted
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then the prod stage is redeployed to a new deployment then throttling is enabled for the prod stage
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given the prod stage has been redeployed to a new deployment
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then throttling is enabled for the prod stage then throttling is disabled for the prod stage
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given throttling has been enabled for the prod stage
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then throttling is disabled for the prod stage then a request is made to the throttled prod stage
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given throttling has been disabled for the prod stage
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a request is made to the throttled prod stage then a backend integration is called
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given a request has been made to the throttled prod stage
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is created with a root resource then a backend integration is called then a root resource is initialized for an "API"
    Given aid not in api_status
    Given a "REST" "API" has been created with a root resource
    Given a backend integration has been called
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a "REST" "API" is created with a root resource then a child resource is created under an existing resource
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given a "REST" "API" has been created with a root resource
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a "REST" "API" is deleted then a non-root resource is deleted along with its methods and integrations
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given a "REST" "API" has been deleted
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a child resource is created under an existing resource then a "GET" method is created on a resource
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given a child resource has been created under an existing resource
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a non-root resource is deleted along with its methods and integrations then an existing method is updated
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given a non-root resource has been deleted along with its methods and integrations
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a "GET" method is created on a resource then a method is deleted along with its integration
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given a "GET" method has been created on a resource
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then an existing method is updated then a 200 method response is configured
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given an existing method has been updated
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a method is deleted along with its integration then a backend integration is attached to a method
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given a method has been deleted along with its integration
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a 200 method response is configured then an integration is deleted
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given a 200 method response has been configured
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a backend integration is attached to a method then a 200 integration response is configured
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given a backend integration has been attached to a method
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then an integration is deleted then an "API" deployment is created
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given an integration has been deleted
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a 200 integration response is configured then a deployment is deleted when no stage references it
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given a 200 integration response has been configured
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then an "API" deployment is created then a prod stage is created for an "API"
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given an "API" deployment has been created
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a deployment is deleted when no stage references it then the prod stage is deleted
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given a deployment has been deleted when no stage references it
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a prod stage is created for an "API" then the prod stage is redeployed to a new deployment
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given a prod stage has been created for an "API"
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then the prod stage is deleted then throttling is enabled for the prod stage
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given the prod stage has been deleted
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then the prod stage is redeployed to a new deployment then throttling is disabled for the prod stage
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given the prod stage has been redeployed to a new deployment
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then throttling is enabled for the prod stage then a request is made to the throttled prod stage
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given throttling has been enabled for the prod stage
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then throttling is disabled for the prod stage then a backend integration is called
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given throttling has been disabled for the prod stage
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a request is made to the throttled prod stage then a "REST" "API" is created with a root resource
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given a request has been made to the throttled prod stage
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a root resource is initialized for an "API" then a backend integration is called then a "REST" "API" is deleted
    Given aid in api_status
    Given a root resource has been initialized for an "API"
    Given a backend integration has been called
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a "REST" "API" is created with a root resource then a non-root resource is deleted along with its methods and integrations
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given a "REST" "API" has been created with a root resource
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a root resource is initialized for an "API" then a "GET" method is created on a resource
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given a root resource has been initialized for an "API"
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a child resource is created under an existing resource then an existing method is updated
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given a child resource has been created under an existing resource
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a non-root resource is deleted along with its methods and integrations then a method is deleted along with its integration
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given a non-root resource has been deleted along with its methods and integrations
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a "GET" method is created on a resource then a 200 method response is configured
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given a "GET" method has been created on a resource
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then an existing method is updated then a backend integration is attached to a method
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given an existing method has been updated
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a method is deleted along with its integration then an integration is deleted
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given a method has been deleted along with its integration
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a 200 method response is configured then a 200 integration response is configured
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given a 200 method response has been configured
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a backend integration is attached to a method then an "API" deployment is created
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given a backend integration has been attached to a method
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then an integration is deleted then a deployment is deleted when no stage references it
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given an integration has been deleted
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a 200 integration response is configured then a prod stage is created for an "API"
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given a 200 integration response has been configured
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then an "API" deployment is created then the prod stage is deleted
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given an "API" deployment has been created
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a deployment is deleted when no stage references it then the prod stage is redeployed to a new deployment
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given a deployment has been deleted when no stage references it
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a prod stage is created for an "API" then throttling is enabled for the prod stage
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given a prod stage has been created for an "API"
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then the prod stage is deleted then throttling is disabled for the prod stage
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given the prod stage has been deleted
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then the prod stage is redeployed to a new deployment then a request is made to the throttled prod stage
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given the prod stage has been redeployed to a new deployment
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then throttling is enabled for the prod stage then a backend integration is called
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given throttling has been enabled for the prod stage
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then throttling is disabled for the prod stage then a "REST" "API" is created with a root resource
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given throttling has been disabled for the prod stage
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a request is made to the throttled prod stage then a root resource is initialized for an "API"
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given a request has been made to the throttled prod stage
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "REST" "API" is deleted then a backend integration is called then a child resource is created under an existing resource
    Given aid in api_status
    Given a "REST" "API" has been deleted
    Given a backend integration has been called
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a "REST" "API" is created with a root resource then a "GET" method is created on a resource
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given a "REST" "API" has been created with a root resource
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a root resource is initialized for an "API" then an existing method is updated
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given a root resource has been initialized for an "API"
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a "REST" "API" is deleted then a method is deleted along with its integration
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given a "REST" "API" has been deleted
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a non-root resource is deleted along with its methods and integrations then a 200 method response is configured
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given a non-root resource has been deleted along with its methods and integrations
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a "GET" method is created on a resource then a backend integration is attached to a method
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given a "GET" method has been created on a resource
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then an existing method is updated then an integration is deleted
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given an existing method has been updated
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a method is deleted along with its integration then a 200 integration response is configured
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given a method has been deleted along with its integration
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a 200 method response is configured then an "API" deployment is created
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given a 200 method response has been configured
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a backend integration is attached to a method then a deployment is deleted when no stage references it
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given a backend integration has been attached to a method
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then an integration is deleted then a prod stage is created for an "API"
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given an integration has been deleted
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a 200 integration response is configured then the prod stage is deleted
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given a 200 integration response has been configured
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then an "API" deployment is created then the prod stage is redeployed to a new deployment
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given an "API" deployment has been created
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a deployment is deleted when no stage references it then throttling is enabled for the prod stage
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given a deployment has been deleted when no stage references it
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a prod stage is created for an "API" then throttling is disabled for the prod stage
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given a prod stage has been created for an "API"
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then the prod stage is deleted then a request is made to the throttled prod stage
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given the prod stage has been deleted
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then the prod stage is redeployed to a new deployment then a backend integration is called
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given the prod stage has been redeployed to a new deployment
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then throttling is enabled for the prod stage then a "REST" "API" is created with a root resource
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given throttling has been enabled for the prod stage
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then throttling is disabled for the prod stage then a root resource is initialized for an "API"
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given throttling has been disabled for the prod stage
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a request is made to the throttled prod stage then a "REST" "API" is deleted
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given a request has been made to the throttled prod stage
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a child resource is created under an existing resource then a backend integration is called then a non-root resource is deleted along with its methods and integrations
    Given rid not in resource_api
    Given a child resource has been created under an existing resource
    Given a backend integration has been called
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a "REST" "API" is created with a root resource then an existing method is updated
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given a "REST" "API" has been created with a root resource
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a root resource is initialized for an "API" then a method is deleted along with its integration
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given a root resource has been initialized for an "API"
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a "REST" "API" is deleted then a 200 method response is configured
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given a "REST" "API" has been deleted
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a child resource is created under an existing resource then a backend integration is attached to a method
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given a child resource has been created under an existing resource
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a "GET" method is created on a resource then an integration is deleted
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given a "GET" method has been created on a resource
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then an existing method is updated then a 200 integration response is configured
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given an existing method has been updated
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a method is deleted along with its integration then an "API" deployment is created
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given a method has been deleted along with its integration
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a 200 method response is configured then a deployment is deleted when no stage references it
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given a 200 method response has been configured
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a backend integration is attached to a method then a prod stage is created for an "API"
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given a backend integration has been attached to a method
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then an integration is deleted then the prod stage is deleted
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given an integration has been deleted
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a 200 integration response is configured then the prod stage is redeployed to a new deployment
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given a 200 integration response has been configured
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then an "API" deployment is created then throttling is enabled for the prod stage
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given an "API" deployment has been created
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a deployment is deleted when no stage references it then throttling is disabled for the prod stage
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given a deployment has been deleted when no stage references it
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a prod stage is created for an "API" then a request is made to the throttled prod stage
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given a prod stage has been created for an "API"
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then the prod stage is deleted then a backend integration is called
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given the prod stage has been deleted
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then the prod stage is redeployed to a new deployment then a "REST" "API" is created with a root resource
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given the prod stage has been redeployed to a new deployment
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then throttling is enabled for the prod stage then a root resource is initialized for an "API"
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given throttling has been enabled for the prod stage
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then throttling is disabled for the prod stage then a "REST" "API" is deleted
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given throttling has been disabled for the prod stage
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a request is made to the throttled prod stage then a child resource is created under an existing resource
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given a request has been made to the throttled prod stage
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a non-root resource is deleted along with its methods and integrations then a backend integration is called then a "GET" method is created on a resource
    Given rid in resource_status
    Given a non-root resource has been deleted along with its methods and integrations
    Given a backend integration has been called
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a "REST" "API" is created with a root resource then a method is deleted along with its integration
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given a "REST" "API" has been created with a root resource
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a root resource is initialized for an "API" then a 200 method response is configured
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given a root resource has been initialized for an "API"
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a "REST" "API" is deleted then a backend integration is attached to a method
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given a "REST" "API" has been deleted
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a child resource is created under an existing resource then an integration is deleted
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given a child resource has been created under an existing resource
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a non-root resource is deleted along with its methods and integrations then a 200 integration response is configured
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given a non-root resource has been deleted along with its methods and integrations
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then an existing method is updated then an "API" deployment is created
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given an existing method has been updated
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a method is deleted along with its integration then a deployment is deleted when no stage references it
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given a method has been deleted along with its integration
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a 200 method response is configured then a prod stage is created for an "API"
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given a 200 method response has been configured
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a backend integration is attached to a method then the prod stage is deleted
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given a backend integration has been attached to a method
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then an integration is deleted then the prod stage is redeployed to a new deployment
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given an integration has been deleted
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a 200 integration response is configured then throttling is enabled for the prod stage
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given a 200 integration response has been configured
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then an "API" deployment is created then throttling is disabled for the prod stage
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given an "API" deployment has been created
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a deployment is deleted when no stage references it then a request is made to the throttled prod stage
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given a deployment has been deleted when no stage references it
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a prod stage is created for an "API" then a backend integration is called
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given a prod stage has been created for an "API"
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then the prod stage is deleted then a "REST" "API" is created with a root resource
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given the prod stage has been deleted
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then the prod stage is redeployed to a new deployment then a root resource is initialized for an "API"
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given the prod stage has been redeployed to a new deployment
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then throttling is enabled for the prod stage then a "REST" "API" is deleted
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given throttling has been enabled for the prod stage
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then throttling is disabled for the prod stage then a child resource is created under an existing resource
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given throttling has been disabled for the prod stage
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a request is made to the throttled prod stage then a non-root resource is deleted along with its methods and integrations
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given a request has been made to the throttled prod stage
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a "GET" method is created on a resource then a backend integration is called then an existing method is updated
    Given mk not in method_status
    Given a "GET" method has been created on a resource
    Given a backend integration has been called
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a "REST" "API" is created with a root resource then a 200 method response is configured
    Given mk in method_status
    Given an existing method has been updated
    Given a "REST" "API" has been created with a root resource
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a root resource is initialized for an "API" then a backend integration is attached to a method
    Given mk in method_status
    Given an existing method has been updated
    Given a root resource has been initialized for an "API"
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a "REST" "API" is deleted then an integration is deleted
    Given mk in method_status
    Given an existing method has been updated
    Given a "REST" "API" has been deleted
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a child resource is created under an existing resource then a 200 integration response is configured
    Given mk in method_status
    Given an existing method has been updated
    Given a child resource has been created under an existing resource
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a non-root resource is deleted along with its methods and integrations then an "API" deployment is created
    Given mk in method_status
    Given an existing method has been updated
    Given a non-root resource has been deleted along with its methods and integrations
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a "GET" method is created on a resource then a deployment is deleted when no stage references it
    Given mk in method_status
    Given an existing method has been updated
    Given a "GET" method has been created on a resource
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a method is deleted along with its integration then a prod stage is created for an "API"
    Given mk in method_status
    Given an existing method has been updated
    Given a method has been deleted along with its integration
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a 200 method response is configured then the prod stage is deleted
    Given mk in method_status
    Given an existing method has been updated
    Given a 200 method response has been configured
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a backend integration is attached to a method then the prod stage is redeployed to a new deployment
    Given mk in method_status
    Given an existing method has been updated
    Given a backend integration has been attached to a method
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then an integration is deleted then throttling is enabled for the prod stage
    Given mk in method_status
    Given an existing method has been updated
    Given an integration has been deleted
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a 200 integration response is configured then throttling is disabled for the prod stage
    Given mk in method_status
    Given an existing method has been updated
    Given a 200 integration response has been configured
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then an "API" deployment is created then a request is made to the throttled prod stage
    Given mk in method_status
    Given an existing method has been updated
    Given an "API" deployment has been created
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a deployment is deleted when no stage references it then a backend integration is called
    Given mk in method_status
    Given an existing method has been updated
    Given a deployment has been deleted when no stage references it
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a prod stage is created for an "API" then a "REST" "API" is created with a root resource
    Given mk in method_status
    Given an existing method has been updated
    Given a prod stage has been created for an "API"
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then the prod stage is deleted then a root resource is initialized for an "API"
    Given mk in method_status
    Given an existing method has been updated
    Given the prod stage has been deleted
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then the prod stage is redeployed to a new deployment then a "REST" "API" is deleted
    Given mk in method_status
    Given an existing method has been updated
    Given the prod stage has been redeployed to a new deployment
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then throttling is enabled for the prod stage then a child resource is created under an existing resource
    Given mk in method_status
    Given an existing method has been updated
    Given throttling has been enabled for the prod stage
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then throttling is disabled for the prod stage then a non-root resource is deleted along with its methods and integrations
    Given mk in method_status
    Given an existing method has been updated
    Given throttling has been disabled for the prod stage
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a request is made to the throttled prod stage then a "GET" method is created on a resource
    Given mk in method_status
    Given an existing method has been updated
    Given a request has been made to the throttled prod stage
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an existing method is updated then a backend integration is called then a method is deleted along with its integration
    Given mk in method_status
    Given an existing method has been updated
    Given a backend integration has been called
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a "REST" "API" is created with a root resource then a backend integration is attached to a method
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given a "REST" "API" has been created with a root resource
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a root resource is initialized for an "API" then an integration is deleted
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given a root resource has been initialized for an "API"
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a "REST" "API" is deleted then a 200 integration response is configured
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given a "REST" "API" has been deleted
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a child resource is created under an existing resource then an "API" deployment is created
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given a child resource has been created under an existing resource
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a non-root resource is deleted along with its methods and integrations then a deployment is deleted when no stage references it
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given a non-root resource has been deleted along with its methods and integrations
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a "GET" method is created on a resource then a prod stage is created for an "API"
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given a "GET" method has been created on a resource
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then an existing method is updated then the prod stage is deleted
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given an existing method has been updated
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a 200 method response is configured then the prod stage is redeployed to a new deployment
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given a 200 method response has been configured
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a backend integration is attached to a method then throttling is enabled for the prod stage
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given a backend integration has been attached to a method
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then an integration is deleted then throttling is disabled for the prod stage
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given an integration has been deleted
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a 200 integration response is configured then a request is made to the throttled prod stage
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given a 200 integration response has been configured
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then an "API" deployment is created then a backend integration is called
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given an "API" deployment has been created
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a deployment is deleted when no stage references it then a "REST" "API" is created with a root resource
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given a deployment has been deleted when no stage references it
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a prod stage is created for an "API" then a root resource is initialized for an "API"
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given a prod stage has been created for an "API"
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then the prod stage is deleted then a "REST" "API" is deleted
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given the prod stage has been deleted
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then the prod stage is redeployed to a new deployment then a child resource is created under an existing resource
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given the prod stage has been redeployed to a new deployment
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then throttling is enabled for the prod stage then a non-root resource is deleted along with its methods and integrations
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given throttling has been enabled for the prod stage
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then throttling is disabled for the prod stage then a "GET" method is created on a resource
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given throttling has been disabled for the prod stage
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a request is made to the throttled prod stage then an existing method is updated
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given a request has been made to the throttled prod stage
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a method is deleted along with its integration then a backend integration is called then a 200 method response is configured
    Given mk in method_status
    Given a method has been deleted along with its integration
    Given a backend integration has been called
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a "REST" "API" is created with a root resource then an integration is deleted
    Given mk in method_status
    Given a 200 method response has been configured
    Given a "REST" "API" has been created with a root resource
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a root resource is initialized for an "API" then a 200 integration response is configured
    Given mk in method_status
    Given a 200 method response has been configured
    Given a root resource has been initialized for an "API"
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a "REST" "API" is deleted then an "API" deployment is created
    Given mk in method_status
    Given a 200 method response has been configured
    Given a "REST" "API" has been deleted
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a child resource is created under an existing resource then a deployment is deleted when no stage references it
    Given mk in method_status
    Given a 200 method response has been configured
    Given a child resource has been created under an existing resource
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a non-root resource is deleted along with its methods and integrations then a prod stage is created for an "API"
    Given mk in method_status
    Given a 200 method response has been configured
    Given a non-root resource has been deleted along with its methods and integrations
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a "GET" method is created on a resource then the prod stage is deleted
    Given mk in method_status
    Given a 200 method response has been configured
    Given a "GET" method has been created on a resource
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then an existing method is updated then the prod stage is redeployed to a new deployment
    Given mk in method_status
    Given a 200 method response has been configured
    Given an existing method has been updated
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a method is deleted along with its integration then throttling is enabled for the prod stage
    Given mk in method_status
    Given a 200 method response has been configured
    Given a method has been deleted along with its integration
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a backend integration is attached to a method then throttling is disabled for the prod stage
    Given mk in method_status
    Given a 200 method response has been configured
    Given a backend integration has been attached to a method
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then an integration is deleted then a request is made to the throttled prod stage
    Given mk in method_status
    Given a 200 method response has been configured
    Given an integration has been deleted
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a 200 integration response is configured then a backend integration is called
    Given mk in method_status
    Given a 200 method response has been configured
    Given a 200 integration response has been configured
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then an "API" deployment is created then a "REST" "API" is created with a root resource
    Given mk in method_status
    Given a 200 method response has been configured
    Given an "API" deployment has been created
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a deployment is deleted when no stage references it then a root resource is initialized for an "API"
    Given mk in method_status
    Given a 200 method response has been configured
    Given a deployment has been deleted when no stage references it
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a prod stage is created for an "API" then a "REST" "API" is deleted
    Given mk in method_status
    Given a 200 method response has been configured
    Given a prod stage has been created for an "API"
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then the prod stage is deleted then a child resource is created under an existing resource
    Given mk in method_status
    Given a 200 method response has been configured
    Given the prod stage has been deleted
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then the prod stage is redeployed to a new deployment then a non-root resource is deleted along with its methods and integrations
    Given mk in method_status
    Given a 200 method response has been configured
    Given the prod stage has been redeployed to a new deployment
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then throttling is enabled for the prod stage then a "GET" method is created on a resource
    Given mk in method_status
    Given a 200 method response has been configured
    Given throttling has been enabled for the prod stage
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then throttling is disabled for the prod stage then an existing method is updated
    Given mk in method_status
    Given a 200 method response has been configured
    Given throttling has been disabled for the prod stage
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a request is made to the throttled prod stage then a method is deleted along with its integration
    Given mk in method_status
    Given a 200 method response has been configured
    Given a request has been made to the throttled prod stage
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 method response is configured then a backend integration is called then a backend integration is attached to a method
    Given mk in method_status
    Given a 200 method response has been configured
    Given a backend integration has been called
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a "REST" "API" is created with a root resource then a 200 integration response is configured
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given a "REST" "API" has been created with a root resource
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a root resource is initialized for an "API" then an "API" deployment is created
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given a root resource has been initialized for an "API"
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a "REST" "API" is deleted then a deployment is deleted when no stage references it
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given a "REST" "API" has been deleted
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a child resource is created under an existing resource then a prod stage is created for an "API"
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given a child resource has been created under an existing resource
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a non-root resource is deleted along with its methods and integrations then the prod stage is deleted
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given a non-root resource has been deleted along with its methods and integrations
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a "GET" method is created on a resource then the prod stage is redeployed to a new deployment
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given a "GET" method has been created on a resource
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then an existing method is updated then throttling is enabled for the prod stage
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given an existing method has been updated
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a method is deleted along with its integration then throttling is disabled for the prod stage
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given a method has been deleted along with its integration
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a 200 method response is configured then a request is made to the throttled prod stage
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given a 200 method response has been configured
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then an integration is deleted then a backend integration is called
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given an integration has been deleted
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a 200 integration response is configured then a "REST" "API" is created with a root resource
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given a 200 integration response has been configured
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then an "API" deployment is created then a root resource is initialized for an "API"
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given an "API" deployment has been created
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a deployment is deleted when no stage references it then a "REST" "API" is deleted
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given a deployment has been deleted when no stage references it
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a prod stage is created for an "API" then a child resource is created under an existing resource
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given a prod stage has been created for an "API"
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then the prod stage is deleted then a non-root resource is deleted along with its methods and integrations
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given the prod stage has been deleted
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then the prod stage is redeployed to a new deployment then a "GET" method is created on a resource
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given the prod stage has been redeployed to a new deployment
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then throttling is enabled for the prod stage then an existing method is updated
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given throttling has been enabled for the prod stage
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then throttling is disabled for the prod stage then a method is deleted along with its integration
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given throttling has been disabled for the prod stage
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a request is made to the throttled prod stage then a 200 method response is configured
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given a request has been made to the throttled prod stage
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is attached to a method then a backend integration is called then an integration is deleted
    Given mk in method_status
    Given a backend integration has been attached to a method
    Given a backend integration has been called
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a "REST" "API" is created with a root resource then an "API" deployment is created
    Given mk in integration_status
    Given an integration has been deleted
    Given a "REST" "API" has been created with a root resource
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a root resource is initialized for an "API" then a deployment is deleted when no stage references it
    Given mk in integration_status
    Given an integration has been deleted
    Given a root resource has been initialized for an "API"
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a "REST" "API" is deleted then a prod stage is created for an "API"
    Given mk in integration_status
    Given an integration has been deleted
    Given a "REST" "API" has been deleted
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a child resource is created under an existing resource then the prod stage is deleted
    Given mk in integration_status
    Given an integration has been deleted
    Given a child resource has been created under an existing resource
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a non-root resource is deleted along with its methods and integrations then the prod stage is redeployed to a new deployment
    Given mk in integration_status
    Given an integration has been deleted
    Given a non-root resource has been deleted along with its methods and integrations
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a "GET" method is created on a resource then throttling is enabled for the prod stage
    Given mk in integration_status
    Given an integration has been deleted
    Given a "GET" method has been created on a resource
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then an existing method is updated then throttling is disabled for the prod stage
    Given mk in integration_status
    Given an integration has been deleted
    Given an existing method has been updated
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a method is deleted along with its integration then a request is made to the throttled prod stage
    Given mk in integration_status
    Given an integration has been deleted
    Given a method has been deleted along with its integration
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a 200 method response is configured then a backend integration is called
    Given mk in integration_status
    Given an integration has been deleted
    Given a 200 method response has been configured
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a backend integration is attached to a method then a "REST" "API" is created with a root resource
    Given mk in integration_status
    Given an integration has been deleted
    Given a backend integration has been attached to a method
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a 200 integration response is configured then a root resource is initialized for an "API"
    Given mk in integration_status
    Given an integration has been deleted
    Given a 200 integration response has been configured
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then an "API" deployment is created then a "REST" "API" is deleted
    Given mk in integration_status
    Given an integration has been deleted
    Given an "API" deployment has been created
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a deployment is deleted when no stage references it then a child resource is created under an existing resource
    Given mk in integration_status
    Given an integration has been deleted
    Given a deployment has been deleted when no stage references it
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a prod stage is created for an "API" then a non-root resource is deleted along with its methods and integrations
    Given mk in integration_status
    Given an integration has been deleted
    Given a prod stage has been created for an "API"
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then the prod stage is deleted then a "GET" method is created on a resource
    Given mk in integration_status
    Given an integration has been deleted
    Given the prod stage has been deleted
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then the prod stage is redeployed to a new deployment then an existing method is updated
    Given mk in integration_status
    Given an integration has been deleted
    Given the prod stage has been redeployed to a new deployment
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then throttling is enabled for the prod stage then a method is deleted along with its integration
    Given mk in integration_status
    Given an integration has been deleted
    Given throttling has been enabled for the prod stage
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then throttling is disabled for the prod stage then a 200 method response is configured
    Given mk in integration_status
    Given an integration has been deleted
    Given throttling has been disabled for the prod stage
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a request is made to the throttled prod stage then a backend integration is attached to a method
    Given mk in integration_status
    Given an integration has been deleted
    Given a request has been made to the throttled prod stage
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an integration is deleted then a backend integration is called then a 200 integration response is configured
    Given mk in integration_status
    Given an integration has been deleted
    Given a backend integration has been called
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a "REST" "API" is created with a root resource then a deployment is deleted when no stage references it
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given a "REST" "API" has been created with a root resource
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a root resource is initialized for an "API" then a prod stage is created for an "API"
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given a root resource has been initialized for an "API"
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a "REST" "API" is deleted then the prod stage is deleted
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given a "REST" "API" has been deleted
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a child resource is created under an existing resource then the prod stage is redeployed to a new deployment
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given a child resource has been created under an existing resource
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a non-root resource is deleted along with its methods and integrations then throttling is enabled for the prod stage
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given a non-root resource has been deleted along with its methods and integrations
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a "GET" method is created on a resource then throttling is disabled for the prod stage
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given a "GET" method has been created on a resource
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then an existing method is updated then a request is made to the throttled prod stage
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given an existing method has been updated
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a method is deleted along with its integration then a backend integration is called
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given a method has been deleted along with its integration
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a 200 method response is configured then a "REST" "API" is created with a root resource
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given a 200 method response has been configured
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a backend integration is attached to a method then a root resource is initialized for an "API"
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given a backend integration has been attached to a method
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then an integration is deleted then a "REST" "API" is deleted
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given an integration has been deleted
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then an "API" deployment is created then a child resource is created under an existing resource
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given an "API" deployment has been created
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a deployment is deleted when no stage references it then a non-root resource is deleted along with its methods and integrations
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given a deployment has been deleted when no stage references it
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a prod stage is created for an "API" then a "GET" method is created on a resource
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given a prod stage has been created for an "API"
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then the prod stage is deleted then an existing method is updated
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given the prod stage has been deleted
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then the prod stage is redeployed to a new deployment then a method is deleted along with its integration
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given the prod stage has been redeployed to a new deployment
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then throttling is enabled for the prod stage then a 200 method response is configured
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given throttling has been enabled for the prod stage
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then throttling is disabled for the prod stage then a backend integration is attached to a method
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given throttling has been disabled for the prod stage
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a request is made to the throttled prod stage then an integration is deleted
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given a request has been made to the throttled prod stage
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a 200 integration response is configured then a backend integration is called then an "API" deployment is created
    Given mk in integration_status
    Given a 200 integration response has been configured
    Given a backend integration has been called
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a "REST" "API" is created with a root resource then a prod stage is created for an "API"
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a "REST" "API" has been created with a root resource
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a root resource is initialized for an "API" then the prod stage is deleted
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a root resource has been initialized for an "API"
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a "REST" "API" is deleted then the prod stage is redeployed to a new deployment
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a "REST" "API" has been deleted
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a child resource is created under an existing resource then throttling is enabled for the prod stage
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a child resource has been created under an existing resource
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a non-root resource is deleted along with its methods and integrations then throttling is disabled for the prod stage
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a non-root resource has been deleted along with its methods and integrations
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a "GET" method is created on a resource then a request is made to the throttled prod stage
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a "GET" method has been created on a resource
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then an existing method is updated then a backend integration is called
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given an existing method has been updated
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a method is deleted along with its integration then a "REST" "API" is created with a root resource
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a method has been deleted along with its integration
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a 200 method response is configured then a root resource is initialized for an "API"
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a 200 method response has been configured
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a backend integration is attached to a method then a "REST" "API" is deleted
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a backend integration has been attached to a method
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then an integration is deleted then a child resource is created under an existing resource
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given an integration has been deleted
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a 200 integration response is configured then a non-root resource is deleted along with its methods and integrations
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a 200 integration response has been configured
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a deployment is deleted when no stage references it then a "GET" method is created on a resource
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a deployment has been deleted when no stage references it
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a prod stage is created for an "API" then an existing method is updated
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a prod stage has been created for an "API"
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then the prod stage is deleted then a method is deleted along with its integration
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given the prod stage has been deleted
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then the prod stage is redeployed to a new deployment then a 200 method response is configured
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given the prod stage has been redeployed to a new deployment
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then throttling is enabled for the prod stage then a backend integration is attached to a method
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given throttling has been enabled for the prod stage
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then throttling is disabled for the prod stage then an integration is deleted
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given throttling has been disabled for the prod stage
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a request is made to the throttled prod stage then a 200 integration response is configured
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a request has been made to the throttled prod stage
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: an "API" deployment is created then a backend integration is called then a deployment is deleted when no stage references it
    Given did not in deployment_status
    Given an "API" deployment has been created
    Given a backend integration has been called
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a "REST" "API" is created with a root resource then the prod stage is deleted
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given a "REST" "API" has been created with a root resource
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a root resource is initialized for an "API" then the prod stage is redeployed to a new deployment
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given a root resource has been initialized for an "API"
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a "REST" "API" is deleted then throttling is enabled for the prod stage
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given a "REST" "API" has been deleted
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a child resource is created under an existing resource then throttling is disabled for the prod stage
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given a child resource has been created under an existing resource
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a non-root resource is deleted along with its methods and integrations then a request is made to the throttled prod stage
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given a non-root resource has been deleted along with its methods and integrations
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a "GET" method is created on a resource then a backend integration is called
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given a "GET" method has been created on a resource
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then an existing method is updated then a "REST" "API" is created with a root resource
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given an existing method has been updated
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a method is deleted along with its integration then a root resource is initialized for an "API"
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given a method has been deleted along with its integration
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a 200 method response is configured then a "REST" "API" is deleted
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given a 200 method response has been configured
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a backend integration is attached to a method then a child resource is created under an existing resource
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given a backend integration has been attached to a method
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then an integration is deleted then a non-root resource is deleted along with its methods and integrations
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given an integration has been deleted
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a 200 integration response is configured then a "GET" method is created on a resource
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given a 200 integration response has been configured
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then an "API" deployment is created then an existing method is updated
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given an "API" deployment has been created
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a prod stage is created for an "API" then a method is deleted along with its integration
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given a prod stage has been created for an "API"
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then the prod stage is deleted then a 200 method response is configured
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given the prod stage has been deleted
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then the prod stage is redeployed to a new deployment then a backend integration is attached to a method
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given the prod stage has been redeployed to a new deployment
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then throttling is enabled for the prod stage then an integration is deleted
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given throttling has been enabled for the prod stage
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then throttling is disabled for the prod stage then a 200 integration response is configured
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given throttling has been disabled for the prod stage
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a request is made to the throttled prod stage then an "API" deployment is created
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given a request has been made to the throttled prod stage
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a deployment is deleted when no stage references it then a backend integration is called then a prod stage is created for an "API"
    Given did in deployment_status
    Given a deployment has been deleted when no stage references it
    Given a backend integration has been called
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a "REST" "API" is created with a root resource then the prod stage is redeployed to a new deployment
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given a "REST" "API" has been created with a root resource
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a root resource is initialized for an "API" then throttling is enabled for the prod stage
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given a root resource has been initialized for an "API"
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a "REST" "API" is deleted then throttling is disabled for the prod stage
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given a "REST" "API" has been deleted
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a child resource is created under an existing resource then a request is made to the throttled prod stage
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given a child resource has been created under an existing resource
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a non-root resource is deleted along with its methods and integrations then a backend integration is called
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given a non-root resource has been deleted along with its methods and integrations
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a "GET" method is created on a resource then a "REST" "API" is created with a root resource
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given a "GET" method has been created on a resource
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then an existing method is updated then a root resource is initialized for an "API"
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given an existing method has been updated
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a method is deleted along with its integration then a "REST" "API" is deleted
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given a method has been deleted along with its integration
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a 200 method response is configured then a child resource is created under an existing resource
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given a 200 method response has been configured
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a backend integration is attached to a method then a non-root resource is deleted along with its methods and integrations
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given a backend integration has been attached to a method
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then an integration is deleted then a "GET" method is created on a resource
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given an integration has been deleted
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a 200 integration response is configured then an existing method is updated
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given a 200 integration response has been configured
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then an "API" deployment is created then a method is deleted along with its integration
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given an "API" deployment has been created
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a deployment is deleted when no stage references it then a 200 method response is configured
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given a deployment has been deleted when no stage references it
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then the prod stage is deleted then a backend integration is attached to a method
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given the prod stage has been deleted
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then the prod stage is redeployed to a new deployment then an integration is deleted
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given the prod stage has been redeployed to a new deployment
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then throttling is enabled for the prod stage then a 200 integration response is configured
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given throttling has been enabled for the prod stage
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then throttling is disabled for the prod stage then an "API" deployment is created
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given throttling has been disabled for the prod stage
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a request is made to the throttled prod stage then a deployment is deleted when no stage references it
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given a request has been made to the throttled prod stage
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a prod stage is created for an "API" then a backend integration is called then the prod stage is deleted
    Given did in deployment_status
    Given a prod stage has been created for an "API"
    Given a backend integration has been called
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a "REST" "API" is created with a root resource then throttling is enabled for the prod stage
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a "REST" "API" has been created with a root resource
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a root resource is initialized for an "API" then throttling is disabled for the prod stage
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a root resource has been initialized for an "API"
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a "REST" "API" is deleted then a request is made to the throttled prod stage
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a "REST" "API" has been deleted
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a child resource is created under an existing resource then a backend integration is called
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a child resource has been created under an existing resource
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a non-root resource is deleted along with its methods and integrations then a "REST" "API" is created with a root resource
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a non-root resource has been deleted along with its methods and integrations
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a "GET" method is created on a resource then a root resource is initialized for an "API"
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a "GET" method has been created on a resource
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then an existing method is updated then a "REST" "API" is deleted
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given an existing method has been updated
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a method is deleted along with its integration then a child resource is created under an existing resource
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a method has been deleted along with its integration
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a 200 method response is configured then a non-root resource is deleted along with its methods and integrations
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a 200 method response has been configured
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a backend integration is attached to a method then a "GET" method is created on a resource
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a backend integration has been attached to a method
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then an integration is deleted then an existing method is updated
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given an integration has been deleted
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a 200 integration response is configured then a method is deleted along with its integration
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a 200 integration response has been configured
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then an "API" deployment is created then a 200 method response is configured
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given an "API" deployment has been created
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a deployment is deleted when no stage references it then a backend integration is attached to a method
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a deployment has been deleted when no stage references it
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a prod stage is created for an "API" then an integration is deleted
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a prod stage has been created for an "API"
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then the prod stage is redeployed to a new deployment then a 200 integration response is configured
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given the prod stage has been redeployed to a new deployment
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then throttling is enabled for the prod stage then an "API" deployment is created
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given throttling has been enabled for the prod stage
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then throttling is disabled for the prod stage then a deployment is deleted when no stage references it
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given throttling has been disabled for the prod stage
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a request is made to the throttled prod stage then a prod stage is created for an "API"
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a request has been made to the throttled prod stage
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is deleted then a backend integration is called then the prod stage is redeployed to a new deployment
    Given sk in stage_exists
    Given the prod stage has been deleted
    Given a backend integration has been called
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a "REST" "API" is created with a root resource then throttling is disabled for the prod stage
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a "REST" "API" has been created with a root resource
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a root resource is initialized for an "API" then a request is made to the throttled prod stage
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a root resource has been initialized for an "API"
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a "REST" "API" is deleted then a backend integration is called
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a "REST" "API" has been deleted
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a child resource is created under an existing resource then a "REST" "API" is created with a root resource
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a child resource has been created under an existing resource
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a non-root resource is deleted along with its methods and integrations then a root resource is initialized for an "API"
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a non-root resource has been deleted along with its methods and integrations
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a "GET" method is created on a resource then a "REST" "API" is deleted
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a "GET" method has been created on a resource
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then an existing method is updated then a child resource is created under an existing resource
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given an existing method has been updated
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a method is deleted along with its integration then a non-root resource is deleted along with its methods and integrations
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a method has been deleted along with its integration
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a 200 method response is configured then a "GET" method is created on a resource
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a 200 method response has been configured
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a backend integration is attached to a method then an existing method is updated
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a backend integration has been attached to a method
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then an integration is deleted then a method is deleted along with its integration
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given an integration has been deleted
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a 200 integration response is configured then a 200 method response is configured
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a 200 integration response has been configured
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then an "API" deployment is created then a backend integration is attached to a method
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given an "API" deployment has been created
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a deployment is deleted when no stage references it then an integration is deleted
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a deployment has been deleted when no stage references it
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a prod stage is created for an "API" then a 200 integration response is configured
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a prod stage has been created for an "API"
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then the prod stage is deleted then an "API" deployment is created
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given the prod stage has been deleted
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then throttling is enabled for the prod stage then a deployment is deleted when no stage references it
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given throttling has been enabled for the prod stage
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then throttling is disabled for the prod stage then a prod stage is created for an "API"
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given throttling has been disabled for the prod stage
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a request is made to the throttled prod stage then the prod stage is deleted
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a request has been made to the throttled prod stage
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: the prod stage is redeployed to a new deployment then a backend integration is called then throttling is enabled for the prod stage
    Given did in deployment_status
    Given the prod stage has been redeployed to a new deployment
    Given a backend integration has been called
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a "REST" "API" is created with a root resource then a request is made to the throttled prod stage
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a "REST" "API" has been created with a root resource
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a root resource is initialized for an "API" then a backend integration is called
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a root resource has been initialized for an "API"
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a "REST" "API" is deleted then a "REST" "API" is created with a root resource
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a "REST" "API" has been deleted
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a child resource is created under an existing resource then a root resource is initialized for an "API"
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a child resource has been created under an existing resource
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a non-root resource is deleted along with its methods and integrations then a "REST" "API" is deleted
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a non-root resource has been deleted along with its methods and integrations
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a "GET" method is created on a resource then a child resource is created under an existing resource
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a "GET" method has been created on a resource
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then an existing method is updated then a non-root resource is deleted along with its methods and integrations
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given an existing method has been updated
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a method is deleted along with its integration then a "GET" method is created on a resource
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a method has been deleted along with its integration
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a 200 method response is configured then an existing method is updated
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a 200 method response has been configured
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a backend integration is attached to a method then a method is deleted along with its integration
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a backend integration has been attached to a method
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then an integration is deleted then a 200 method response is configured
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given an integration has been deleted
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a 200 integration response is configured then a backend integration is attached to a method
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a 200 integration response has been configured
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then an "API" deployment is created then an integration is deleted
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given an "API" deployment has been created
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a deployment is deleted when no stage references it then a 200 integration response is configured
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a deployment has been deleted when no stage references it
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a prod stage is created for an "API" then an "API" deployment is created
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a prod stage has been created for an "API"
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then the prod stage is deleted then a deployment is deleted when no stage references it
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given the prod stage has been deleted
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then the prod stage is redeployed to a new deployment then a prod stage is created for an "API"
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given the prod stage has been redeployed to a new deployment
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then throttling is disabled for the prod stage then the prod stage is deleted
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given throttling has been disabled for the prod stage
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a request is made to the throttled prod stage then the prod stage is redeployed to a new deployment
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a request has been made to the throttled prod stage
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is enabled for the prod stage then a backend integration is called then throttling is disabled for the prod stage
    Given sk in stage_exists
    Given throttling has been enabled for the prod stage
    Given a backend integration has been called
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a "REST" "API" is created with a root resource then a backend integration is called
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a "REST" "API" has been created with a root resource
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a root resource is initialized for an "API" then a "REST" "API" is created with a root resource
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a root resource has been initialized for an "API"
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a "REST" "API" is deleted then a root resource is initialized for an "API"
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a "REST" "API" has been deleted
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a child resource is created under an existing resource then a "REST" "API" is deleted
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a child resource has been created under an existing resource
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a non-root resource is deleted along with its methods and integrations then a child resource is created under an existing resource
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a non-root resource has been deleted along with its methods and integrations
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a "GET" method is created on a resource then a non-root resource is deleted along with its methods and integrations
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a "GET" method has been created on a resource
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then an existing method is updated then a "GET" method is created on a resource
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given an existing method has been updated
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a method is deleted along with its integration then an existing method is updated
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a method has been deleted along with its integration
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a 200 method response is configured then a method is deleted along with its integration
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a 200 method response has been configured
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a backend integration is attached to a method then a 200 method response is configured
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a backend integration has been attached to a method
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then an integration is deleted then a backend integration is attached to a method
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given an integration has been deleted
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a 200 integration response is configured then an integration is deleted
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a 200 integration response has been configured
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then an "API" deployment is created then a 200 integration response is configured
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given an "API" deployment has been created
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a deployment is deleted when no stage references it then an "API" deployment is created
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a deployment has been deleted when no stage references it
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a prod stage is created for an "API" then a deployment is deleted when no stage references it
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a prod stage has been created for an "API"
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then the prod stage is deleted then a prod stage is created for an "API"
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given the prod stage has been deleted
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then the prod stage is redeployed to a new deployment then the prod stage is deleted
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given the prod stage has been redeployed to a new deployment
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then throttling is enabled for the prod stage then the prod stage is redeployed to a new deployment
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given throttling has been enabled for the prod stage
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a request is made to the throttled prod stage then throttling is enabled for the prod stage
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a request has been made to the throttled prod stage
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: throttling is disabled for the prod stage then a backend integration is called then a request is made to the throttled prod stage
    Given sk in stage_exists
    Given throttling has been disabled for the prod stage
    Given a backend integration has been called
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a "REST" "API" is created with a root resource then a root resource is initialized for an "API"
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given a "REST" "API" has been created with a root resource
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a root resource is initialized for an "API" then a "REST" "API" is deleted
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given a root resource has been initialized for an "API"
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a "REST" "API" is deleted then a child resource is created under an existing resource
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given a "REST" "API" has been deleted
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a child resource is created under an existing resource then a non-root resource is deleted along with its methods and integrations
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given a child resource has been created under an existing resource
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a non-root resource is deleted along with its methods and integrations then a "GET" method is created on a resource
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given a non-root resource has been deleted along with its methods and integrations
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a "GET" method is created on a resource then an existing method is updated
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given a "GET" method has been created on a resource
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then an existing method is updated then a method is deleted along with its integration
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given an existing method has been updated
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a method is deleted along with its integration then a 200 method response is configured
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given a method has been deleted along with its integration
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a 200 method response is configured then a backend integration is attached to a method
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given a 200 method response has been configured
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a backend integration is attached to a method then an integration is deleted
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given a backend integration has been attached to a method
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then an integration is deleted then a 200 integration response is configured
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given an integration has been deleted
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a 200 integration response is configured then an "API" deployment is created
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given a 200 integration response has been configured
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then an "API" deployment is created then a deployment is deleted when no stage references it
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given an "API" deployment has been created
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a deployment is deleted when no stage references it then a prod stage is created for an "API"
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given a deployment has been deleted when no stage references it
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a prod stage is created for an "API" then the prod stage is deleted
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given a prod stage has been created for an "API"
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then the prod stage is deleted then the prod stage is redeployed to a new deployment
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given the prod stage has been deleted
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then the prod stage is redeployed to a new deployment then throttling is enabled for the prod stage
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given the prod stage has been redeployed to a new deployment
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then throttling is enabled for the prod stage then throttling is disabled for the prod stage
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given throttling has been enabled for the prod stage
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then throttling is disabled for the prod stage then a backend integration is called
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given throttling has been disabled for the prod stage
    When a backend integration is called
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a request is made to the throttled prod stage then a backend integration is called then a "REST" "API" is created with a root resource
    Given sk in stage_throttling
    Given a request has been made to the throttled prod stage
    Given a backend integration has been called
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a "REST" "API" is created with a root resource then a "REST" "API" is deleted
    Given mk in integration_status
    Given a backend integration has been called
    Given a "REST" "API" has been created with a root resource
    When a "REST" "API" is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a root resource is initialized for an "API" then a child resource is created under an existing resource
    Given mk in integration_status
    Given a backend integration has been called
    Given a root resource has been initialized for an "API"
    When a child resource is created under an existing resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a "REST" "API" is deleted then a non-root resource is deleted along with its methods and integrations
    Given mk in integration_status
    Given a backend integration has been called
    Given a "REST" "API" has been deleted
    When a non-root resource is deleted along with its methods and integrations
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a child resource is created under an existing resource then a "GET" method is created on a resource
    Given mk in integration_status
    Given a backend integration has been called
    Given a child resource has been created under an existing resource
    When a "GET" method is created on a resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a non-root resource is deleted along with its methods and integrations then an existing method is updated
    Given mk in integration_status
    Given a backend integration has been called
    Given a non-root resource has been deleted along with its methods and integrations
    When an existing method is updated
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a "GET" method is created on a resource then a method is deleted along with its integration
    Given mk in integration_status
    Given a backend integration has been called
    Given a "GET" method has been created on a resource
    When a method is deleted along with its integration
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then an existing method is updated then a 200 method response is configured
    Given mk in integration_status
    Given a backend integration has been called
    Given an existing method has been updated
    When a 200 method response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a method is deleted along with its integration then a backend integration is attached to a method
    Given mk in integration_status
    Given a backend integration has been called
    Given a method has been deleted along with its integration
    When a backend integration is attached to a method
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a 200 method response is configured then an integration is deleted
    Given mk in integration_status
    Given a backend integration has been called
    Given a 200 method response has been configured
    When an integration is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a backend integration is attached to a method then a 200 integration response is configured
    Given mk in integration_status
    Given a backend integration has been called
    Given a backend integration has been attached to a method
    When a 200 integration response is configured
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then an integration is deleted then an "API" deployment is created
    Given mk in integration_status
    Given a backend integration has been called
    Given an integration has been deleted
    When an "API" deployment is created
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a 200 integration response is configured then a deployment is deleted when no stage references it
    Given mk in integration_status
    Given a backend integration has been called
    Given a 200 integration response has been configured
    When a deployment is deleted when no stage references it
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then an "API" deployment is created then a prod stage is created for an "API"
    Given mk in integration_status
    Given a backend integration has been called
    Given an "API" deployment has been created
    When a prod stage is created for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a deployment is deleted when no stage references it then the prod stage is deleted
    Given mk in integration_status
    Given a backend integration has been called
    Given a deployment has been deleted when no stage references it
    When the prod stage is deleted
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a prod stage is created for an "API" then the prod stage is redeployed to a new deployment
    Given mk in integration_status
    Given a backend integration has been called
    Given a prod stage has been created for an "API"
    When the prod stage is redeployed to a new deployment
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then the prod stage is deleted then throttling is enabled for the prod stage
    Given mk in integration_status
    Given a backend integration has been called
    Given the prod stage has been deleted
    When throttling is enabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then the prod stage is redeployed to a new deployment then throttling is disabled for the prod stage
    Given mk in integration_status
    Given a backend integration has been called
    Given the prod stage has been redeployed to a new deployment
    When throttling is disabled for the prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then throttling is enabled for the prod stage then a request is made to the throttled prod stage
    Given mk in integration_status
    Given a backend integration has been called
    Given throttling has been enabled for the prod stage
    When a request is made to the throttled prod stage
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then throttling is disabled for the prod stage then a "REST" "API" is created with a root resource
    Given mk in integration_status
    Given a backend integration has been called
    Given throttling has been disabled for the prod stage
    When a "REST" "API" is created with a root resource
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource

  @exhaustive @sequence
  Scenario: a backend integration is called then a request is made to the throttled prod stage then a root resource is initialized for an "API"
    Given mk in integration_status
    Given a backend integration has been called
    Given a request has been made to the throttled prod stage
    When a root resource is initialized for an "API"
    Then all "ACTIVE" resources belong to "ACTIVE" APIs
    And all "EXISTING" methods belong to "ACTIVE" resources
    And all "EXISTING" integrations correspond to "EXISTING" methods
    And all "ACTIVE" deployments belong to "ACTIVE" APIs
    And all active stages reference "ACTIVE" deployments
    And all active stages belong to "ACTIVE" APIs
    And each "ACTIVE" "API" has at least one "ACTIVE" root resource
