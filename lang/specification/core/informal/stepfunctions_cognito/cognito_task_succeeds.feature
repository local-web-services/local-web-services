@stepfunctionscognito @generated
Feature: StepfunctionsCognito - A Running Execution Calls An Active Cognito User Pool And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_cognito.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @cognito_task_succeeds @internal
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Given an execution is "RUNNING"
    And the pool is "ACTIVE"
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Then the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @standard @negative @cognito_task_succeeds @internal
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Then the operation is rejected

  @standard @negative @cognito_task_succeeds @internal
  Scenario: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds fails when the pool does not exist or is "DELETED"
    Given an execution is "RUNNING"
    And the pool does not exist or is "DELETED"
    When a running execution calls an "ACTIVE" Cognito user pool and the task succeeds
    Then the operation is rejected
