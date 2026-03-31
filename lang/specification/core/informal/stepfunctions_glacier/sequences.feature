@stepfunctionsglacier @generated
Feature: StepfunctionsGlacier - Action Sequences

  # Generated from FizzBee spec: stepfunctions_glacier.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAVault

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "glacier" "vault" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "glacier" "vault" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a "glacier" "vault" is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "glacier" "vault" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails because the Glacier vault has been deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is created then a "step functions" "state machine" is created
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "vault" is deleted
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "vault" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is created then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is created then a running "step functions" "execution" fails because the Glacier vault has been deleted
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is deleted then a "step functions" "state machine" is created
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is deleted then a "glacier" "vault" is created
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When a "glacier" "vault" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is deleted then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is deleted then a running "step functions" "execution" fails because the Glacier vault has been deleted
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "glacier" "vault" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "glacier" "vault" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "glacier" "vault" is deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "glacier" "vault" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the Glacier vault has been deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then a "glacier" "vault" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When a "glacier" "vault" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then a "glacier" "vault" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When a "glacier" "vault" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then a running "step functions" "execution" fails because the Glacier vault has been deleted
    Given eid in exec_status
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the Glacier vault has been deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the Glacier vault has been deleted then a "glacier" "vault" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When a "glacier" "vault" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the Glacier vault has been deleted then a "glacier" "vault" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When a "glacier" "vault" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the Glacier vault has been deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the Glacier vault has been deleted then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a "glacier" "vault" is created then a "glacier" "vault" is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "glacier" "vault" is created
    When a "glacier" "vault" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a "glacier" "vault" is deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "glacier" "vault" is deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then a running "step functions" "execution" fails because the Glacier vault has been deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails because the Glacier vault has been deleted then a "glacier" "vault" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When a "glacier" "vault" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is created then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "vault" is deleted then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "vault" is deleted
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the Glacier vault has been deleted
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is created then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then a "step functions" "state machine" is created
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is created then a running "step functions" "execution" fails because the Glacier vault has been deleted then a "glacier" "vault" is deleted
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When a "glacier" "vault" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is deleted then a "step functions" "state machine" is created then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is deleted then a "glacier" "vault" is created then a running "step functions" "execution" fails because the Glacier vault has been deleted
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When a "glacier" "vault" is created
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is deleted then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is deleted then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then a "glacier" "vault" is created
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When a "glacier" "vault" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a "glacier" "vault" is deleted then a running "step functions" "execution" fails because the Glacier vault has been deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" fails because the Glacier vault has been deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "glacier" "vault" is created then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "glacier" "vault" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "glacier" "vault" is deleted then a "glacier" "vault" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "glacier" "vault" is deleted
    When a "glacier" "vault" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then a "glacier" "vault" is deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When a "glacier" "vault" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the Glacier vault has been deleted then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then a "step functions" "state machine" is created then a "glacier" "vault" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When a "step functions" "state machine" is created
    When a "glacier" "vault" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then a "glacier" "vault" is created then a "glacier" "vault" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When a "glacier" "vault" is created
    When a "glacier" "vault" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then a "glacier" "vault" is deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When a "glacier" "vault" is deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the Glacier vault has been deleted
    Given eid in exec_status
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then a running "step functions" "execution" fails because the Glacier vault has been deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the Glacier vault has been deleted then a "step functions" "state machine" is created then a "glacier" "vault" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When a "step functions" "state machine" is created
    When a "glacier" "vault" is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the Glacier vault has been deleted then a "glacier" "vault" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When a "glacier" "vault" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the Glacier vault has been deleted then a "glacier" "vault" is deleted then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When a "glacier" "vault" is deleted
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the Glacier vault has been deleted then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the Glacier vault has been deleted then a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds then a "glacier" "vault" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    When a "glacier" "vault" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called
