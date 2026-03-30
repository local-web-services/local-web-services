@stepfunctionssecretsmanager @generated
Feature: StepfunctionsSecretsmanager - Action Sequences

  # Generated from FizzBee spec: stepfunctions_secretsmanager.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadASecret

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Step Functions state machine is created then a secret is created in Secrets Manager
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a secret is created in Secrets Manager
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a Step Functions state machine is created then a secret is scheduled for deletion
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a secret is scheduled for deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an "ACTIVE" secret and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution reads an "ACTIVE" secret and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read the secret because it is pending deletion
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution fails to read the secret because it is pending deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is created in Secrets Manager then a Step Functions state machine is created
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When a secret is scheduled for deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is created in Secrets Manager then an execution of the state machine is started
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is created in Secrets Manager then a running execution reads an "ACTIVE" secret and the task succeeds
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When a running execution reads an "ACTIVE" secret and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is created in Secrets Manager then a running execution fails to read the secret because it is pending deletion
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When a running execution fails to read the secret because it is pending deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is scheduled for deletion then a Step Functions state machine is created
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is scheduled for deletion then a secret is created in Secrets Manager
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    When a secret is created in Secrets Manager
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is scheduled for deletion then an execution of the state machine is started
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is scheduled for deletion then a running execution reads an "ACTIVE" secret and the task succeeds
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    When a running execution reads an "ACTIVE" secret and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is scheduled for deletion then a running execution fails to read the secret because it is pending deletion
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    When a running execution fails to read the secret because it is pending deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an execution of the state machine is started then a secret is created in Secrets Manager
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a secret is created in Secrets Manager
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an execution of the state machine is started then a secret is scheduled for deletion
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a secret is scheduled for deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an execution of the state machine is started then a running execution reads an "ACTIVE" secret and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution reads an "ACTIVE" secret and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read the secret because it is pending deletion
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution fails to read the secret because it is pending deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a secret is created in Secrets Manager
    Given eid in exec_status
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    When a secret is created in Secrets Manager
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a secret is scheduled for deletion
    Given eid in exec_status
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    When a secret is scheduled for deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a running execution fails to read the secret because it is pending deletion
    Given eid in exec_status
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    When a running execution fails to read the secret because it is pending deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed to read the secret because it is pending deletion
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a secret is created in Secrets Manager
    Given eid in exec_status
    Given a running execution has failed to read the secret because it is pending deletion
    When a secret is created in Secrets Manager
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a secret is scheduled for deletion
    Given eid in exec_status
    Given a running execution has failed to read the secret because it is pending deletion
    When a secret is scheduled for deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed to read the secret because it is pending deletion
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a running execution reads an "ACTIVE" secret and the task succeeds
    Given eid in exec_status
    Given a running execution has failed to read the secret because it is pending deletion
    When a running execution reads an "ACTIVE" secret and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a Step Functions state machine is created then a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a secret has been created in Secrets Manager
    When a secret is scheduled for deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a Step Functions state machine is created then a secret is scheduled for deletion then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a secret has been scheduled for deletion
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution reads an "ACTIVE" secret and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution reads an "ACTIVE" secret and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an "ACTIVE" secret and the task succeeds then a running execution fails to read the secret because it is pending deletion
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    When a running execution fails to read the secret because it is pending deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read the secret because it is pending deletion then a secret is created in Secrets Manager
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has failed to read the secret because it is pending deletion
    When a secret is created in Secrets Manager
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is created in Secrets Manager then a Step Functions state machine is created then an execution of the state machine is started
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is created in Secrets Manager then a secret is scheduled for deletion then a running execution reads an "ACTIVE" secret and the task succeeds
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given a secret has been scheduled for deletion
    When a running execution reads an "ACTIVE" secret and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is created in Secrets Manager then an execution of the state machine is started then a running execution fails to read the secret because it is pending deletion
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given an execution of the state machine has been started
    When a running execution fails to read the secret because it is pending deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is created in Secrets Manager then a running execution reads an "ACTIVE" secret and the task succeeds then a Step Functions state machine is created
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is created in Secrets Manager then a running execution fails to read the secret because it is pending deletion then a secret is scheduled for deletion
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given a running execution has failed to read the secret because it is pending deletion
    When a secret is scheduled for deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is scheduled for deletion then a Step Functions state machine is created then a running execution reads an "ACTIVE" secret and the task succeeds
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    Given a Step Functions state machine has been created
    When a running execution reads an "ACTIVE" secret and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is scheduled for deletion then a secret is created in Secrets Manager then a running execution fails to read the secret because it is pending deletion
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    Given a secret has been created in Secrets Manager
    When a running execution fails to read the secret because it is pending deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is scheduled for deletion then an execution of the state machine is started then a Step Functions state machine is created
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is scheduled for deletion then a running execution reads an "ACTIVE" secret and the task succeeds then a secret is created in Secrets Manager
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    When a secret is created in Secrets Manager
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a secret is scheduled for deletion then a running execution fails to read the secret because it is pending deletion then an execution of the state machine is started
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    Given a running execution has failed to read the secret because it is pending deletion
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to read the secret because it is pending deletion
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When a running execution fails to read the secret because it is pending deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an execution of the state machine is started then a secret is created in Secrets Manager then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a secret has been created in Secrets Manager
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an execution of the state machine is started then a secret is scheduled for deletion then a secret is created in Secrets Manager
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a secret has been scheduled for deletion
    When a secret is created in Secrets Manager
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an execution of the state machine is started then a running execution reads an "ACTIVE" secret and the task succeeds then a secret is scheduled for deletion
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    When a secret is scheduled for deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read the secret because it is pending deletion then a running execution reads an "ACTIVE" secret and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has failed to read the secret because it is pending deletion
    When a running execution reads an "ACTIVE" secret and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a Step Functions state machine is created then a secret is created in Secrets Manager
    Given eid in exec_status
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    Given a Step Functions state machine has been created
    When a secret is created in Secrets Manager
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given eid in exec_status
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    Given a secret has been created in Secrets Manager
    When a secret is scheduled for deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a secret is scheduled for deletion then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    Given a secret has been scheduled for deletion
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then an execution of the state machine is started then a running execution fails to read the secret because it is pending deletion
    Given eid in exec_status
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    Given an execution of the state machine has been started
    When a running execution fails to read the secret because it is pending deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a running execution fails to read the secret because it is pending deletion then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    Given a running execution has failed to read the secret because it is pending deletion
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a Step Functions state machine is created then a secret is scheduled for deletion
    Given eid in exec_status
    Given a running execution has failed to read the secret because it is pending deletion
    Given a Step Functions state machine has been created
    When a secret is scheduled for deletion
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a secret is created in Secrets Manager then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed to read the secret because it is pending deletion
    Given a secret has been created in Secrets Manager
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a secret is scheduled for deletion then a running execution reads an "ACTIVE" secret and the task succeeds
    Given eid in exec_status
    Given a running execution has failed to read the secret because it is pending deletion
    Given a secret has been scheduled for deletion
    When a running execution reads an "ACTIVE" secret and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed to read the secret because it is pending deletion
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a running execution reads an "ACTIVE" secret and the task succeeds then a secret is created in Secrets Manager
    Given eid in exec_status
    Given a running execution has failed to read the secret because it is pending deletion
    Given a running execution has read an "ACTIVE" secret and the task succeeded
    When a secret is created in Secrets Manager
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read
