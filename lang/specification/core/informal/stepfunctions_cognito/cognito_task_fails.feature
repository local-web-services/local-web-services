@stepfunctionscognito @generated
Feature: StepfunctionsCognito - A Running "Step Functions" "Execution" Fails Because The "Cognito" "User Pool" Has Been Deleted

  # Generated from FizzBee spec: stepfunctions_cognito.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @cognito_task_fails @internal
  Scenario: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Given a "step functions" "execution" was "RUNNING"
    And the "cognito" "user pool" was "DELETED"
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Then the "step functions" "execution" will be "FAILED" with a ResourceNotFoundException
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which pool it called

  @guard @negative @cognito_task_fails @internal
  Scenario: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Then the operation is rejected

  @guard @negative @cognito_task_fails @internal
  Scenario: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted fails when the "cognito" "user pool" was not "DELETED"
    Given a "step functions" "execution" was "RUNNING"
    And the "cognito" "user pool" was not "DELETED"
    When a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted
    Then the operation is rejected
