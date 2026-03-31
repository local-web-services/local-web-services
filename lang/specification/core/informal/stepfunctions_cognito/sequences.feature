@stepfunctionscognito @generated
Feature: StepfunctionsCognito - Action Sequences

  # Generated from FizzBee spec: stepfunctions_cognito.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAPool

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "cognito" "user pool" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "cognito" "user pool" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a "cognito" "user pool" is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "cognito" "user pool" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is created then a "step functions" "state machine" is created
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user pool" is deleted
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is created then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is created then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "step functions" "state machine" is created
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user pool" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "cognito" "user pool" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "cognito" "user pool" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "cognito" "user pool" is deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "cognito" "user pool" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then a "cognito" "user pool" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When a "cognito" "user pool" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then a "cognito" "user pool" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When a "cognito" "user pool" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then a "cognito" "user pool" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When a "cognito" "user pool" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then a "cognito" "user pool" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When a "cognito" "user pool" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a "cognito" "user pool" is created then a "cognito" "user pool" is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a "cognito" "user pool" is deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "cognito" "user pool" is deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then a "cognito" "user pool" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When a "cognito" "user pool" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is created then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user pool" is deleted then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" is deleted
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is created then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then a "step functions" "state machine" is created
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is created then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then a "cognito" "user pool" is deleted
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When a "cognito" "user pool" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "step functions" "state machine" is created then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user pool" is created then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user pool" is created
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When a "cognito" "user pool" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "cognito" "user pool" is created then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "cognito" "user pool" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "cognito" "user pool" is deleted then a "cognito" "user pool" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "cognito" "user pool" is deleted
    When a "cognito" "user pool" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then a "cognito" "user pool" is deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When a "cognito" "user pool" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then a "step functions" "state machine" is created then a "cognito" "user pool" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When a "step functions" "state machine" is created
    When a "cognito" "user pool" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then a "cognito" "user pool" is created then a "cognito" "user pool" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then a "cognito" "user pool" is deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When a "cognito" "user pool" is deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then a "step functions" "state machine" is created then a "cognito" "user pool" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When a "step functions" "state machine" is created
    When a "cognito" "user pool" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then a "cognito" "user pool" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When a "cognito" "user pool" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then a "cognito" "user pool" is deleted then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When a "cognito" "user pool" is deleted
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted then a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds then a "cognito" "user pool" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    When a "cognito" "user pool" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called
