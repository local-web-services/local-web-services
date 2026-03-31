@stepfunctionscognito @generated
Feature: StepfunctionsCognito - A "Cognito" "User Pool" Is Deleted

  # Generated from FizzBee spec: stepfunctions_cognito.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @delete_user_pool
  Scenario: a "cognito" "user pool" is deleted
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    When a "cognito" "user pool" is deleted
    Then the "cognito" "user pool" will be deleted and "SDK" task calls targeting it will fail
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @guard @negative @delete_user_pool
  Scenario: a "cognito" "user pool" is deleted fails when the "cognito" "user pool" did not exist
    Given the "cognito" "user pool" did not exist
    When a "cognito" "user pool" is deleted
    Then the operation is rejected

  @guard @negative @delete_user_pool @lifecycle
  Scenario: a "cognito" "user pool" is deleted fails when the "cognito" "user pool" is already "DELETED"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" is already "DELETED"
    When a "cognito" "user pool" is deleted
    Then the operation is rejected
