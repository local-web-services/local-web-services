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
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "step functions" "state machine" is created then a "lambda" task is configured on the "step functions" "state machine"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "lambda" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "step functions" "state machine" is created then the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "step functions" "state machine" is created then the "lambda" task fails and the "step functions" "execution" fails
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "lambda" task fails and the "step functions" "execution" fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "step functions" "state machine" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "lambda" task is configured on the "step functions" "state machine"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "lambda" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "step functions" "execution" of the "step functions" "state machine" is started
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" "function" is deployed then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" task fails and the "step functions" "execution" fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" task fails and the "step functions" "execution" fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" task is configured on the "step functions" "state machine" then a "step functions" "state machine" is created
    Given smid in sm_status
    When a "lambda" task is configured on the "step functions" "state machine"
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" task is configured on the "step functions" "state machine" then a "lambda" "function" is deployed
    Given smid in sm_status
    When a "lambda" task is configured on the "step functions" "state machine"
    When a "lambda" "function" is deployed
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" task is configured on the "step functions" "state machine" then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid in sm_status
    When a "lambda" task is configured on the "step functions" "state machine"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" task is configured on the "step functions" "state machine" then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given smid in sm_status
    When a "lambda" task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" task is configured on the "step functions" "state machine" then the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Given smid in sm_status
    When a "lambda" task is configured on the "step functions" "state machine"
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" task is configured on the "step functions" "state machine" then the "lambda" task fails and the "step functions" "execution" fails
    Given smid in sm_status
    When a "lambda" task is configured on the "step functions" "state machine"
    When the "lambda" task fails and the "step functions" "execution" fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "lambda" "function" is deployed
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "lambda" "function" is deployed
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "lambda" task is configured on the "step functions" "state machine"
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "lambda" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "lambda" task fails and the "step functions" "execution" fails
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "lambda" task fails and the "step functions" "execution" fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "lambda" "function" is deployed
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "lambda" "function" is deployed
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "lambda" task is configured on the "step functions" "state machine"
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "lambda" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then the "lambda" task fails and the "step functions" "execution" fails
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the "lambda" task fails and the "step functions" "execution" fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds then a "step functions" "state machine" is created
    Given iid in inv_status
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When a "lambda" "function" is deployed
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds then a "lambda" task is configured on the "step functions" "state machine"
    Given iid in inv_status
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When a "lambda" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given iid in inv_status
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given iid in inv_status
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds then the "lambda" task fails and the "step functions" "execution" fails
    Given iid in inv_status
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When the "lambda" task fails and the "step functions" "execution" fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task fails and the "step functions" "execution" fails then a "step functions" "state machine" is created
    Given iid in inv_status
    When the "lambda" task fails and the "step functions" "execution" fails
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task fails and the "step functions" "execution" fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" task fails and the "step functions" "execution" fails
    When a "lambda" "function" is deployed
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task fails and the "step functions" "execution" fails then a "lambda" task is configured on the "step functions" "state machine"
    Given iid in inv_status
    When the "lambda" task fails and the "step functions" "execution" fails
    When a "lambda" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task fails and the "step functions" "execution" fails then an "step functions" "execution" of the "step functions" "state machine" is started
    Given iid in inv_status
    When the "lambda" task fails and the "step functions" "execution" fails
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task fails and the "step functions" "execution" fails then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given iid in inv_status
    When the "lambda" task fails and the "step functions" "execution" fails
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task fails and the "step functions" "execution" fails then the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Given iid in inv_status
    When the "lambda" task fails and the "step functions" "execution" fails
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "step functions" "state machine" is created then a "lambda" "function" is deployed then a "lambda" task is configured on the "step functions" "state machine"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "lambda" "function" is deployed
    When a "lambda" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "step functions" "state machine" is created then a "lambda" task is configured on the "step functions" "state machine" then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "lambda" task is configured on the "step functions" "state machine"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reaches the Lambda task state and invokes the function then the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "step functions" "state machine" is created then the "lambda" task completes successfully and the "step functions" "execution" succeeds then the "lambda" task fails and the "step functions" "execution" fails
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When the "lambda" task fails and the "step functions" "execution" fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "step functions" "state machine" is created then the "lambda" task fails and the "step functions" "execution" fails then a "lambda" "function" is deployed
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "lambda" task fails and the "step functions" "execution" fails
    When a "lambda" "function" is deployed
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "lambda" task is configured on the "step functions" "state machine" then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "lambda" task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "step functions" "execution" of the "step functions" "state machine" is started then the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" "function" is deployed then a running "step functions" "execution" reaches the Lambda task state and invokes the function then the "lambda" task fails and the "step functions" "execution" fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the "lambda" task fails and the "step functions" "execution" fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" task completes successfully and the "step functions" "execution" succeeds then a "step functions" "state machine" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" task fails and the "step functions" "execution" fails then a "lambda" task is configured on the "step functions" "state machine"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" task fails and the "step functions" "execution" fails
    When a "lambda" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" task is configured on the "step functions" "state machine" then a "step functions" "state machine" is created then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given smid in sm_status
    When a "lambda" task is configured on the "step functions" "state machine"
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" task is configured on the "step functions" "state machine" then a "lambda" "function" is deployed then the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Given smid in sm_status
    When a "lambda" task is configured on the "step functions" "state machine"
    When a "lambda" "function" is deployed
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" task is configured on the "step functions" "state machine" then an "step functions" "execution" of the "step functions" "state machine" is started then the "lambda" task fails and the "step functions" "execution" fails
    Given smid in sm_status
    When a "lambda" task is configured on the "step functions" "state machine"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "lambda" task fails and the "step functions" "execution" fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" task is configured on the "step functions" "state machine" then a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "step functions" "state machine" is created
    Given smid in sm_status
    When a "lambda" task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" task is configured on the "step functions" "state machine" then the "lambda" task completes successfully and the "step functions" "execution" succeeds then a "lambda" "function" is deployed
    Given smid in sm_status
    When a "lambda" task is configured on the "step functions" "state machine"
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When a "lambda" "function" is deployed
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a "lambda" task is configured on the "step functions" "state machine" then the "lambda" task fails and the "step functions" "execution" fails then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid in sm_status
    When a "lambda" task is configured on the "step functions" "state machine"
    When the "lambda" task fails and the "step functions" "execution" fails
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "lambda" "function" is deployed then the "lambda" task fails and the "step functions" "execution" fails
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "lambda" "function" is deployed
    When the "lambda" task fails and the "step functions" "execution" fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "lambda" task is configured on the "step functions" "state machine" then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "lambda" task is configured on the "step functions" "state machine"
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "lambda" "function" is deployed
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "lambda" "function" is deployed
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "lambda" task completes successfully and the "step functions" "execution" succeeds then a "lambda" task is configured on the "step functions" "state machine"
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When a "lambda" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "lambda" task fails and the "step functions" "execution" fails then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "lambda" task fails and the "step functions" "execution" fails
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "step functions" "state machine" is created then the "lambda" task fails and the "step functions" "execution" fails
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "step functions" "state machine" is created
    When the "lambda" task fails and the "step functions" "execution" fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "lambda" "function" is deployed then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "lambda" "function" is deployed
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "lambda" task is configured on the "step functions" "state machine" then a "lambda" "function" is deployed
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "lambda" task is configured on the "step functions" "state machine"
    When a "lambda" "function" is deployed
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then an "step functions" "execution" of the "step functions" "state machine" is started then a "lambda" task is configured on the "step functions" "state machine"
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "lambda" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then the "lambda" task completes successfully and the "step functions" "execution" succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: a running "step functions" "execution" reaches the Lambda task state and invokes the function then the "lambda" task fails and the "step functions" "execution" fails then the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Given eid in exec_status
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the "lambda" task fails and the "step functions" "execution" fails
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds then a "step functions" "state machine" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When a "step functions" "state machine" is created
    When a "lambda" "function" is deployed
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds then a "lambda" "function" is deployed then a "lambda" task is configured on the "step functions" "state machine"
    Given iid in inv_status
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When a "lambda" "function" is deployed
    When a "lambda" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds then a "lambda" task is configured on the "step functions" "state machine" then an "step functions" "execution" of the "step functions" "state machine" is started
    Given iid in inv_status
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When a "lambda" task is configured on the "step functions" "state machine"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given iid in inv_status
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds then a running "step functions" "execution" reaches the Lambda task state and invokes the function then the "lambda" task fails and the "step functions" "execution" fails
    Given iid in inv_status
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When the "lambda" task fails and the "step functions" "execution" fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task completes successfully and the "step functions" "execution" succeeds then the "lambda" task fails and the "step functions" "execution" fails then a "step functions" "state machine" is created
    Given iid in inv_status
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When the "lambda" task fails and the "step functions" "execution" fails
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task fails and the "step functions" "execution" fails then a "step functions" "state machine" is created then a "lambda" task is configured on the "step functions" "state machine"
    Given iid in inv_status
    When the "lambda" task fails and the "step functions" "execution" fails
    When a "step functions" "state machine" is created
    When a "lambda" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task fails and the "step functions" "execution" fails then a "lambda" "function" is deployed then an "step functions" "execution" of the "step functions" "state machine" is started
    Given iid in inv_status
    When the "lambda" task fails and the "step functions" "execution" fails
    When a "lambda" "function" is deployed
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task fails and the "step functions" "execution" fails then a "lambda" task is configured on the "step functions" "state machine" then a running "step functions" "execution" reaches the Lambda task state and invokes the function
    Given iid in inv_status
    When the "lambda" task fails and the "step functions" "execution" fails
    When a "lambda" task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task fails and the "step functions" "execution" fails then an "step functions" "execution" of the "step functions" "state machine" is started then the "lambda" task completes successfully and the "step functions" "execution" succeeds
    Given iid in inv_status
    When the "lambda" task fails and the "step functions" "execution" fails
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task fails and the "step functions" "execution" fails then a running "step functions" "execution" reaches the Lambda task state and invokes the function then a "step functions" "state machine" is created
    Given iid in inv_status
    When the "lambda" task fails and the "step functions" "execution" fails
    When a running "step functions" "execution" reaches the Lambda task state and invokes the function
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"

  @sequence
  Scenario: the "lambda" task fails and the "step functions" "execution" fails then the "lambda" task completes successfully and the "step functions" "execution" succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" task fails and the "step functions" "execution" fails
    When the "lambda" task completes successfully and the "step functions" "execution" succeeds
    When a "lambda" "function" is deployed
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"
