@stepfunctionselasticsearch @generated
Feature: StepfunctionsElasticsearch - A Step Functions State Machine Is Created

  # Generated from FizzBee spec: stepfunctions_elasticsearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @create_state_machine
  Scenario: a Step Functions state machine is created
    Given the state machine does not already exist
    When a Step Functions state machine is created
    Then the state machine is "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @standard @negative @create_state_machine
  Scenario: a Step Functions state machine is created fails when the state machine already exists
    Given the state machine already exists
    When a Step Functions state machine is created
    Then the operation is rejected
