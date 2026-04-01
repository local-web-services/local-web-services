@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - Action Sequences

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "api gateway" "api" is created then a "step functions" "Express Workflow state machine" is created
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "step functions" "Express Workflow state machine" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then a Step Functions direct integration is configured on the "api gateway" "api"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a Step Functions direct integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then the Step Functions execution fails and the "api gateway" "API" returns an error response
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "step functions" "Express Workflow state machine" is created then an "api gateway" "api" is created
    Given smid not in sm_status
    When a "step functions" "Express Workflow state machine" is created
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "step functions" "Express Workflow state machine" is created then a Step Functions direct integration is configured on the "api gateway" "api"
    Given smid not in sm_status
    When a "step functions" "Express Workflow state machine" is created
    When a Step Functions direct integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "step functions" "Express Workflow state machine" is created then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Given smid not in sm_status
    When a "step functions" "Express Workflow state machine" is created
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "step functions" "Express Workflow state machine" is created then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Given smid not in sm_status
    When a "step functions" "Express Workflow state machine" is created
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "step functions" "Express Workflow state machine" is created then the Step Functions execution fails and the "api gateway" "API" returns an error response
    Given smid not in sm_status
    When a "step functions" "Express Workflow state machine" is created
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" then an "api gateway" "api" is created
    Given aid in api_status
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" then a "step functions" "Express Workflow state machine" is created
    Given aid in api_status
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When a "step functions" "Express Workflow state machine" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Given aid in api_status
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Given aid in api_status
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" then the Step Functions execution fails and the "api gateway" "API" returns an error response
    Given aid in api_status
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then an "api gateway" "api" is created
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then a "step functions" "Express Workflow state machine" is created
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When a "step functions" "Express Workflow state machine" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then a Step Functions direct integration is configured on the "api gateway" "api"
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When a Step Functions direct integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution fails and the "api gateway" "API" returns an error response
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then an "api gateway" "api" is created
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then a "step functions" "Express Workflow state machine" is created
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When a "step functions" "Express Workflow state machine" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then a Step Functions direct integration is configured on the "api gateway" "api"
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When a Step Functions direct integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then the Step Functions execution fails and the "api gateway" "API" returns an error response
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution fails and the "api gateway" "API" returns an error response then an "api gateway" "api" is created
    Given eid in exec_status
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution fails and the "api gateway" "API" returns an error response then a "step functions" "Express Workflow state machine" is created
    Given eid in exec_status
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When a "step functions" "Express Workflow state machine" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution fails and the "api gateway" "API" returns an error response then a Step Functions direct integration is configured on the "api gateway" "api"
    Given eid in exec_status
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When a Step Functions direct integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution fails and the "api gateway" "API" returns an error response then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Given eid in exec_status
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution fails and the "api gateway" "API" returns an error response then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Given eid in exec_status
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then a "step functions" "Express Workflow state machine" is created then a Step Functions direct integration is configured on the "api gateway" "api"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "step functions" "Express Workflow state machine" is created
    When a Step Functions direct integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then a Step Functions direct integration is configured on the "api gateway" "api" then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then the Step Functions execution fails and the "api gateway" "API" returns an error response
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then the Step Functions execution fails and the "api gateway" "API" returns an error response then a "step functions" "Express Workflow state machine" is created
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When a "step functions" "Express Workflow state machine" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "step functions" "Express Workflow state machine" is created then an "api gateway" "api" is created then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Given smid not in sm_status
    When a "step functions" "Express Workflow state machine" is created
    When an "api gateway" "api" is created
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "step functions" "Express Workflow state machine" is created then a Step Functions direct integration is configured on the "api gateway" "api" then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Given smid not in sm_status
    When a "step functions" "Express Workflow state machine" is created
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "step functions" "Express Workflow state machine" is created then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution fails and the "api gateway" "API" returns an error response
    Given smid not in sm_status
    When a "step functions" "Express Workflow state machine" is created
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "step functions" "Express Workflow state machine" is created then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then an "api gateway" "api" is created
    Given smid not in sm_status
    When a "step functions" "Express Workflow state machine" is created
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "step functions" "Express Workflow state machine" is created then the Step Functions execution fails and the "api gateway" "API" returns an error response then a Step Functions direct integration is configured on the "api gateway" "api"
    Given smid not in sm_status
    When a "step functions" "Express Workflow state machine" is created
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When a Step Functions direct integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" then an "api gateway" "api" is created then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Given aid in api_status
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When an "api gateway" "api" is created
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" then a "step functions" "Express Workflow state machine" is created then the Step Functions execution fails and the "api gateway" "API" returns an error response
    Given aid in api_status
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When a "step functions" "Express Workflow state machine" is created
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then an "api gateway" "api" is created
    Given aid in api_status
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then a "step functions" "Express Workflow state machine" is created
    Given aid in api_status
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When a "step functions" "Express Workflow state machine" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" then the Step Functions execution fails and the "api gateway" "API" returns an error response then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Given aid in api_status
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then an "api gateway" "api" is created then the Step Functions execution fails and the "api gateway" "API" returns an error response
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When an "api gateway" "api" is created
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then a "step functions" "Express Workflow state machine" is created then an "api gateway" "api" is created
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When a "step functions" "Express Workflow state machine" is created
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then a Step Functions direct integration is configured on the "api gateway" "api" then a "step functions" "Express Workflow state machine" is created
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When a "step functions" "Express Workflow state machine" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then a Step Functions direct integration is configured on the "api gateway" "api"
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When a Step Functions direct integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution fails and the "api gateway" "API" returns an error response then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then an "api gateway" "api" is created then a "step functions" "Express Workflow state machine" is created
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When an "api gateway" "api" is created
    When a "step functions" "Express Workflow state machine" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then a "step functions" "Express Workflow state machine" is created then a Step Functions direct integration is configured on the "api gateway" "api"
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When a "step functions" "Express Workflow state machine" is created
    When a Step Functions direct integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then a Step Functions direct integration is configured on the "api gateway" "api" then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution fails and the "api gateway" "API" returns an error response
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then the Step Functions execution fails and the "api gateway" "API" returns an error response then an "api gateway" "api" is created
    Given eid in exec_status
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution fails and the "api gateway" "API" returns an error response then an "api gateway" "api" is created then a Step Functions direct integration is configured on the "api gateway" "api"
    Given eid in exec_status
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When an "api gateway" "api" is created
    When a Step Functions direct integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution fails and the "api gateway" "API" returns an error response then a "step functions" "Express Workflow state machine" is created then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    Given eid in exec_status
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When a "step functions" "Express Workflow state machine" is created
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution fails and the "api gateway" "API" returns an error response then a Step Functions direct integration is configured on the "api gateway" "api" then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Given eid in exec_status
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When a Step Functions direct integration is configured on the "api gateway" "api"
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution fails and the "api gateway" "API" returns an error response then the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution then an "api gateway" "api" is created
    Given eid in exec_status
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the Step Functions execution fails and the "api gateway" "API" returns an error response then the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response then a "step functions" "Express Workflow state machine" is created
    Given eid in exec_status
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    When a "step functions" "Express Workflow state machine" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"
