@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - Action Sequences

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "REST" "API" is created then a Step Functions Express Workflow state machine is created
    Given aid not in api_status
    Given a "REST" "API" has been created
    When a Step Functions Express Workflow state machine is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a "REST" "API" is created then a Step Functions direct integration is configured on the "REST" "API"
    Given aid not in api_status
    Given a "REST" "API" has been created
    When a Step Functions direct integration is configured on the "REST" "API"
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given aid not in api_status
    Given a "REST" "API" has been created
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a "REST" "API" is created then the Step Functions execution completes successfully and the "API" returns a successful response
    Given aid not in api_status
    Given a "REST" "API" has been created
    When the Step Functions execution completes successfully and the "API" returns a successful response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a "REST" "API" is created then the Step Functions execution fails and the "API" returns an error response
    Given aid not in api_status
    Given a "REST" "API" has been created
    When the Step Functions execution fails and the "API" returns an error response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions Express Workflow state machine is created then a "REST" "API" is created
    Given smid not in sm_status
    Given a Step Functions Express Workflow state machine has been created
    When a "REST" "API" is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions Express Workflow state machine is created then a Step Functions direct integration is configured on the "REST" "API"
    Given smid not in sm_status
    Given a Step Functions Express Workflow state machine has been created
    When a Step Functions direct integration is configured on the "REST" "API"
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions Express Workflow state machine is created then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given smid not in sm_status
    Given a Step Functions Express Workflow state machine has been created
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions Express Workflow state machine is created then the Step Functions execution completes successfully and the "API" returns a successful response
    Given smid not in sm_status
    Given a Step Functions Express Workflow state machine has been created
    When the Step Functions execution completes successfully and the "API" returns a successful response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions Express Workflow state machine is created then the Step Functions execution fails and the "API" returns an error response
    Given smid not in sm_status
    Given a Step Functions Express Workflow state machine has been created
    When the Step Functions execution fails and the "API" returns an error response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then a "REST" "API" is created
    Given aid in api_status
    Given a Step Functions direct integration has been configured on the "REST" "API"
    When a "REST" "API" is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then a Step Functions Express Workflow state machine is created
    Given aid in api_status
    Given a Step Functions direct integration has been configured on the "REST" "API"
    When a Step Functions Express Workflow state machine is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given aid in api_status
    Given a Step Functions direct integration has been configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then the Step Functions execution completes successfully and the "API" returns a successful response
    Given aid in api_status
    Given a Step Functions direct integration has been configured on the "REST" "API"
    When the Step Functions execution completes successfully and the "API" returns a successful response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then the Step Functions execution fails and the "API" returns an error response
    Given aid in api_status
    Given a Step Functions direct integration has been configured on the "REST" "API"
    When the Step Functions execution fails and the "API" returns an error response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a "REST" "API" is created
    Given aid in api_status
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    When a "REST" "API" is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a Step Functions Express Workflow state machine is created
    Given aid in api_status
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    When a Step Functions Express Workflow state machine is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a Step Functions direct integration is configured on the "REST" "API"
    Given aid in api_status
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    When a Step Functions direct integration is configured on the "REST" "API"
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution completes successfully and the "API" returns a successful response
    Given aid in api_status
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    When the Step Functions execution completes successfully and the "API" returns a successful response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution fails and the "API" returns an error response
    Given aid in api_status
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    When the Step Functions execution fails and the "API" returns an error response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then a "REST" "API" is created
    Given eid in exec_status
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    When a "REST" "API" is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions Express Workflow state machine is created
    Given eid in exec_status
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    When a Step Functions Express Workflow state machine is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions direct integration is configured on the "REST" "API"
    Given eid in exec_status
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    When a Step Functions direct integration is configured on the "REST" "API"
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given eid in exec_status
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then the Step Functions execution fails and the "API" returns an error response
    Given eid in exec_status
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    When the Step Functions execution fails and the "API" returns an error response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then a "REST" "API" is created
    Given eid in exec_status
    Given the Step Functions execution has failed and the "API" has returned an error response
    When a "REST" "API" is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then a Step Functions Express Workflow state machine is created
    Given eid in exec_status
    Given the Step Functions execution has failed and the "API" has returned an error response
    When a Step Functions Express Workflow state machine is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then a Step Functions direct integration is configured on the "REST" "API"
    Given eid in exec_status
    Given the Step Functions execution has failed and the "API" has returned an error response
    When a Step Functions direct integration is configured on the "REST" "API"
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given eid in exec_status
    Given the Step Functions execution has failed and the "API" has returned an error response
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then the Step Functions execution completes successfully and the "API" returns a successful response
    Given eid in exec_status
    Given the Step Functions execution has failed and the "API" has returned an error response
    When the Step Functions execution completes successfully and the "API" returns a successful response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a "REST" "API" is created then a Step Functions Express Workflow state machine is created then a Step Functions direct integration is configured on the "REST" "API"
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given a Step Functions Express Workflow state machine has been created
    When a Step Functions direct integration is configured on the "REST" "API"
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a "REST" "API" is created then a Step Functions direct integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given a Step Functions direct integration has been configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution completes successfully and the "API" returns a successful response
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    When the Step Functions execution completes successfully and the "API" returns a successful response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a "REST" "API" is created then the Step Functions execution completes successfully and the "API" returns a successful response then the Step Functions execution fails and the "API" returns an error response
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    When the Step Functions execution fails and the "API" returns an error response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a "REST" "API" is created then the Step Functions execution fails and the "API" returns an error response then a Step Functions Express Workflow state machine is created
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given the Step Functions execution has failed and the "API" has returned an error response
    When a Step Functions Express Workflow state machine is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions Express Workflow state machine is created then a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given smid not in sm_status
    Given a Step Functions Express Workflow state machine has been created
    Given a "REST" "API" has been created
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions Express Workflow state machine is created then a Step Functions direct integration is configured on the "REST" "API" then the Step Functions execution completes successfully and the "API" returns a successful response
    Given smid not in sm_status
    Given a Step Functions Express Workflow state machine has been created
    Given a Step Functions direct integration has been configured on the "REST" "API"
    When the Step Functions execution completes successfully and the "API" returns a successful response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions Express Workflow state machine is created then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution fails and the "API" returns an error response
    Given smid not in sm_status
    Given a Step Functions Express Workflow state machine has been created
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    When the Step Functions execution fails and the "API" returns an error response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions Express Workflow state machine is created then the Step Functions execution completes successfully and the "API" returns a successful response then a "REST" "API" is created
    Given smid not in sm_status
    Given a Step Functions Express Workflow state machine has been created
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    When a "REST" "API" is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions Express Workflow state machine is created then the Step Functions execution fails and the "API" returns an error response then a Step Functions direct integration is configured on the "REST" "API"
    Given smid not in sm_status
    Given a Step Functions Express Workflow state machine has been created
    Given the Step Functions execution has failed and the "API" has returned an error response
    When a Step Functions direct integration is configured on the "REST" "API"
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then a "REST" "API" is created then the Step Functions execution completes successfully and the "API" returns a successful response
    Given aid in api_status
    Given a Step Functions direct integration has been configured on the "REST" "API"
    Given a "REST" "API" has been created
    When the Step Functions execution completes successfully and the "API" returns a successful response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then a Step Functions Express Workflow state machine is created then the Step Functions execution fails and the "API" returns an error response
    Given aid in api_status
    Given a Step Functions direct integration has been configured on the "REST" "API"
    Given a Step Functions Express Workflow state machine has been created
    When the Step Functions execution fails and the "API" returns an error response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a "REST" "API" is created
    Given aid in api_status
    Given a Step Functions direct integration has been configured on the "REST" "API"
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    When a "REST" "API" is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions Express Workflow state machine is created
    Given aid in api_status
    Given a Step Functions direct integration has been configured on the "REST" "API"
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    When a Step Functions Express Workflow state machine is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: a Step Functions direct integration is configured on the "REST" "API" then the Step Functions execution fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given aid in api_status
    Given a Step Functions direct integration has been configured on the "REST" "API"
    Given the Step Functions execution has failed and the "API" has returned an error response
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a "REST" "API" is created then the Step Functions execution fails and the "API" returns an error response
    Given aid in api_status
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    Given a "REST" "API" has been created
    When the Step Functions execution fails and the "API" returns an error response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a Step Functions Express Workflow state machine is created then a "REST" "API" is created
    Given aid in api_status
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    Given a Step Functions Express Workflow state machine has been created
    When a "REST" "API" is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a Step Functions direct integration is configured on the "REST" "API" then a Step Functions Express Workflow state machine is created
    Given aid in api_status
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    Given a Step Functions direct integration has been configured on the "REST" "API"
    When a Step Functions Express Workflow state machine is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions direct integration is configured on the "REST" "API"
    Given aid in api_status
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    When a Step Functions direct integration is configured on the "REST" "API"
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution fails and the "API" returns an error response then the Step Functions execution completes successfully and the "API" returns a successful response
    Given aid in api_status
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    Given the Step Functions execution has failed and the "API" has returned an error response
    When the Step Functions execution completes successfully and the "API" returns a successful response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then a "REST" "API" is created then a Step Functions Express Workflow state machine is created
    Given eid in exec_status
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    Given a "REST" "API" has been created
    When a Step Functions Express Workflow state machine is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions Express Workflow state machine is created then a Step Functions direct integration is configured on the "REST" "API"
    Given eid in exec_status
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    Given a Step Functions Express Workflow state machine has been created
    When a Step Functions direct integration is configured on the "REST" "API"
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions direct integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given eid in exec_status
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    Given a Step Functions direct integration has been configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then the Step Functions execution fails and the "API" returns an error response
    Given eid in exec_status
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    When the Step Functions execution fails and the "API" returns an error response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution completes successfully and the "API" returns a successful response then the Step Functions execution fails and the "API" returns an error response then a "REST" "API" is created
    Given eid in exec_status
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    Given the Step Functions execution has failed and the "API" has returned an error response
    When a "REST" "API" is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then a "REST" "API" is created then a Step Functions direct integration is configured on the "REST" "API"
    Given eid in exec_status
    Given the Step Functions execution has failed and the "API" has returned an error response
    Given a "REST" "API" has been created
    When a Step Functions direct integration is configured on the "REST" "API"
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then a Step Functions Express Workflow state machine is created then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Given eid in exec_status
    Given the Step Functions execution has failed and the "API" has returned an error response
    Given a Step Functions Express Workflow state machine has been created
    When the "API" receives an "HTTP" request and synchronously starts a Step Functions execution
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then a Step Functions direct integration is configured on the "REST" "API" then the Step Functions execution completes successfully and the "API" returns a successful response
    Given eid in exec_status
    Given the Step Functions execution has failed and the "API" has returned an error response
    Given a Step Functions direct integration has been configured on the "REST" "API"
    When the Step Functions execution completes successfully and the "API" returns a successful response
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously starts a Step Functions execution then a "REST" "API" is created
    Given eid in exec_status
    Given the Step Functions execution has failed and the "API" has returned an error response
    Given the "API" has received an "HTTP" request and synchronously started a Step Functions execution
    When a "REST" "API" is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @sequence
  Scenario: the Step Functions execution fails and the "API" returns an error response then the Step Functions execution completes successfully and the "API" returns a successful response then a Step Functions Express Workflow state machine is created
    Given eid in exec_status
    Given the Step Functions execution has failed and the "API" has returned an error response
    Given the Step Functions execution has completed successfully and the "API" has returned a successful response
    When a Step Functions Express Workflow state machine is created
    Then every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request
