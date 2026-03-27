@stepfunctionslambda @generated
Feature: StepfunctionsLambda - A Running Execution Reaches The Lambda Task State And Invokes The Function

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @minimal @happy @invoke_task
  Scenario: a running execution reaches the Lambda task state and invokes the function
    Given an execution is "RUNNING"
    And the execution's state machine has a configured Lambda task
    And the configured function is "ACTIVE"
    And an invocation slot is available
    When a running execution reaches the Lambda task state and invokes the function
    Then the invocation is "IN_PROGRESS"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @standard @negative @invoke_task
  Scenario: a running execution reaches the Lambda task state and invokes the function fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution reaches the Lambda task state and invokes the function
    Then the operation is rejected

  @standard @negative @invoke_task
  Scenario: a running execution reaches the Lambda task state and invokes the function fails when the execution's state machine has no Lambda task configured
    Given an execution is "RUNNING"
    And the execution's state machine has no Lambda task configured
    When a running execution reaches the Lambda task state and invokes the function
    Then the operation is rejected

  @standard @negative @invoke_task @lifecycle
  Scenario: a running execution reaches the Lambda task state and invokes the function fails when the configured function is not "ACTIVE"
    Given an execution is "RUNNING"
    And the execution's state machine has a configured Lambda task
    And the configured function is not "ACTIVE"
    When a running execution reaches the Lambda task state and invokes the function
    Then the operation is rejected

  @standard @negative @internal @invoke_task @capacity
  Scenario: a running execution reaches the Lambda task state and invokes the function fails when no invocation slot is available
    Given an execution is "RUNNING"
    And the execution's state machine has a configured Lambda task
    And the configured function is "ACTIVE"
    And no invocation slot is available
    When a running execution reaches the Lambda task state and invokes the function
    Then the operation is rejected
