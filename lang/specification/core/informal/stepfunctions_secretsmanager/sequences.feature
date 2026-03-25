@stepfunctionssecretsmanager @generated
Feature: StepfunctionsSecretsmanager - Action Sequences

  # Generated from FizzBee spec: stepfunctions_secretsmanager.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadASecret

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a secret is created in Secrets Manager
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a secret is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a secret is scheduled for deletion
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a secret is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an "ACTIVE" secret and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read the secret because it is pending deletion
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to read the secret because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Step Functions state machine is created
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a secret is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then an execution of the state machine is started
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a running execution reads an "ACTIVE" secret and the task succeeds
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a running execution reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a running execution fails to read the secret because it is pending deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a running execution fails to read the secret because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a Step Functions state machine is created
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a secret is created in Secrets Manager
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a secret is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then an execution of the state machine is started
    Given sid in secret_status
    When a secret is scheduled for deletion
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a running execution reads an "ACTIVE" secret and the task succeeds
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a running execution reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a running execution fails to read the secret because it is pending deletion
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a running execution fails to read the secret because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a secret is created in Secrets Manager
    Given smid in sm_status
    When an execution of the state machine is started
    When a secret is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a secret is scheduled for deletion
    Given smid in sm_status
    When an execution of the state machine is started
    When a secret is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads an "ACTIVE" secret and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read the secret because it is pending deletion
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to read the secret because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a secret is created in Secrets Manager
    Given eid in exec_status
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When a secret is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a secret is scheduled for deletion
    Given eid in exec_status
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When a secret is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a running execution fails to read the secret because it is pending deletion
    Given eid in exec_status
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When a running execution fails to read the secret because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to read the secret because it is pending deletion
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a secret is created in Secrets Manager
    Given eid in exec_status
    When a running execution fails to read the secret because it is pending deletion
    When a secret is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a secret is scheduled for deletion
    Given eid in exec_status
    When a running execution fails to read the secret because it is pending deletion
    When a secret is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to read the secret because it is pending deletion
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a running execution reads an "ACTIVE" secret and the task succeeds
    Given eid in exec_status
    When a running execution fails to read the secret because it is pending deletion
    When a running execution reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a secret is created in Secrets Manager
    When a secret is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a secret is scheduled for deletion then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a secret is scheduled for deletion
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution reads an "ACTIVE" secret and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an "ACTIVE" secret and the task succeeds then a running execution fails to read the secret because it is pending deletion
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When a running execution fails to read the secret because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read the secret because it is pending deletion then a secret is created in Secrets Manager
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to read the secret because it is pending deletion
    When a secret is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Step Functions state machine is created then an execution of the state machine is started
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a secret is scheduled for deletion then a running execution reads an "ACTIVE" secret and the task succeeds
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a secret is scheduled for deletion
    When a running execution reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then an execution of the state machine is started then a running execution fails to read the secret because it is pending deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When an execution of the state machine is started
    When a running execution fails to read the secret because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a running execution reads an "ACTIVE" secret and the task succeeds then a Step Functions state machine is created
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a running execution fails to read the secret because it is pending deletion then a secret is scheduled for deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a running execution fails to read the secret because it is pending deletion
    When a secret is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a Step Functions state machine is created then a running execution reads an "ACTIVE" secret and the task succeeds
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a Step Functions state machine is created
    When a running execution reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a secret is created in Secrets Manager then a running execution fails to read the secret because it is pending deletion
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a secret is created in Secrets Manager
    When a running execution fails to read the secret because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then an execution of the state machine is started then a Step Functions state machine is created
    Given sid in secret_status
    When a secret is scheduled for deletion
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a running execution reads an "ACTIVE" secret and the task succeeds then a secret is created in Secrets Manager
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When a secret is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a running execution fails to read the secret because it is pending deletion then an execution of the state machine is started
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a running execution fails to read the secret because it is pending deletion
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to read the secret because it is pending deletion
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution fails to read the secret because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a secret is created in Secrets Manager then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a secret is created in Secrets Manager
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a secret is scheduled for deletion then a secret is created in Secrets Manager
    Given smid in sm_status
    When an execution of the state machine is started
    When a secret is scheduled for deletion
    When a secret is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads an "ACTIVE" secret and the task succeeds then a secret is scheduled for deletion
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When a secret is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read the secret because it is pending deletion then a running execution reads an "ACTIVE" secret and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to read the secret because it is pending deletion
    When a running execution reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a Step Functions state machine is created then a secret is created in Secrets Manager
    Given eid in exec_status
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When a Step Functions state machine is created
    When a secret is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given eid in exec_status
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When a secret is created in Secrets Manager
    When a secret is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a secret is scheduled for deletion then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When a secret is scheduled for deletion
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then an execution of the state machine is started then a running execution fails to read the secret because it is pending deletion
    Given eid in exec_status
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When an execution of the state machine is started
    When a running execution fails to read the secret because it is pending deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds then a running execution fails to read the secret because it is pending deletion then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When a running execution fails to read the secret because it is pending deletion
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a Step Functions state machine is created then a secret is scheduled for deletion
    Given eid in exec_status
    When a running execution fails to read the secret because it is pending deletion
    When a Step Functions state machine is created
    When a secret is scheduled for deletion
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a secret is created in Secrets Manager then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to read the secret because it is pending deletion
    When a secret is created in Secrets Manager
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a secret is scheduled for deletion then a running execution reads an "ACTIVE" secret and the task succeeds
    Given eid in exec_status
    When a running execution fails to read the secret because it is pending deletion
    When a secret is scheduled for deletion
    When a running execution reads an "ACTIVE" secret and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to read the secret because it is pending deletion
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @exhaustive @sequence
  Scenario: a running execution fails to read the secret because it is pending deletion then a running execution reads an "ACTIVE" secret and the task succeeds then a secret is created in Secrets Manager
    Given eid in exec_status
    When a running execution fails to read the secret because it is pending deletion
    When a running execution reads an "ACTIVE" secret and the task succeeds
    When a secret is created in Secrets Manager
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read
