@stepfunctionscognito @generated
Feature: StepfunctionsCognito - A Running Execution Fails Because The Cognito User Pool Has Been Deleted

  # Generated from FizzBee spec: stepfunctions_cognito.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @cognito_task_fails @internal
  Scenario: a running execution fails because the Cognito user pool has been deleted
    Given an execution is "RUNNING"
    And the pool is "DELETED"
    When a running execution fails because the Cognito user pool has been deleted
    Then the execution is "FAILED" with a ResourceNotFoundException
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @guard @negative @cognito_task_fails @internal
  Scenario: a running execution fails because the Cognito user pool has been deleted fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution fails because the Cognito user pool has been deleted
    Then the operation is rejected

  @guard @negative @cognito_task_fails @internal
  Scenario: a running execution fails because the Cognito user pool has been deleted fails when the pool is not "DELETED"
    Given an execution is "RUNNING"
    And the pool is not "DELETED"
    When a running execution fails because the Cognito user pool has been deleted
    Then the operation is rejected
