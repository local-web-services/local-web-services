@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - Action Sequences

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Step Functions Express Workflow state machine is created
    Given aid not in api_status
    When a "REST" "API" is created
    When a Step Functions Express Workflow state machine is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Step Functions direct integration is configured on the "REST" "API"
    Given aid not in api_status
    When a "REST" "API" is created
    When a Step Functions direct integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given aid not in api_status
    When a "REST" "API" is created
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Step Functions execution completes successfully and the "API" returns a successful response
    Given aid not in api_status
    When a "REST" "API" is created
    When the Step Functions execution completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Step Functions execution fails and the "API" returns an error response
    Given aid not in api_status
    When a "REST" "API" is created
    When the Step Functions execution fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions Express Workflow state machine is created then a "REST" "API" is created
    Given smid not in sm_status
    When a Step Functions Express Workflow state machine is created
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions Express Workflow state machine is created then a Step Functions direct integration is configured on the "REST" "API"
    Given smid not in sm_status
    When a Step Functions Express Workflow state machine is created
    When a Step Functions direct integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions Express Workflow state machine is created then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given smid not in sm_status
    When a Step Functions Express Workflow state machine is created
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions Express Workflow state machine is created then the Step Functions execution completes successfully and the "API" returns a successful response
    Given smid not in sm_status
    When a Step Functions Express Workflow state machine is created
    When the Step Functions execution completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions Express Workflow state machine is created then the Step Functions execution fails and the "API" returns an error response
    Given smid not in sm_status
    When a Step Functions Express Workflow state machine is created
    When the Step Functions execution fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then a "REST" "API" is created
    Given aid in api_status
    When a Step Functions direct integration is configured on the "REST" "API"
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then a Step Functions Express Workflow state machine is created
    Given aid in api_status
    When a Step Functions direct integration is configured on the "REST" "API"
    When a Step Functions Express Workflow state machine is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given aid in api_status
    When a Step Functions direct integration is configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then the Step Functions execution completes successfully and the "API" returns a successful response
    Given aid in api_status
    When a Step Functions direct integration is configured on the "REST" "API"
    When the Step Functions execution completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then the Step Functions execution fails and the "API" returns an error response
    Given aid in api_status
    When a Step Functions direct integration is configured on the "REST" "API"
    When the Step Functions execution fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a "REST" "API" is created
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a Step Functions Express Workflow state machine is created
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When a Step Functions Express Workflow state machine is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a Step Functions direct integration is configured on the "REST" "API"
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When a Step Functions direct integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution completes successfully and the "API" returns a successful response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution fails and the "API" returns an error response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then a "REST" "API" is created
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions Express Workflow state machine is created
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When a Step Functions Express Workflow state machine is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions direct integration is configured on the "REST" "API"
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When a Step Functions direct integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then the Step Functions execution fails and the "API" returns an error response
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When the Step Functions execution fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then a "REST" "API" is created
    Given eid in exec_status
    When the Step Functions execution fails and the "API" returns an error response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then a Step Functions Express Workflow state machine is created
    Given eid in exec_status
    When the Step Functions execution fails and the "API" returns an error response
    When a Step Functions Express Workflow state machine is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then a Step Functions direct integration is configured on the "REST" "API"
    Given eid in exec_status
    When the Step Functions execution fails and the "API" returns an error response
    When a Step Functions direct integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given eid in exec_status
    When the Step Functions execution fails and the "API" returns an error response
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then the Step Functions execution completes successfully and the "API" returns a successful response
    Given eid in exec_status
    When the Step Functions execution fails and the "API" returns an error response
    When the Step Functions execution completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Step Functions Express Workflow state machine is created then a Step Functions direct integration is configured on the "REST" "API"
    Given aid not in api_status
    When a "REST" "API" is created
    When a Step Functions Express Workflow state machine is created
    When a Step Functions direct integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Step Functions direct integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given aid not in api_status
    When a "REST" "API" is created
    When a Step Functions direct integration is configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution completes successfully and the "API" returns a successful response
    Given aid not in api_status
    When a "REST" "API" is created
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Step Functions execution completes successfully and the "API" returns a successful response then the Step Functions execution fails and the "API" returns an error response
    Given aid not in api_status
    When a "REST" "API" is created
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When the Step Functions execution fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Step Functions execution fails and the "API" returns an error response then a Step Functions Express Workflow state machine is created
    Given aid not in api_status
    When a "REST" "API" is created
    When the Step Functions execution fails and the "API" returns an error response
    When a Step Functions Express Workflow state machine is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions Express Workflow state machine is created then a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given smid not in sm_status
    When a Step Functions Express Workflow state machine is created
    When a "REST" "API" is created
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions Express Workflow state machine is created then a Step Functions direct integration is configured on the "REST" "API" then the Step Functions execution completes successfully and the "API" returns a successful response
    Given smid not in sm_status
    When a Step Functions Express Workflow state machine is created
    When a Step Functions direct integration is configured on the "REST" "API"
    When the Step Functions execution completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions Express Workflow state machine is created then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution fails and the "API" returns an error response
    Given smid not in sm_status
    When a Step Functions Express Workflow state machine is created
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions Express Workflow state machine is created then the Step Functions execution completes successfully and the "API" returns a successful response then a "REST" "API" is created
    Given smid not in sm_status
    When a Step Functions Express Workflow state machine is created
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions Express Workflow state machine is created then the Step Functions execution fails and the "API" returns an error response then a Step Functions direct integration is configured on the "REST" "API"
    Given smid not in sm_status
    When a Step Functions Express Workflow state machine is created
    When the Step Functions execution fails and the "API" returns an error response
    When a Step Functions direct integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then a "REST" "API" is created then the Step Functions execution completes successfully and the "API" returns a successful response
    Given aid in api_status
    When a Step Functions direct integration is configured on the "REST" "API"
    When a "REST" "API" is created
    When the Step Functions execution completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then a Step Functions Express Workflow state machine is created then the Step Functions execution fails and the "API" returns an error response
    Given aid in api_status
    When a Step Functions direct integration is configured on the "REST" "API"
    When a Step Functions Express Workflow state machine is created
    When the Step Functions execution fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a "REST" "API" is created
    Given aid in api_status
    When a Step Functions direct integration is configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions Express Workflow state machine is created
    Given aid in api_status
    When a Step Functions direct integration is configured on the "REST" "API"
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When a Step Functions Express Workflow state machine is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then the Step Functions execution fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given aid in api_status
    When a Step Functions direct integration is configured on the "REST" "API"
    When the Step Functions execution fails and the "API" returns an error response
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a "REST" "API" is created then the Step Functions execution fails and the "API" returns an error response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When a "REST" "API" is created
    When the Step Functions execution fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a Step Functions Express Workflow state machine is created then a "REST" "API" is created
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When a Step Functions Express Workflow state machine is created
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a Step Functions direct integration is configured on the "REST" "API" then a Step Functions Express Workflow state machine is created
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When a Step Functions direct integration is configured on the "REST" "API"
    When a Step Functions Express Workflow state machine is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions direct integration is configured on the "REST" "API"
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When a Step Functions direct integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution fails and the "API" returns an error response then the Step Functions execution completes successfully and the "API" returns a successful response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution fails and the "API" returns an error response
    When the Step Functions execution completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then a "REST" "API" is created then a Step Functions Express Workflow state machine is created
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When a "REST" "API" is created
    When a Step Functions Express Workflow state machine is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions Express Workflow state machine is created then a Step Functions direct integration is configured on the "REST" "API"
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When a Step Functions Express Workflow state machine is created
    When a Step Functions direct integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions direct integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When a Step Functions direct integration is configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution fails and the "API" returns an error response
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then the Step Functions execution fails and the "API" returns an error response then a "REST" "API" is created
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When the Step Functions execution fails and the "API" returns an error response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then a "REST" "API" is created then a Step Functions direct integration is configured on the "REST" "API"
    Given eid in exec_status
    When the Step Functions execution fails and the "API" returns an error response
    When a "REST" "API" is created
    When a Step Functions direct integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then a Step Functions Express Workflow state machine is created then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given eid in exec_status
    When the Step Functions execution fails and the "API" returns an error response
    When a Step Functions Express Workflow state machine is created
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then a Step Functions direct integration is configured on the "REST" "API" then the Step Functions execution completes successfully and the "API" returns a successful response
    Given eid in exec_status
    When the Step Functions execution fails and the "API" returns an error response
    When a Step Functions direct integration is configured on the "REST" "API"
    When the Step Functions execution completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a "REST" "API" is created
    Given eid in exec_status
    When the Step Functions execution fails and the "API" returns an error response
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions Express Workflow state machine is created
    Given eid in exec_status
    When the Step Functions execution fails and the "API" returns an error response
    When the Step Functions execution completes successfully and the "API" returns a successful response
    When a Step Functions Express Workflow state machine is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request
