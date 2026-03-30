@stepfunctionsssm @generated
Feature: StepfunctionsSsm - Action Sequences

  # Generated from FizzBee spec: stepfunctions_ssm.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadAParameter

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Step Functions state machine is created then a parameter is created in "SSM" Parameter Store
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a parameter is created in "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a Step Functions state machine is created then a parameter is deleted from "SSM" Parameter Store
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a parameter is deleted from "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an existing parameter and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution reads an existing parameter and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read the parameter because it has been deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution fails to read the parameter because it has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a Step Functions state machine is created
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then an execution of the state machine is started
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a Step Functions state machine is created
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then an execution of the state machine is started
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: an execution of the state machine is started then a parameter is created in "SSM" Parameter Store
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a parameter is created in "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: an execution of the state machine is started then a parameter is deleted from "SSM" Parameter Store
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a parameter is deleted from "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: an execution of the state machine is started then a running execution reads an existing parameter and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution reads an existing parameter and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read the parameter because it has been deleted
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution fails to read the parameter because it has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has read an existing parameter and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    Given a running execution has read an existing parameter and the task succeeded
    When a parameter is created in "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    Given a running execution has read an existing parameter and the task succeeded
    When a parameter is deleted from "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has read an existing parameter and the task succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a running execution fails to read the parameter because it has been deleted
    Given eid in exec_status
    Given a running execution has read an existing parameter and the task succeeded
    When a running execution fails to read the parameter because it has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed to read the parameter because it has been deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    Given a running execution has failed to read the parameter because it has been deleted
    When a parameter is created in "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    Given a running execution has failed to read the parameter because it has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed to read the parameter because it has been deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a running execution reads an existing parameter and the task succeeds
    Given eid in exec_status
    Given a running execution has failed to read the parameter because it has been deleted
    When a running execution reads an existing parameter and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a Step Functions state machine is created then a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a parameter has been created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a Step Functions state machine is created then a parameter is deleted from "SSM" Parameter Store then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a parameter has been deleted from "SSM" Parameter Store
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution reads an existing parameter and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution reads an existing parameter and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an existing parameter and the task succeeds then a running execution fails to read the parameter because it has been deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has read an existing parameter and the task succeeded
    When a running execution fails to read the parameter because it has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read the parameter because it has been deleted then a parameter is created in "SSM" Parameter Store
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has failed to read the parameter because it has been deleted
    When a parameter is created in "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a Step Functions state machine is created then an execution of the state machine is started
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    Given a parameter has been deleted from "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then an execution of the state machine is started then a running execution fails to read the parameter because it has been deleted
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    Given an execution of the state machine has been started
    When a running execution fails to read the parameter because it has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds then a Step Functions state machine is created
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    Given a running execution has read an existing parameter and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted then a parameter is deleted from "SSM" Parameter Store
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    Given a running execution has failed to read the parameter because it has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a Step Functions state machine is created then a running execution reads an existing parameter and the task succeeds
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    Given a Step Functions state machine has been created
    When a running execution reads an existing parameter and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    Given a parameter has been created in "SSM" Parameter Store
    When a running execution fails to read the parameter because it has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then an execution of the state machine is started then a Step Functions state machine is created
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds then a parameter is created in "SSM" Parameter Store
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    Given a running execution has read an existing parameter and the task succeeded
    When a parameter is created in "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a running execution fails to read the parameter because it has been deleted then an execution of the state machine is started
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    Given a running execution has failed to read the parameter because it has been deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to read the parameter because it has been deleted
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When a running execution fails to read the parameter because it has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: an execution of the state machine is started then a parameter is created in "SSM" Parameter Store then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a parameter has been created in "SSM" Parameter Store
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: an execution of the state machine is started then a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a parameter has been deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: an execution of the state machine is started then a running execution reads an existing parameter and the task succeeds then a parameter is deleted from "SSM" Parameter Store
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has read an existing parameter and the task succeeded
    When a parameter is deleted from "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read the parameter because it has been deleted then a running execution reads an existing parameter and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has failed to read the parameter because it has been deleted
    When a running execution reads an existing parameter and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a Step Functions state machine is created then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    Given a running execution has read an existing parameter and the task succeeded
    Given a Step Functions state machine has been created
    When a parameter is created in "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    Given a running execution has read an existing parameter and the task succeeded
    Given a parameter has been created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a parameter is deleted from "SSM" Parameter Store then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has read an existing parameter and the task succeeded
    Given a parameter has been deleted from "SSM" Parameter Store
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then an execution of the state machine is started then a running execution fails to read the parameter because it has been deleted
    Given eid in exec_status
    Given a running execution has read an existing parameter and the task succeeded
    Given an execution of the state machine has been started
    When a running execution fails to read the parameter because it has been deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution reads an existing parameter and the task succeeds then a running execution fails to read the parameter because it has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has read an existing parameter and the task succeeded
    Given a running execution has failed to read the parameter because it has been deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a Step Functions state machine is created then a parameter is deleted from "SSM" Parameter Store
    Given eid in exec_status
    Given a running execution has failed to read the parameter because it has been deleted
    Given a Step Functions state machine has been created
    When a parameter is deleted from "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is created in "SSM" Parameter Store then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed to read the parameter because it has been deleted
    Given a parameter has been created in "SSM" Parameter Store
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a parameter is deleted from "SSM" Parameter Store then a running execution reads an existing parameter and the task succeeds
    Given eid in exec_status
    Given a running execution has failed to read the parameter because it has been deleted
    Given a parameter has been deleted from "SSM" Parameter Store
    When a running execution reads an existing parameter and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed to read the parameter because it has been deleted
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @sequence
  Scenario: a running execution fails to read the parameter because it has been deleted then a running execution reads an existing parameter and the task succeeds then a parameter is created in "SSM" Parameter Store
    Given eid in exec_status
    Given a running execution has failed to read the parameter because it has been deleted
    Given a running execution has read an existing parameter and the task succeeded
    When a parameter is created in "SSM" Parameter Store
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read
