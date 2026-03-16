@stepfunctionsglacier @generated
Feature: StepfunctionsGlacier - Action Sequences

  # Generated from FizzBee spec: stepfunctions_glacier.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAVault

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the Glacier vault has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Step Functions state machine is created
    Given vid not in vault_status
    When a Glacier vault is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier vault is deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an execution of the state machine is started
    Given vid not in vault_status
    When a Glacier vault is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid not in vault_status
    When a Glacier vault is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution fails because the Glacier vault has been deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Step Functions state machine is created
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Glacier vault is created
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then an execution of the state machine is started
    Given vid in vault_status
    When a Glacier vault is deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid in vault_status
    When a Glacier vault is deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution fails because the Glacier vault has been deleted
    Given vid in vault_status
    When a Glacier vault is deleted
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the Glacier vault has been deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is created
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is deleted
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a running execution fails because the Glacier vault has been deleted
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is created
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is deleted
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is created then a Glacier vault is deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Glacier vault is created
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Glacier vault is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Glacier vault is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is created then a running execution fails because the Glacier vault has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Glacier vault is created
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is deleted then a Glacier vault is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Glacier vault is deleted
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is deleted then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Glacier vault is deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Glacier vault is deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is deleted then a running execution fails because the Glacier vault has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Glacier vault is deleted
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a Glacier vault is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a Glacier vault is deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution fails because the Glacier vault has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a running execution fails because the Glacier vault has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the Glacier vault has been deleted then a Glacier vault is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the Glacier vault has been deleted then a Glacier vault is deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the Glacier vault has been deleted then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the Glacier vault has been deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the Glacier vault has been deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Step Functions state machine is created then a Glacier vault is deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When a Step Functions state machine is created
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Step Functions state machine is created then an execution of the state machine is started
    Given vid not in vault_status
    When a Glacier vault is created
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Step Functions state machine is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid not in vault_status
    When a Glacier vault is created
    When a Step Functions state machine is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Step Functions state machine is created then a running execution fails because the Glacier vault has been deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When a Step Functions state machine is created
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier vault is deleted then a Step Functions state machine is created
    Given vid not in vault_status
    When a Glacier vault is created
    When a Glacier vault is deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier vault is deleted then an execution of the state machine is started
    Given vid not in vault_status
    When a Glacier vault is created
    When a Glacier vault is deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier vault is deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid not in vault_status
    When a Glacier vault is created
    When a Glacier vault is deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier vault is deleted then a running execution fails because the Glacier vault has been deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When a Glacier vault is deleted
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an execution of the state machine is started then a Step Functions state machine is created
    Given vid not in vault_status
    When a Glacier vault is created
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an execution of the state machine is started then a Glacier vault is deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When an execution of the state machine is started
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an execution of the state machine is started then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid not in vault_status
    When a Glacier vault is created
    When an execution of the state machine is started
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an execution of the state machine is started then a running execution fails because the Glacier vault has been deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When an execution of the state machine is started
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Step Functions state machine is created
    Given vid not in vault_status
    When a Glacier vault is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then an execution of the state machine is started
    Given vid not in vault_status
    When a Glacier vault is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a running execution fails because the Glacier vault has been deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution fails because the Glacier vault has been deleted then a Step Functions state machine is created
    Given vid not in vault_status
    When a Glacier vault is created
    When a running execution fails because the Glacier vault has been deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution fails because the Glacier vault has been deleted then a Glacier vault is deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution fails because the Glacier vault has been deleted then an execution of the state machine is started
    Given vid not in vault_status
    When a Glacier vault is created
    When a running execution fails because the Glacier vault has been deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution fails because the Glacier vault has been deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid not in vault_status
    When a Glacier vault is created
    When a running execution fails because the Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Step Functions state machine is created then a Glacier vault is created
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Step Functions state machine is created
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Step Functions state machine is created then an execution of the state machine is started
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Step Functions state machine is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Step Functions state machine is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Step Functions state machine is created then a running execution fails because the Glacier vault has been deleted
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Step Functions state machine is created
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Glacier vault is created then a Step Functions state machine is created
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Glacier vault is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Glacier vault is created then an execution of the state machine is started
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Glacier vault is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Glacier vault is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Glacier vault is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Glacier vault is created then a running execution fails because the Glacier vault has been deleted
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Glacier vault is created
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then an execution of the state machine is started then a Step Functions state machine is created
    Given vid in vault_status
    When a Glacier vault is deleted
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then an execution of the state machine is started then a Glacier vault is created
    Given vid in vault_status
    When a Glacier vault is deleted
    When an execution of the state machine is started
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then an execution of the state machine is started then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid in vault_status
    When a Glacier vault is deleted
    When an execution of the state machine is started
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then an execution of the state machine is started then a running execution fails because the Glacier vault has been deleted
    Given vid in vault_status
    When a Glacier vault is deleted
    When an execution of the state machine is started
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Step Functions state machine is created
    Given vid in vault_status
    When a Glacier vault is deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is created
    Given vid in vault_status
    When a Glacier vault is deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then an execution of the state machine is started
    Given vid in vault_status
    When a Glacier vault is deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a running execution fails because the Glacier vault has been deleted
    Given vid in vault_status
    When a Glacier vault is deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution fails because the Glacier vault has been deleted then a Step Functions state machine is created
    Given vid in vault_status
    When a Glacier vault is deleted
    When a running execution fails because the Glacier vault has been deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution fails because the Glacier vault has been deleted then a Glacier vault is created
    Given vid in vault_status
    When a Glacier vault is deleted
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution fails because the Glacier vault has been deleted then an execution of the state machine is started
    Given vid in vault_status
    When a Glacier vault is deleted
    When a running execution fails because the Glacier vault has been deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution fails because the Glacier vault has been deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid in vault_status
    When a Glacier vault is deleted
    When a running execution fails because the Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a Glacier vault is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a Glacier vault is deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails because the Glacier vault has been deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is created then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Glacier vault is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is created then a Glacier vault is deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a Glacier vault is created
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a Glacier vault is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is created then a running execution fails because the Glacier vault has been deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a Glacier vault is created
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is deleted then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Glacier vault is deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is deleted then a Glacier vault is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Glacier vault is deleted
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a Glacier vault is deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is deleted then a running execution fails because the Glacier vault has been deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a Glacier vault is deleted
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a running execution fails because the Glacier vault has been deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the Glacier vault has been deleted then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the Glacier vault has been deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the Glacier vault has been deleted then a Glacier vault is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the Glacier vault has been deleted then a Glacier vault is deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the Glacier vault has been deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Step Functions state machine is created then a Glacier vault is created
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Step Functions state machine is created
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Step Functions state machine is created then a Glacier vault is deleted
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Step Functions state machine is created
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Step Functions state machine is created then a running execution fails because the Glacier vault has been deleted
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Step Functions state machine is created
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is created then a Glacier vault is deleted
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is created
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is created then a running execution fails because the Glacier vault has been deleted
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is created
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is deleted then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is deleted then a Glacier vault is created
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is deleted
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is deleted then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is deleted then a running execution fails because the Glacier vault has been deleted
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is deleted
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then an execution of the state machine is started then a Glacier vault is created
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When an execution of the state machine is started
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then an execution of the state machine is started then a Glacier vault is deleted
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When an execution of the state machine is started
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then an execution of the state machine is started then a running execution fails because the Glacier vault has been deleted
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When an execution of the state machine is started
    When a running execution fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a running execution fails because the Glacier vault has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a running execution fails because the Glacier vault has been deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a running execution fails because the Glacier vault has been deleted then a Glacier vault is created
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a running execution fails because the Glacier vault has been deleted then a Glacier vault is deleted
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a running execution fails because the Glacier vault has been deleted then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a running execution fails because the Glacier vault has been deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Step Functions state machine is created then a Glacier vault is created
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Step Functions state machine is created
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Step Functions state machine is created then a Glacier vault is deleted
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Step Functions state machine is created
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Step Functions state machine is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Step Functions state machine is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is created then a Glacier vault is deleted
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is created
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is deleted then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is deleted then a Glacier vault is created
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is deleted
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is deleted then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a Glacier vault is deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then an execution of the state machine is started then a Glacier vault is created
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When an execution of the state machine is started
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then an execution of the state machine is started then a Glacier vault is deleted
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When an execution of the state machine is started
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then an execution of the state machine is started then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When an execution of the state machine is started
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is created
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is deleted
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When a Glacier vault is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called
