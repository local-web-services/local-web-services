@stepfunctionsrds @generated
Feature: StepfunctionsRds - An Rds Db Instance Is Created

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: an "RDS" "DB" instance is created
    Given the "DB" instance does not already exist
    When an "RDS" "DB" instance is created
    Then the "DB" instance is "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @guard @negative @create_d_b_instance
  Scenario: an "RDS" "DB" instance is created fails when the "DB" instance already exists
    Given the "DB" instance already exists
    When an "RDS" "DB" instance is created
    Then the operation is rejected
