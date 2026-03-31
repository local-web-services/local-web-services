@stepfunctionslambda @generated
Feature: StepfunctionsLambda - Action Sequences

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "lambda" "function" is deployed
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "lambda" "function" is deployed
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "step functions" "state machine" is created then a Lambda task is configured on the state machine
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a Lambda task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "step functions" "state machine" is created then the Lambda task completes successfully and the execution succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the Lambda task completes successfully and the execution succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "step functions" "state machine" is created then the Lambda task fails and the execution fails
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the Lambda task fails and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "lambda" "function" is deployed then a "step functions" "state machine" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "lambda" "function" is deployed then a Lambda task is configured on the state machine
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a Lambda task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "lambda" "function" is deployed then an "step functions" "execution" of the "step functions" "state machine" is started
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "lambda" "function" is deployed then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda task completes successfully and the execution succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda task completes successfully and the execution succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda task fails and the execution fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda task fails and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a Lambda task is configured on the state machine then a "step functions" "state machine" is created
    Given smid in sm_status
    When a Lambda task is configured on the state machine
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a Lambda task is configured on the state machine then a "lambda" "function" is deployed
    Given smid in sm_status
    When a Lambda task is configured on the state machine
    When a "lambda" "function" is deployed
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a Lambda task is configured on the state machine then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid in sm_status
    When a Lambda task is configured on the state machine
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a Lambda task is configured on the state machine then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given smid in sm_status
    When a Lambda task is configured on the state machine
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a Lambda task is configured on the state machine then the Lambda task completes successfully and the execution succeeds
    Given smid in sm_status
    When a Lambda task is configured on the state machine
    When the Lambda task completes successfully and the execution succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a Lambda task is configured on the state machine then the Lambda task fails and the execution fails
    Given smid in sm_status
    When a Lambda task is configured on the state machine
    When the Lambda task fails and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "lambda" "function" is deployed
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "lambda" "function" is deployed
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a Lambda task is configured on the state machine
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a Lambda task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the Lambda task completes successfully and the execution succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the Lambda task completes successfully and the execution succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the Lambda task fails and the execution fails
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the Lambda task fails and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "lambda" "function" is deployed
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "lambda" "function" is deployed
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then a Lambda task is configured on the state machine
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a Lambda task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then the Lambda task completes successfully and the execution succeeds
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the Lambda task completes successfully and the execution succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then the Lambda task fails and the execution fails
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the Lambda task fails and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a "step functions" "state machine" is created
    Given iid in inv_status
    When the Lambda task completes successfully and the execution succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda task completes successfully and the execution succeeds
    When a "lambda" "function" is deployed
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a Lambda task is configured on the state machine
    Given iid in inv_status
    When the Lambda task completes successfully and the execution succeeds
    When a Lambda task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given iid in inv_status
    When the Lambda task completes successfully and the execution succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given iid in inv_status
    When the Lambda task completes successfully and the execution succeeds
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then the Lambda task fails and the execution fails
    Given iid in inv_status
    When the Lambda task completes successfully and the execution succeeds
    When the Lambda task fails and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task fails and the execution fails then a "step functions" "state machine" is created
    Given iid in inv_status
    When the Lambda task fails and the execution fails
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task fails and the execution fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda task fails and the execution fails
    When a "lambda" "function" is deployed
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task fails and the execution fails then a Lambda task is configured on the state machine
    Given iid in inv_status
    When the Lambda task fails and the execution fails
    When a Lambda task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task fails and the execution fails then an "step functions" "execution" of the "step functions" "state machine" is started
    Given iid in inv_status
    When the Lambda task fails and the execution fails
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task fails and the execution fails then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given iid in inv_status
    When the Lambda task fails and the execution fails
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task fails and the execution fails then the Lambda task completes successfully and the execution succeeds
    Given iid in inv_status
    When the Lambda task fails and the execution fails
    When the Lambda task completes successfully and the execution succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "step functions" "state machine" is created then a "lambda" "function" is deployed then a Lambda task is configured on the state machine
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "lambda" "function" is deployed
    When a Lambda task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "step functions" "state machine" is created then a Lambda task is configured on the state machine then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a Lambda task is configured on the state machine
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reaches the Lambda task state and invokes the function then the Lambda task completes successfully and the execution succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the Lambda task completes successfully and the execution succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "step functions" "state machine" is created then the Lambda task completes successfully and the execution succeeds then the Lambda task fails and the execution fails
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the Lambda task completes successfully and the execution succeeds
    When the Lambda task fails and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "step functions" "state machine" is created then the Lambda task fails and the execution fails then a "lambda" "function" is deployed
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the Lambda task fails and the execution fails
    When a "lambda" "function" is deployed
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "lambda" "function" is deployed then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "lambda" "function" is deployed then a Lambda task is configured on the state machine then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a Lambda task is configured on the state machine
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "lambda" "function" is deployed then an "step functions" "execution" of the "step functions" "state machine" is started then the Lambda task completes successfully and the execution succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the Lambda task completes successfully and the execution succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "lambda" "function" is deployed then a running "step functions" "execution" reaches the Lambda task state and invokes the function then the Lambda task fails and the execution fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the Lambda task fails and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda task completes successfully and the execution succeeds then a "step functions" "state machine" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda task completes successfully and the execution succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda task fails and the execution fails then a Lambda task is configured on the state machine
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda task fails and the execution fails
    When a Lambda task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a Lambda task is configured on the state machine then a "step functions" "state machine" is created then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given smid in sm_status
    When a Lambda task is configured on the state machine
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a Lambda task is configured on the state machine then a "lambda" "function" is deployed then the Lambda task completes successfully and the execution succeeds
    Given smid in sm_status
    When a Lambda task is configured on the state machine
    When a "lambda" "function" is deployed
    When the Lambda task completes successfully and the execution succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a Lambda task is configured on the state machine then an "step functions" "execution" of the "step functions" "state machine" is started then the Lambda task fails and the execution fails
    Given smid in sm_status
    When a Lambda task is configured on the state machine
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the Lambda task fails and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a Lambda task is configured on the state machine then a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "step functions" "state machine" is created
    Given smid in sm_status
    When a Lambda task is configured on the state machine
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a Lambda task is configured on the state machine then the Lambda task completes successfully and the execution succeeds then a "lambda" "function" is deployed
    Given smid in sm_status
    When a Lambda task is configured on the state machine
    When the Lambda task completes successfully and the execution succeeds
    When a "lambda" "function" is deployed
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a Lambda task is configured on the state machine then the Lambda task fails and the execution fails then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid in sm_status
    When a Lambda task is configured on the state machine
    When the Lambda task fails and the execution fails
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then the Lambda task completes successfully and the execution succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When the Lambda task completes successfully and the execution succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "lambda" "function" is deployed then the Lambda task fails and the execution fails
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "lambda" "function" is deployed
    When the Lambda task fails and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a Lambda task is configured on the state machine then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a Lambda task is configured on the state machine
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "lambda" "function" is deployed
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "lambda" "function" is deployed
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the Lambda task completes successfully and the execution succeeds then a Lambda task is configured on the state machine
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the Lambda task completes successfully and the execution succeeds
    When a Lambda task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the Lambda task fails and the execution fails then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the Lambda task fails and the execution fails
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "step functions" "state machine" is created then the Lambda task fails and the execution fails
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "step functions" "state machine" is created
    When the Lambda task fails and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "lambda" "function" is deployed then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "lambda" "function" is deployed
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then a Lambda task is configured on the state machine then a "lambda" "function" is deployed
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a Lambda task is configured on the state machine
    When a "lambda" "function" is deployed
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then an "step functions" "execution" of the "step functions" "state machine" is started then a Lambda task is configured on the state machine
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a Lambda task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then the Lambda task completes successfully and the execution succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the Lambda task completes successfully and the execution succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then the Lambda task fails and the execution fails then the Lambda task completes successfully and the execution succeeds
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the Lambda task fails and the execution fails
    When the Lambda task completes successfully and the execution succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a "step functions" "state machine" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda task completes successfully and the execution succeeds
    When a "step functions" "state machine" is created
    When a "lambda" "function" is deployed
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a "lambda" "function" is deployed then a Lambda task is configured on the state machine
    Given iid in inv_status
    When the Lambda task completes successfully and the execution succeeds
    When a "lambda" "function" is deployed
    When a Lambda task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a Lambda task is configured on the state machine then an "step functions" "execution" of the "step functions" "state machine" is started
    Given iid in inv_status
    When the Lambda task completes successfully and the execution succeeds
    When a Lambda task is configured on the state machine
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given iid in inv_status
    When the Lambda task completes successfully and the execution succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a running "step functions" "execution" reaches the Lambda task state and invokes the function then the Lambda task fails and the execution fails
    Given iid in inv_status
    When the Lambda task completes successfully and the execution succeeds
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the Lambda task fails and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then the Lambda task fails and the execution fails then a "step functions" "state machine" is created
    Given iid in inv_status
    When the Lambda task completes successfully and the execution succeeds
    When the Lambda task fails and the execution fails
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task fails and the execution fails then a "step functions" "state machine" is created then a Lambda task is configured on the state machine
    Given iid in inv_status
    When the Lambda task fails and the execution fails
    When a "step functions" "state machine" is created
    When a Lambda task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task fails and the execution fails then a "lambda" "function" is deployed then an "step functions" "execution" of the "step functions" "state machine" is started
    Given iid in inv_status
    When the Lambda task fails and the execution fails
    When a "lambda" "function" is deployed
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task fails and the execution fails then a Lambda task is configured on the state machine then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given iid in inv_status
    When the Lambda task fails and the execution fails
    When a Lambda task is configured on the state machine
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task fails and the execution fails then an "step functions" "execution" of the "step functions" "state machine" is started then the Lambda task completes successfully and the execution succeeds
    Given iid in inv_status
    When the Lambda task fails and the execution fails
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the Lambda task completes successfully and the execution succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task fails and the execution fails then a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "step functions" "state machine" is created
    Given iid in inv_status
    When the Lambda task fails and the execution fails
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @sequence
  Scenario: the Lambda task fails and the execution fails then the Lambda task completes successfully and the execution succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda task fails and the execution fails
    When the Lambda task completes successfully and the execution succeeds
    When a "lambda" "function" is deployed
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution
