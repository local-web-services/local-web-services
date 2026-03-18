@stepfunctionsssm @generated
Feature: StepfunctionsSsm - Action Sequences

  # Generated from FizzBee spec: stepfunctions_ssm.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadAParameter

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a parameter is created in "SSM" Parameter Store
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a parameter is deleted from "SSM" Parameter Store
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an existing parameter and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read the parameter because it has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a Step Functions state machine is created
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then an execution of the state machine is started
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a Step Functions state machine is created
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then an execution of the state machine is started
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a parameter is created in "SSM" Parameter Store
    Given smid in sm_status
    When an execution of the state machine is started
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a parameter is deleted from "SSM" Parameter Store
    Given smid in sm_status
    When an execution of the state machine is started
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads an existing parameter and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read the parameter because it has been deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a running execution fails to read the parameter because it has been deleted
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a running execution reads an existing parameter and the task succeeds
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a parameter is created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a parameter is created in "SSM" Parameter Store then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a parameter is created in "SSM" Parameter Store
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a parameter is created in "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a parameter is created in "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a parameter is created in "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a parameter is created in "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a parameter is deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a parameter is deleted from "SSM" Parameter Store then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a parameter is deleted from "SSM" Parameter Store
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a parameter is deleted from "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a parameter is deleted from "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a parameter is created in "SSM" Parameter Store
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a parameter is deleted from "SSM" Parameter Store
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution reads an existing parameter and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution fails to read the parameter because it has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an existing parameter and the task succeeds then a parameter is created in "SSM" Parameter Store
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an existing parameter and the task succeeds then a parameter is deleted from "SSM" Parameter Store
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an existing parameter and the task succeeds then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads an existing parameter and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an existing parameter and the task succeeds then a running execution fails to read the parameter because it has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads an existing parameter and the task succeeds
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read the parameter because it has been deleted then a parameter is created in "SSM" Parameter Store
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read the parameter because it has been deleted then a parameter is deleted from "SSM" Parameter Store
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read the parameter because it has been deleted then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to read the parameter because it has been deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read the parameter because it has been deleted then a running execution reads an existing parameter and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to read the parameter because it has been deleted
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a Step Functions state machine is created then a parameter is deleted from "SSM" Parameter Store
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a Step Functions state machine is created
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a Step Functions state machine is created then an execution of the state machine is started
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a Step Functions state machine is created then a running execution reads an existing parameter and the task succeeds
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a Step Functions state machine is created
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a Step Functions state machine is created then a running execution fails to read the parameter because it has been deleted
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a Step Functions state machine is created
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store then a Step Functions state machine is created
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store then an execution of the state machine is started
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then an execution of the state machine is started then a Step Functions state machine is created
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then an execution of the state machine is started then a parameter is deleted from "SSM" Parameter Store
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When an execution of the state machine is started
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then an execution of the state machine is started then a running execution reads an existing parameter and the task succeeds
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When an execution of the state machine is started
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then an execution of the state machine is started then a running execution fails to read the parameter because it has been deleted
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When an execution of the state machine is started
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds then a Step Functions state machine is created
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds then a parameter is deleted from "SSM" Parameter Store
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds then an execution of the state machine is started
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds then a running execution fails to read the parameter because it has been deleted
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted then a Step Functions state machine is created
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted then a parameter is deleted from "SSM" Parameter Store
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted then an execution of the state machine is started
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted then a running execution reads an existing parameter and the task succeeds
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a Step Functions state machine is created then a parameter is created in "SSM" Parameter Store
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a Step Functions state machine is created
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a Step Functions state machine is created then an execution of the state machine is started
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a Step Functions state machine is created then a running execution reads an existing parameter and the task succeeds
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a Step Functions state machine is created
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a Step Functions state machine is created then a running execution fails to read the parameter because it has been deleted
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a Step Functions state machine is created
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store then a Step Functions state machine is created
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store then an execution of the state machine is started
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then an execution of the state machine is started then a Step Functions state machine is created
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then an execution of the state machine is started then a parameter is created in "SSM" Parameter Store
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When an execution of the state machine is started
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then an execution of the state machine is started then a running execution reads an existing parameter and the task succeeds
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When an execution of the state machine is started
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then an execution of the state machine is started then a running execution fails to read the parameter because it has been deleted
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When an execution of the state machine is started
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds then a Step Functions state machine is created
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds then a parameter is created in "SSM" Parameter Store
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds then an execution of the state machine is started
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds then a running execution fails to read the parameter because it has been deleted
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted then a Step Functions state machine is created
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted then a parameter is created in "SSM" Parameter Store
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted then an execution of the state machine is started
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted then a running execution reads an existing parameter and the task succeeds
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a parameter is created in "SSM" Parameter Store
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a parameter is deleted from "SSM" Parameter Store
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution reads an existing parameter and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to read the parameter because it has been deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a parameter is created in "SSM" Parameter Store then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a parameter is created in "SSM" Parameter Store
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given smid in sm_status
    When an execution of the state machine is started
    When a parameter is created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a parameter is created in "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a parameter is created in "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a parameter is created in "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a parameter is created in "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a parameter is deleted from "SSM" Parameter Store then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a parameter is deleted from "SSM" Parameter Store
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store
    Given smid in sm_status
    When an execution of the state machine is started
    When a parameter is deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a parameter is deleted from "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a parameter is deleted from "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads an existing parameter and the task succeeds then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads an existing parameter and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads an existing parameter and the task succeeds then a parameter is created in "SSM" Parameter Store
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads an existing parameter and the task succeeds then a parameter is deleted from "SSM" Parameter Store
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads an existing parameter and the task succeeds then a running execution fails to read the parameter because it has been deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads an existing parameter and the task succeeds
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read the parameter because it has been deleted then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to read the parameter because it has been deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read the parameter because it has been deleted then a parameter is created in "SSM" Parameter Store
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read the parameter because it has been deleted then a parameter is deleted from "SSM" Parameter Store
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read the parameter because it has been deleted then a running execution reads an existing parameter and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to read the parameter because it has been deleted
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a Step Functions state machine is created then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a Step Functions state machine is created
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a Step Functions state machine is created then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a Step Functions state machine is created
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a Step Functions state machine is created then a running execution fails to read the parameter because it has been deleted
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a Step Functions state machine is created
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is created in "SSM" Parameter Store then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is created in "SSM" Parameter Store
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is created in "SSM" Parameter Store then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is created in "SSM" Parameter Store
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is created in "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is created in "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is deleted from "SSM" Parameter Store then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is deleted from "SSM" Parameter Store
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is deleted from "SSM" Parameter Store then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is deleted from "SSM" Parameter Store
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is deleted from "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then an execution of the state machine is started then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When an execution of the state machine is started
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then an execution of the state machine is started then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When an execution of the state machine is started
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then an execution of the state machine is started then a running execution fails to read the parameter because it has been deleted
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When an execution of the state machine is started
    When a running execution fails to read the parameter because it has been deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a running execution fails to read the parameter because it has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a running execution fails to read the parameter because it has been deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a running execution fails to read the parameter because it has been deleted then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a running execution fails to read the parameter because it has been deleted then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a running execution fails to read the parameter because it has been deleted then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads an existing parameter and the task succeeds
    When a running execution fails to read the parameter because it has been deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a Step Functions state machine is created then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a Step Functions state machine is created
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a Step Functions state machine is created then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a Step Functions state machine is created
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a Step Functions state machine is created then a running execution reads an existing parameter and the task succeeds
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a Step Functions state machine is created
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is created in "SSM" Parameter Store then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is created in "SSM" Parameter Store
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is created in "SSM" Parameter Store then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is created in "SSM" Parameter Store
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is created in "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is created in "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is deleted from "SSM" Parameter Store then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is deleted from "SSM" Parameter Store then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is deleted from "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then an execution of the state machine is started then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When an execution of the state machine is started
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then an execution of the state machine is started then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When an execution of the state machine is started
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then an execution of the state machine is started then a running execution reads an existing parameter and the task succeeds
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When an execution of the state machine is started
    When a running execution reads an existing parameter and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a running execution reads an existing parameter and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a running execution reads an existing parameter and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a running execution reads an existing parameter and the task succeeds then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is created in "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a running execution reads an existing parameter and the task succeeds then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a running execution reads an existing parameter and the task succeeds
    When a parameter is deleted from "SSM" Parameter Store
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a running execution reads an existing parameter and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to read the parameter because it has been deleted
    When a running execution reads an existing parameter and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read
