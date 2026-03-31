@stepfunctionscognito @generated
Feature: StepfunctionsCognito - A "Cognito" "User Pool" Is Created

  # Generated from FizzBee spec: stepfunctions_cognito.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @create_user_pool
  Scenario: a "cognito" "user pool" is created
    Given the "cognito" "user pool" did not already exist
    When a "cognito" "user pool" is created
    Then the "cognito" "user pool" will be "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @guard @negative @create_user_pool
  Scenario: a "cognito" "user pool" is created fails when the "cognito" "user pool" already existed
    Given the "cognito" "user pool" already existed
    When a "cognito" "user pool" is created
    Then the operation is rejected
