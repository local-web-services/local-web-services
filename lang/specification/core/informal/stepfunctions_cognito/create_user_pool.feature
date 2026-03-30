@stepfunctionscognito @generated
Feature: StepfunctionsCognito - A Cognito User Pool Is Created

  # Generated from FizzBee spec: stepfunctions_cognito.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @create_user_pool
  Scenario: a Cognito user pool is created
    Given the pool does not already exist
    When a Cognito user pool is created
    Then the pool is "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @guard @negative @create_user_pool
  Scenario: a Cognito user pool is created fails when the pool already exists
    Given the pool already exists
    When a Cognito user pool is created
    Then the operation is rejected
