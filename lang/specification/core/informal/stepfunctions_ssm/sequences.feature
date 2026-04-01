@stepfunctionsssm @generated
Feature: StepfunctionsSsm - Action Sequences

  # Generated from FizzBee spec: stepfunctions_ssm.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadAParameter

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "ssm" "parameter" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "ssm" "parameter" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a "ssm" "parameter" is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "ssm" "parameter" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reads an existing parameter and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to read the parameter because it has been deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then a "step functions" "state machine" is created
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then a "ssm" "parameter" is deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When a "ssm" "parameter" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then a running "step functions" "execution" reads an existing parameter and the task succeeds
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then a running "step functions" "execution" fails to read the parameter because it has been deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "step functions" "state machine" is created
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "ssm" "parameter" is created
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a running "step functions" "execution" reads an existing parameter and the task succeeds
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a running "step functions" "execution" fails to read the parameter because it has been deleted
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "ssm" "parameter" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "ssm" "parameter" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "ssm" "parameter" is deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "ssm" "parameter" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reads an existing parameter and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to read the parameter because it has been deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" reads an existing parameter and the task succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" reads an existing parameter and the task succeeds then a "ssm" "parameter" is created
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When a "ssm" "parameter" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" reads an existing parameter and the task succeeds then a "ssm" "parameter" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When a "ssm" "parameter" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" reads an existing parameter and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" reads an existing parameter and the task succeeds then a running "step functions" "execution" fails to read the parameter because it has been deleted
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the parameter because it has been deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the parameter because it has been deleted then a "ssm" "parameter" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When a "ssm" "parameter" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the parameter because it has been deleted then a "ssm" "parameter" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When a "ssm" "parameter" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the parameter because it has been deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the parameter because it has been deleted then a running "step functions" "execution" reads an existing parameter and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a "ssm" "parameter" is created then a "ssm" "parameter" is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "ssm" "parameter" is created
    When a "ssm" "parameter" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a "ssm" "parameter" is deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "ssm" "parameter" is deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reads an existing parameter and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reads an existing parameter and the task succeeds then a running "step functions" "execution" fails to read the parameter because it has been deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to read the parameter because it has been deleted then a "ssm" "parameter" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When a "ssm" "parameter" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then a "ssm" "parameter" is deleted then a running "step functions" "execution" reads an existing parameter and the task succeeds
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When a "ssm" "parameter" is deleted
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to read the parameter because it has been deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then a running "step functions" "execution" reads an existing parameter and the task succeeds then a "step functions" "state machine" is created
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then a running "step functions" "execution" fails to read the parameter because it has been deleted then a "ssm" "parameter" is deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When a "ssm" "parameter" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "step functions" "state machine" is created then a running "step functions" "execution" reads an existing parameter and the task succeeds
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "ssm" "parameter" is created then a running "step functions" "execution" fails to read the parameter because it has been deleted
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is created
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a running "step functions" "execution" reads an existing parameter and the task succeeds then a "ssm" "parameter" is created
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When a "ssm" "parameter" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a running "step functions" "execution" fails to read the parameter because it has been deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" fails to read the parameter because it has been deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "ssm" "parameter" is created then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "ssm" "parameter" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "ssm" "parameter" is deleted then a "ssm" "parameter" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reads an existing parameter and the task succeeds then a "ssm" "parameter" is deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When a "ssm" "parameter" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to read the parameter because it has been deleted then a running "step functions" "execution" reads an existing parameter and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" reads an existing parameter and the task succeeds then a "step functions" "state machine" is created then a "ssm" "parameter" is created
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When a "step functions" "state machine" is created
    When a "ssm" "parameter" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" reads an existing parameter and the task succeeds then a "ssm" "parameter" is created then a "ssm" "parameter" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When a "ssm" "parameter" is created
    When a "ssm" "parameter" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" reads an existing parameter and the task succeeds then a "ssm" "parameter" is deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When a "ssm" "parameter" is deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" reads an existing parameter and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to read the parameter because it has been deleted
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" reads an existing parameter and the task succeeds then a running "step functions" "execution" fails to read the parameter because it has been deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the parameter because it has been deleted then a "step functions" "state machine" is created then a "ssm" "parameter" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When a "step functions" "state machine" is created
    When a "ssm" "parameter" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the parameter because it has been deleted then a "ssm" "parameter" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When a "ssm" "parameter" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the parameter because it has been deleted then a "ssm" "parameter" is deleted then a running "step functions" "execution" reads an existing parameter and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When a "ssm" "parameter" is deleted
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the parameter because it has been deleted then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the parameter because it has been deleted then a running "step functions" "execution" reads an existing parameter and the task succeeds then a "ssm" "parameter" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    When a "ssm" "parameter" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read
