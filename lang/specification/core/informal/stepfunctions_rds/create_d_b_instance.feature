@stepfunctionsrds @generated
Feature: StepfunctionsRds - An "Rds" "Db Instance" Is Created

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: an "rds" "DB instance" is created
    Given the "rds" "instance" did not already exist
    When an "rds" "DB instance" is created
    Then the "rds" "DB instance" will be "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "rds" "DB instance" it queried

  @guard @negative @create_d_b_instance
  Scenario: an "rds" "DB instance" is created fails when the "rds" "instance" already existed
    Given the "rds" "instance" already existed
    When an "rds" "DB instance" is created
    Then the operation is rejected
