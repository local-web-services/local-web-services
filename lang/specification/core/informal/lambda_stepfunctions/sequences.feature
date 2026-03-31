@lambdastepfunctions @generated
Feature: LambdaStepfunctions - Action Sequences

  # Generated from FizzBee spec: lambda_stepfunctions.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RunningExecutionReferencesExistingStateMachine

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a "step functions" "state machine" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "step functions" "state machine" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "step functions" "state machine" is deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "step functions" "state machine" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to start an execution because the state machine has been deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a running "step functions" "execution" completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a running "step functions" "execution" completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a "lambda" "function" is deployed
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "state machine" is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the "lambda" "function" is invoked
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the "lambda" "function" fails to start an execution because the state machine has been deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" completes successfully
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "lambda" "function" is deployed
    Given smid in sm_status
    When a "step functions" "state machine" is deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "step functions" "state machine" is created
    Given smid in sm_status
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is deleted then the "lambda" "function" is invoked
    Given smid in sm_status
    When a "step functions" "state machine" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is deleted then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Given smid in sm_status
    When a "step functions" "state machine" is deleted
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is deleted then the "lambda" "function" fails to start an execution because the state machine has been deleted
    Given smid in sm_status
    When a "step functions" "state machine" is deleted
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a running "step functions" "execution" completes successfully
    Given smid in sm_status
    When a "step functions" "state machine" is deleted
    When a running "step functions" "execution" completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "step functions" "state machine" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "step functions" "state machine" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "step functions" "state machine" is deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "step functions" "state machine" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to start an execution because the state machine has been deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a running "step functions" "execution" completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a running "step functions" "execution" completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then a "step functions" "state machine" is created
    Given iid in inv_status
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When a "step functions" "state machine" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then a "step functions" "state machine" is deleted
    Given iid in inv_status
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When a "step functions" "state machine" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then the "lambda" "function" fails to start an execution because the state machine has been deleted
    Given iid in inv_status
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then a running "step functions" "execution" completes successfully
    Given iid in inv_status
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When a running "step functions" "execution" completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted then a "step functions" "state machine" is created
    Given iid in inv_status
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When a "step functions" "state machine" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted then a "step functions" "state machine" is deleted
    Given iid in inv_status
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When a "step functions" "state machine" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted then a running "step functions" "execution" completes successfully
    Given iid in inv_status
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When a running "step functions" "execution" completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a "lambda" "function" is deployed
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a "step functions" "state machine" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then the "lambda" "function" is invoked
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then the "lambda" "function" fails to start an execution because the state machine has been deleted
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "step functions" "state machine" is created then a "step functions" "state machine" is deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "step functions" "state machine" is deleted then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "step functions" "state machine" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then the "lambda" "function" fails to start an execution because the state machine has been deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to start an execution because the state machine has been deleted then a running "step functions" "execution" completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When a running "step functions" "execution" completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a running "step functions" "execution" completes successfully then a "step functions" "state machine" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "state machine" is deleted then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" is deleted
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the "lambda" "function" is invoked then the "lambda" "function" fails to start an execution because the state machine has been deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then a running "step functions" "execution" completes successfully
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When a running "step functions" "execution" completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the "lambda" "function" fails to start an execution because the state machine has been deleted then a "lambda" "function" is deployed
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" completes successfully then a "step functions" "state machine" is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "lambda" "function" is deployed then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Given smid in sm_status
    When a "step functions" "state machine" is deleted
    When a "lambda" "function" is deployed
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "step functions" "state machine" is created then the "lambda" "function" fails to start an execution because the state machine has been deleted
    Given smid in sm_status
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" is created
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is deleted then the "lambda" "function" is invoked then a running "step functions" "execution" completes successfully
    Given smid in sm_status
    When a "step functions" "state machine" is deleted
    When the "lambda" "function" is invoked
    When a running "step functions" "execution" completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is deleted then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then a "lambda" "function" is deployed
    Given smid in sm_status
    When a "step functions" "state machine" is deleted
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is deleted then the "lambda" "function" fails to start an execution because the state machine has been deleted then a "step functions" "state machine" is created
    Given smid in sm_status
    When a "step functions" "state machine" is deleted
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When a "step functions" "state machine" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a running "step functions" "execution" completes successfully then the "lambda" "function" is invoked
    Given smid in sm_status
    When a "step functions" "state machine" is deleted
    When a running "step functions" "execution" completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" fails to start an execution because the state machine has been deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "step functions" "state machine" is created then a running "step functions" "execution" completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "step functions" "state machine" is deleted then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "step functions" "state machine" is deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then a "step functions" "state machine" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When a "step functions" "state machine" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to start an execution because the state machine has been deleted then a "step functions" "state machine" is deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When a "step functions" "state machine" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a running "step functions" "execution" completes successfully then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a running "step functions" "execution" completes successfully
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then a "lambda" "function" is deployed then a running "step functions" "execution" completes successfully
    Given iid in inv_status
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When a "lambda" "function" is deployed
    When a running "step functions" "execution" completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then a "step functions" "state machine" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When a "step functions" "state machine" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then a "step functions" "state machine" is deleted then a "step functions" "state machine" is created
    Given iid in inv_status
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then the "lambda" "function" is invoked then a "step functions" "state machine" is deleted
    Given iid in inv_status
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When the "lambda" "function" is invoked
    When a "step functions" "state machine" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then the "lambda" "function" fails to start an execution because the state machine has been deleted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then a running "step functions" "execution" completes successfully then the "lambda" "function" fails to start an execution because the state machine has been deleted
    Given iid in inv_status
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When a running "step functions" "execution" completes successfully
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted then a "lambda" "function" is deployed then a "step functions" "state machine" is created
    Given iid in inv_status
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When a "lambda" "function" is deployed
    When a "step functions" "state machine" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted then a "step functions" "state machine" is created then a "step functions" "state machine" is deleted
    Given iid in inv_status
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted then a "step functions" "state machine" is deleted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When a "step functions" "state machine" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted then the "lambda" "function" is invoked then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When the "lambda" "function" is invoked
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then a running "step functions" "execution" completes successfully
    Given iid in inv_status
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When a running "step functions" "execution" completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the "lambda" "function" fails to start an execution because the state machine has been deleted then a running "step functions" "execution" completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When a running "step functions" "execution" completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a "lambda" "function" is deployed then a "step functions" "state machine" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a "lambda" "function" is deployed
    When a "step functions" "state machine" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a "step functions" "state machine" is created then the "lambda" "function" is invoked
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a "step functions" "state machine" is deleted then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is deleted
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then the "lambda" "function" is invoked then the "lambda" "function" fails to start an execution because the state machine has been deleted
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds then a "lambda" "function" is deployed
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then the "lambda" "function" fails to start an execution because the state machine has been deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When the "lambda" "function" fails to start an execution because the state machine has been deleted
    When a "step functions" "state machine" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists
