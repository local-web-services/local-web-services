@stepfunctionscognito @generated
Feature: StepfunctionsCognito - A Running "Step Functions" "Execution" Calls An Active Cognito User Pool And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_cognito.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @cognito_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the "cognito" "user pool" was "ACTIVE"
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "cognito" "user pool" it called

  @guard @negative @cognito_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Then the operation is rejected

  @guard @negative @cognito_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds fails when the "cognito" "user pool" did not exist or was "DELETED"
    Given a "step functions" "execution" was "RUNNING"
    And the "cognito" "user pool" did not exist or was "DELETED"
    When a running "step functions" "execution" calls an "ACTIVE" Cognito user pool and the task succeeds
    Then the operation is rejected
