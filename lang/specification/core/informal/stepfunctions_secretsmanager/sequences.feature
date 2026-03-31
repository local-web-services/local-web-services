@stepfunctionssecretsmanager @generated
Feature: StepfunctionsSecretsmanager - Action Sequences

  # Generated from FizzBee spec: stepfunctions_secretsmanager.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadASecret

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "secretsmanager" "secret" is created in Secrets Manager
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a "secretsmanager" "secret" is scheduled for deletion
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a "step functions" "state machine" is created
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a "secretsmanager" "secret" is scheduled for deletion
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then an "step functions" "execution" of the "step functions" "state machine" is started
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then a "step functions" "state machine" is created
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then a "secretsmanager" "secret" is created in Secrets Manager
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then an "step functions" "execution" of the "step functions" "state machine" is started
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "secretsmanager" "secret" is created in Secrets Manager
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "secretsmanager" "secret" is scheduled for deletion
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then a "secretsmanager" "secret" is created in Secrets Manager
    Given eid in exec_status
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then a "secretsmanager" "secret" is scheduled for deletion
    Given eid in exec_status
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Given eid in exec_status
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then a "secretsmanager" "secret" is created in Secrets Manager
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then a "secretsmanager" "secret" is scheduled for deletion
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a "secretsmanager" "secret" is created in Secrets Manager then a "secretsmanager" "secret" is scheduled for deletion
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a "secretsmanager" "secret" is scheduled for deletion then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "secretsmanager" "secret" is scheduled for deletion
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then a "secretsmanager" "secret" is created in Secrets Manager
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a "secretsmanager" "secret" is scheduled for deletion then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "secretsmanager" "secret" is scheduled for deletion
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then a "step functions" "state machine" is created
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then a "secretsmanager" "secret" is scheduled for deletion
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then a "step functions" "state machine" is created then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then a "secretsmanager" "secret" is created in Secrets Manager then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then a "secretsmanager" "secret" is created in Secrets Manager
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then an "step functions" "execution" of the "step functions" "state machine" is started
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "secretsmanager" "secret" is created in Secrets Manager then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "secretsmanager" "secret" is scheduled for deletion then a "secretsmanager" "secret" is created in Secrets Manager
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "secretsmanager" "secret" is scheduled for deletion
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then a "secretsmanager" "secret" is scheduled for deletion
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then a "step functions" "state machine" is created then a "secretsmanager" "secret" is created in Secrets Manager
    Given eid in exec_status
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When a "step functions" "state machine" is created
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then a "secretsmanager" "secret" is created in Secrets Manager then a "secretsmanager" "secret" is scheduled for deletion
    Given eid in exec_status
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then a "secretsmanager" "secret" is scheduled for deletion then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When a "secretsmanager" "secret" is scheduled for deletion
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Given eid in exec_status
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then a "step functions" "state machine" is created then a "secretsmanager" "secret" is scheduled for deletion
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When a "step functions" "state machine" is created
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then a "secretsmanager" "secret" is created in Secrets Manager then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When a "secretsmanager" "secret" is created in Secrets Manager
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then a "secretsmanager" "secret" is scheduled for deletion then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When a "secretsmanager" "secret" is scheduled for deletion
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @sequence
  Scenario: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion then a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds then a "secretsmanager" "secret" is created in Secrets Manager
    Given eid in exec_status
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read
