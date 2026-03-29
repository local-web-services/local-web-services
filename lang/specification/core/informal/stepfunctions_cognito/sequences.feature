@stepfunctionscognito @generated
Feature: StepfunctionsCognito - Action Sequences

  # Generated from FizzBee spec: stepfunctions_cognito.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAPool

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Cognito user pool is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a Cognito user pool is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Cognito user pool is deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a Cognito user pool is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the Cognito user pool has been deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution fails because the Cognito user pool has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Step Functions state machine is created
    Given pid not in pool_status
    Given a Cognito user pool has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Cognito user pool is deleted
    Given pid not in pool_status
    Given a Cognito user pool has been created
    When a Cognito user pool is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then an execution of the state machine is started
    Given pid not in pool_status
    Given a Cognito user pool has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given pid not in pool_status
    Given a Cognito user pool has been created
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a running execution fails because the Cognito user pool has been deleted
    Given pid not in pool_status
    Given a Cognito user pool has been created
    When a running execution fails because the Cognito user pool has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Step Functions state machine is created
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Cognito user pool is created
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    When a Cognito user pool is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then an execution of the state machine is started
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a running execution fails because the Cognito user pool has been deleted
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    When a running execution fails because the Cognito user pool has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Cognito user pool is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Cognito user pool is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Cognito user pool is deleted
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Cognito user pool is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the Cognito user pool has been deleted
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution fails because the Cognito user pool has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is created
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    When a Cognito user pool is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is deleted
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    When a Cognito user pool is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a running execution fails because the Cognito user pool has been deleted
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    When a running execution fails because the Cognito user pool has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed because the Cognito user pool has been deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a Cognito user pool is created
    Given eid in exec_status
    Given a running execution has failed because the Cognito user pool has been deleted
    When a Cognito user pool is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a Cognito user pool is deleted
    Given eid in exec_status
    Given a running execution has failed because the Cognito user pool has been deleted
    When a Cognito user pool is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed because the Cognito user pool has been deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given eid in exec_status
    Given a running execution has failed because the Cognito user pool has been deleted
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Cognito user pool is created then a Cognito user pool is deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a Cognito user pool has been created
    When a Cognito user pool is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Cognito user pool is deleted then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a Cognito user pool has been deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a running execution fails because the Cognito user pool has been deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    When a running execution fails because the Cognito user pool has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the Cognito user pool has been deleted then a Cognito user pool is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has failed because the Cognito user pool has been deleted
    When a Cognito user pool is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Step Functions state machine is created then an execution of the state machine is started
    Given pid not in pool_status
    Given a Cognito user pool has been created
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Cognito user pool is deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given pid not in pool_status
    Given a Cognito user pool has been created
    Given a Cognito user pool has been deleted
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then an execution of the state machine is started then a running execution fails because the Cognito user pool has been deleted
    Given pid not in pool_status
    Given a Cognito user pool has been created
    Given an execution of the state machine has been started
    When a running execution fails because the Cognito user pool has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Step Functions state machine is created
    Given pid not in pool_status
    Given a Cognito user pool has been created
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a running execution fails because the Cognito user pool has been deleted then a Cognito user pool is deleted
    Given pid not in pool_status
    Given a Cognito user pool has been created
    Given a running execution has failed because the Cognito user pool has been deleted
    When a Cognito user pool is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Step Functions state machine is created then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    Given a Step Functions state machine has been created
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Cognito user pool is created then a running execution fails because the Cognito user pool has been deleted
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    Given a Cognito user pool has been created
    When a running execution fails because the Cognito user pool has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then an execution of the state machine is started then a Step Functions state machine is created
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is created
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    When a Cognito user pool is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a running execution fails because the Cognito user pool has been deleted then an execution of the state machine is started
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    Given a running execution has failed because the Cognito user pool has been deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails because the Cognito user pool has been deleted
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When a running execution fails because the Cognito user pool has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Cognito user pool is created then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Cognito user pool has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Cognito user pool is deleted then a Cognito user pool is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Cognito user pool has been deleted
    When a Cognito user pool is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is deleted
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    When a Cognito user pool is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the Cognito user pool has been deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has failed because the Cognito user pool has been deleted
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Step Functions state machine is created then a Cognito user pool is created
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    Given a Step Functions state machine has been created
    When a Cognito user pool is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is created then a Cognito user pool is deleted
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    Given a Cognito user pool has been created
    When a Cognito user pool is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is deleted then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    Given a Cognito user pool has been deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then an execution of the state machine is started then a running execution fails because the Cognito user pool has been deleted
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    Given an execution of the state machine has been started
    When a running execution fails because the Cognito user pool has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a running execution fails because the Cognito user pool has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    Given a running execution has failed because the Cognito user pool has been deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a Step Functions state machine is created then a Cognito user pool is deleted
    Given eid in exec_status
    Given a running execution has failed because the Cognito user pool has been deleted
    Given a Step Functions state machine has been created
    When a Cognito user pool is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a Cognito user pool is created then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed because the Cognito user pool has been deleted
    Given a Cognito user pool has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a Cognito user pool is deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given eid in exec_status
    Given a running execution has failed because the Cognito user pool has been deleted
    Given a Cognito user pool has been deleted
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed because the Cognito user pool has been deleted
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Cognito user pool has been deleted then a running execution calls an "ACTIVE" Cognito user pool and the task succeeds then a Cognito user pool is created
    Given eid in exec_status
    Given a running execution has failed because the Cognito user pool has been deleted
    Given a running execution has called an "ACTIVE" Cognito user pool and the task succeeded
    When a Cognito user pool is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called
