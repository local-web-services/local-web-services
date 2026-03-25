@stepfunctionscognito @generated
Feature: StepfunctionsCognito - Action Sequences

  # Generated from FizzBee spec: stepfunctions_cognito.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAPool

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Cognito user pool is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Cognito user pool is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Cognito user pool is deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Cognito user pool is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the Cognito user pool has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the Cognito user pool has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Step Functions state machine is created
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Cognito user pool is deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Cognito user pool is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then an execution of the state machine is started
    Given pid not in pool_status
    When a Cognito user pool is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given pid not in pool_status
    When a Cognito user pool is created
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a running execution fails because the Cognito user pool has been deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When a running execution fails because the Cognito user pool has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Step Functions state machine is created
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Cognito user pool is created
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Cognito user pool is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then an execution of the state machine is started
    Given pid in pool_status
    When a Cognito user pool is deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a running execution fails because the Cognito user pool has been deleted
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a running execution fails because the Cognito user pool has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Cognito user pool is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Cognito user pool is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Cognito user pool is deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a Cognito user pool is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the Cognito user pool has been deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the Cognito user pool has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When a Cognito user pool is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is deleted
    Given eid in exec_status
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When a Cognito user pool is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a running execution fails because the Cognito user pool has been deleted
    Given eid in exec_status
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When a running execution fails because the Cognito user pool has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the Cognito user pool has been deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a Cognito user pool is created
    Given eid in exec_status
    When a running execution fails because the Cognito user pool has been deleted
    When a Cognito user pool is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a Cognito user pool is deleted
    Given eid in exec_status
    When a running execution fails because the Cognito user pool has been deleted
    When a Cognito user pool is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the Cognito user pool has been deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given eid in exec_status
    When a running execution fails because the Cognito user pool has been deleted
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Cognito user pool is created then a Cognito user pool is deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Cognito user pool is created
    When a Cognito user pool is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Cognito user pool is deleted then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Cognito user pool is deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a running execution fails because the Cognito user pool has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When a running execution fails because the Cognito user pool has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the Cognito user pool has been deleted then a Cognito user pool is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the Cognito user pool has been deleted
    When a Cognito user pool is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Step Functions state machine is created then an execution of the state machine is started
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Cognito user pool is deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Cognito user pool is deleted
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then an execution of the state machine is started then a running execution fails because the Cognito user pool has been deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When an execution of the state machine is started
    When a running execution fails because the Cognito user pool has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Step Functions state machine is created
    Given pid not in pool_status
    When a Cognito user pool is created
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a running execution fails because the Cognito user pool has been deleted then a Cognito user pool is deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When a running execution fails because the Cognito user pool has been deleted
    When a Cognito user pool is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Step Functions state machine is created then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Cognito user pool is created then a running execution fails because the Cognito user pool has been deleted
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Cognito user pool is created
    When a running execution fails because the Cognito user pool has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then an execution of the state machine is started then a Step Functions state machine is created
    Given pid in pool_status
    When a Cognito user pool is deleted
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is created
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When a Cognito user pool is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a running execution fails because the Cognito user pool has been deleted then an execution of the state machine is started
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a running execution fails because the Cognito user pool has been deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails because the Cognito user pool has been deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution fails because the Cognito user pool has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Cognito user pool is created then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Cognito user pool is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Cognito user pool is deleted then a Cognito user pool is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Cognito user pool is deleted
    When a Cognito user pool is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When a Cognito user pool is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the Cognito user pool has been deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the Cognito user pool has been deleted
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Step Functions state machine is created then a Cognito user pool is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When a Step Functions state machine is created
    When a Cognito user pool is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is created then a Cognito user pool is deleted
    Given eid in exec_status
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When a Cognito user pool is created
    When a Cognito user pool is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is deleted then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When a Cognito user pool is deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then an execution of the state machine is started then a running execution fails because the Cognito user pool has been deleted
    Given eid in exec_status
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When an execution of the state machine is started
    When a running execution fails because the Cognito user pool has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a running execution fails because the Cognito user pool has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When a running execution fails because the Cognito user pool has been deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a Step Functions state machine is created then a Cognito user pool is deleted
    Given eid in exec_status
    When a running execution fails because the Cognito user pool has been deleted
    When a Step Functions state machine is created
    When a Cognito user pool is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a Cognito user pool is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the Cognito user pool has been deleted
    When a Cognito user pool is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a Cognito user pool is deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given eid in exec_status
    When a running execution fails because the Cognito user pool has been deleted
    When a Cognito user pool is deleted
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the Cognito user pool has been deleted
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is created
    Given eid in exec_status
    When a running execution fails because the Cognito user pool has been deleted
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    When a Cognito user pool is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called
