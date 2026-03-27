@stepfunctionsglacier @generated
Feature: StepfunctionsGlacier - Action Sequences

  # Generated from FizzBee spec: stepfunctions_glacier.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAVault

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a Glacier vault is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a Glacier vault is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the Glacier vault has been deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution fails because the Glacier vault has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Step Functions state machine is created
    Given vid not in vault_status
    Given a Glacier vault has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier vault is deleted
    Given vid not in vault_status
    Given a Glacier vault has been created
    When a Glacier vault is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an execution of the state machine is started
    Given vid not in vault_status
    Given a Glacier vault has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid not in vault_status
    Given a Glacier vault has been created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution fails because the Glacier vault has been deleted
    Given vid not in vault_status
    Given a Glacier vault has been created
    When a running execution fails because the Glacier vault has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Step Functions state machine is created
    Given vid in vault_status
    Given a Glacier vault has been deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Glacier vault is created
    Given vid in vault_status
    Given a Glacier vault has been deleted
    When a Glacier vault is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then an execution of the state machine is started
    Given vid in vault_status
    Given a Glacier vault has been deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid in vault_status
    Given a Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution fails because the Glacier vault has been deleted
    Given vid in vault_status
    Given a Glacier vault has been deleted
    When a running execution fails because the Glacier vault has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Glacier vault is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is deleted
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Glacier vault is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the Glacier vault has been deleted
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution fails because the Glacier vault has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is created
    Given eid in exec_status
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    When a Glacier vault is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is deleted
    Given eid in exec_status
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    When a Glacier vault is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a running execution fails because the Glacier vault has been deleted
    Given eid in exec_status
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    When a running execution fails because the Glacier vault has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed because the Glacier vault has been deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is created
    Given eid in exec_status
    Given a running execution has failed because the Glacier vault has been deleted
    When a Glacier vault is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is deleted
    Given eid in exec_status
    Given a running execution has failed because the Glacier vault has been deleted
    When a Glacier vault is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed because the Glacier vault has been deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given eid in exec_status
    Given a running execution has failed because the Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is created then a Glacier vault is deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a Glacier vault has been created
    When a Glacier vault is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Glacier vault is deleted then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a Glacier vault has been deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a running execution fails because the Glacier vault has been deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    When a running execution fails because the Glacier vault has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the Glacier vault has been deleted then a Glacier vault is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has failed because the Glacier vault has been deleted
    When a Glacier vault is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Step Functions state machine is created then an execution of the state machine is started
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier vault is deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given a Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an execution of the state machine is started then a running execution fails because the Glacier vault has been deleted
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given an execution of the state machine has been started
    When a running execution fails because the Glacier vault has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Step Functions state machine is created
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a running execution fails because the Glacier vault has been deleted then a Glacier vault is deleted
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given a running execution has failed because the Glacier vault has been deleted
    When a Glacier vault is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Step Functions state machine is created then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given vid in vault_status
    Given a Glacier vault has been deleted
    Given a Step Functions state machine has been created
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Glacier vault is created then a running execution fails because the Glacier vault has been deleted
    Given vid in vault_status
    Given a Glacier vault has been deleted
    Given a Glacier vault has been created
    When a running execution fails because the Glacier vault has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then an execution of the state machine is started then a Step Functions state machine is created
    Given vid in vault_status
    Given a Glacier vault has been deleted
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is created
    Given vid in vault_status
    Given a Glacier vault has been deleted
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    When a Glacier vault is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a running execution fails because the Glacier vault has been deleted then an execution of the state machine is started
    Given vid in vault_status
    Given a Glacier vault has been deleted
    Given a running execution has failed because the Glacier vault has been deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails because the Glacier vault has been deleted
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When a running execution fails because the Glacier vault has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is created then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Glacier vault has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Glacier vault is deleted then a Glacier vault is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Glacier vault has been deleted
    When a Glacier vault is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is deleted
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    When a Glacier vault is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the Glacier vault has been deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has failed because the Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Step Functions state machine is created then a Glacier vault is created
    Given eid in exec_status
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    Given a Step Functions state machine has been created
    When a Glacier vault is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is created then a Glacier vault is deleted
    Given eid in exec_status
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    Given a Glacier vault has been created
    When a Glacier vault is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is deleted then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    Given a Glacier vault has been deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then an execution of the state machine is started then a running execution fails because the Glacier vault has been deleted
    Given eid in exec_status
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    Given an execution of the state machine has been started
    When a running execution fails because the Glacier vault has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a running execution fails because the Glacier vault has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    Given a running execution has failed because the Glacier vault has been deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Step Functions state machine is created then a Glacier vault is deleted
    Given eid in exec_status
    Given a running execution has failed because the Glacier vault has been deleted
    Given a Step Functions state machine has been created
    When a Glacier vault is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is created then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed because the Glacier vault has been deleted
    Given a Glacier vault has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a Glacier vault is deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given eid in exec_status
    Given a running execution has failed because the Glacier vault has been deleted
    Given a Glacier vault has been deleted
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed because the Glacier vault has been deleted
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @exhaustive @sequence
  Scenario: a running execution fails because the Glacier vault has been deleted then a running execution calls a Glacier vault that "EXISTS" and the task succeeds then a Glacier vault is created
    Given eid in exec_status
    Given a running execution has failed because the Glacier vault has been deleted
    Given a running execution has called a Glacier vault that "EXISTS" and the task succeeded
    When a Glacier vault is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called
