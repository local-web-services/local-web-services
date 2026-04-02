@stepfunctionss3tables @generated
Feature: StepfunctionsS3tables - A "Step Functions" "State Machine" Is Created

  # Generated from FizzBee spec: stepfunctions_s3tables.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledATable

  Background:
    Given the system is initialized

  @minimal @happy @create_state_machine
  Scenario: a "step functions" "state machine" is created
    Given the "step functions" "state machine" did not already exist
    When a "step functions" "state machine" is created
    Then the "step functions" "state machine" will be "ACTIVE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @guard @negative @create_state_machine
  Scenario: a "step functions" "state machine" is created fails when the "step functions" "state machine" already existed
    Given the "step functions" "state machine" already existed
    When a "step functions" "state machine" is created
    Then the operation is rejected
