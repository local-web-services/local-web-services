@stepfunctionscognito @generated
Feature: StepfunctionsCognito - A Cognito User Pool Is Deleted

  # Generated from FizzBee spec: stepfunctions_cognito.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @delete_user_pool
  Scenario: a Cognito user pool is deleted
    Given the pool exists
    And the pool is "ACTIVE"
    When a Cognito user pool is deleted
    Then the pool is "DELETED" and "SDK" task calls targeting it will fail
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @guard @negative @delete_user_pool
  Scenario: a Cognito user pool is deleted fails when the pool does not exist
    Given the pool does not exist
    When a Cognito user pool is deleted
    Then the operation is rejected

  @guard @negative @delete_user_pool @lifecycle
  Scenario: a Cognito user pool is deleted fails when the pool is already "DELETED"
    Given the pool exists
    And the pool is already "DELETED"
    When a Cognito user pool is deleted
    Then the operation is rejected
