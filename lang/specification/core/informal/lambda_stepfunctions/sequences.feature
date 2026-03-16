@lambdastepfunctions @generated
Feature: LambdaStepfunctions - Action Sequences

  # Generated from FizzBee spec: lambda_stepfunctions.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RunningExecutionReferencesExistingStateMachine

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a running execution completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Lambda function is deployed
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Step Functions state machine is deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function is invoked
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution completes successfully
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a Lambda function is deployed
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a Step Functions state machine is created
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function is invoked
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a running execution completes successfully
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a running execution completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is deleted
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Lambda function is deployed
    Given eid in exec_status
    When a running execution completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution completes successfully
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is deleted
    Given eid in exec_status
    When a running execution completes successfully
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function is invoked
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is created then a Step Functions state machine is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a Step Functions state machine is created
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is created then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When a Step Functions state machine is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is created then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When a Step Functions state machine is created
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a Step Functions state machine is created
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is created then a running execution completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When a Step Functions state machine is created
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is deleted then a Step Functions state machine is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a Step Functions state machine is deleted
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is deleted then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When a Step Functions state machine is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When a Step Functions state machine is deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is deleted then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a Step Functions state machine is deleted
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is deleted then a running execution completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When a Step Functions state machine is deleted
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then a Step Functions state machine is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then a Step Functions state machine is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then a running execution completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a running execution completes successfully then a Step Functions state machine is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a running execution completes successfully
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a running execution completes successfully then a Step Functions state machine is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a running execution completes successfully
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a running execution completes successfully then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When a running execution completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When a running execution completes successfully
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a running execution completes successfully
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Lambda function is deployed then a Step Functions state machine is deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Lambda function is deployed
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Lambda function is deployed then the Lambda function is invoked
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Lambda function is deployed
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Lambda function is deployed
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Lambda function is deployed then a running execution completes successfully
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Lambda function is deployed
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Step Functions state machine is deleted then a Lambda function is deployed
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Step Functions state machine is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Step Functions state machine is deleted then the Lambda function is invoked
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Step Functions state machine is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Step Functions state machine is deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Step Functions state machine is deleted then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Step Functions state machine is deleted
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Step Functions state machine is deleted then a running execution completes successfully
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Step Functions state machine is deleted
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function is invoked then a Lambda function is deployed
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function is invoked then a Step Functions state machine is deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function is invoked
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function is invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function is invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function is invoked then a running execution completes successfully
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function is invoked
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function is invoked
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution completes successfully then a Lambda function is deployed
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution completes successfully then a Step Functions state machine is deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution completes successfully
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution completes successfully then the Lambda function is invoked
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution completes successfully
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution completes successfully
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a Lambda function is deployed then a Step Functions state machine is created
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a Lambda function is deployed
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a Lambda function is deployed then the Lambda function is invoked
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a Lambda function is deployed
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a Lambda function is deployed
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a Lambda function is deployed then a running execution completes successfully
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a Lambda function is deployed
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a Step Functions state machine is created then a Lambda function is deployed
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a Step Functions state machine is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a Step Functions state machine is created then the Lambda function is invoked
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a Step Functions state machine is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a Step Functions state machine is created then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a Step Functions state machine is created
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a Step Functions state machine is created
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a Step Functions state machine is created then a running execution completes successfully
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a Step Functions state machine is created
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function is invoked then a Lambda function is deployed
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function is invoked then a Step Functions state machine is created
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function is invoked
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function is invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function is invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function is invoked then a running execution completes successfully
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function is invoked
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function is invoked
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a running execution completes successfully then a Lambda function is deployed
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a running execution completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a running execution completes successfully then a Step Functions state machine is created
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a running execution completes successfully
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a running execution completes successfully then the Lambda function is invoked
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a running execution completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a running execution completes successfully
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a Step Functions state machine is deleted then a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid in sm_status
    When a Step Functions state machine is deleted
    When a running execution completes successfully
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then a Step Functions state machine is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then a Step Functions state machine is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then a running execution completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is created then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Step Functions state machine is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is created then a Step Functions state machine is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Step Functions state machine is created
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is created then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When a Step Functions state machine is created
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Step Functions state machine is created
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is created then a running execution completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When a Step Functions state machine is created
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is deleted then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Step Functions state machine is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is deleted then a Step Functions state machine is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Step Functions state machine is deleted
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When a Step Functions state machine is deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is deleted then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Step Functions state machine is deleted
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is deleted then a running execution completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When a Step Functions state machine is deleted
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a running execution completes successfully then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a running execution completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a running execution completes successfully then a Step Functions state machine is created
    Given fid in func_status
    When the Lambda function is invoked
    When a running execution completes successfully
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a running execution completes successfully then a Step Functions state machine is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a running execution completes successfully
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When a running execution completes successfully
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a running execution completes successfully
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed then a Step Functions state machine is created
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Lambda function is deployed
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed then a Step Functions state machine is deleted
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Lambda function is deployed
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Lambda function is deployed
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed then a running execution completes successfully
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Lambda function is deployed
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created then a Step Functions state machine is deleted
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is created
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is created
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created then a running execution completes successfully
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is created
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is deleted then a Step Functions state machine is created
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is deleted
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is deleted then the Lambda function fails to start an execution because the state machine has been deleted
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is deleted
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is deleted then a running execution completes successfully
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is deleted
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function is invoked then a Step Functions state machine is created
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function is invoked
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function is invoked then a Step Functions state machine is deleted
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function is invoked
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function is invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function is invoked then a running execution completes successfully
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function is invoked
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a running execution completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully then a Step Functions state machine is created
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a running execution completes successfully
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully then a Step Functions state machine is deleted
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a running execution completes successfully
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a running execution completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted
    Given iid in inv_status
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a running execution completes successfully
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed then a Step Functions state machine is created
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Lambda function is deployed
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed then a Step Functions state machine is deleted
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Lambda function is deployed
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Lambda function is deployed
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed then a running execution completes successfully
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Lambda function is deployed
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created then a Step Functions state machine is deleted
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created then a running execution completes successfully
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted then a Step Functions state machine is created
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is deleted
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted then a running execution completes successfully
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is deleted
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked then a Step Functions state machine is created
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function is invoked
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked then a Step Functions state machine is deleted
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function is invoked
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function is invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked then a running execution completes successfully
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function is invoked
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is deleted
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a running execution completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a running execution completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully then a Step Functions state machine is created
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a running execution completes successfully
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully then a Step Functions state machine is deleted
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a running execution completes successfully
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a running execution completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given iid in inv_status
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a running execution completes successfully
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Lambda function is deployed then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution completes successfully
    When a Lambda function is deployed
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Lambda function is deployed then a Step Functions state machine is deleted
    Given eid in exec_status
    When a running execution completes successfully
    When a Lambda function is deployed
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Lambda function is deployed then the Lambda function is invoked
    Given eid in exec_status
    When a running execution completes successfully
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given eid in exec_status
    When a running execution completes successfully
    When a Lambda function is deployed
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted
    Given eid in exec_status
    When a running execution completes successfully
    When a Lambda function is deployed
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is created then a Lambda function is deployed
    Given eid in exec_status
    When a running execution completes successfully
    When a Step Functions state machine is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is created then a Step Functions state machine is deleted
    Given eid in exec_status
    When a running execution completes successfully
    When a Step Functions state machine is created
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is created then the Lambda function is invoked
    Given eid in exec_status
    When a running execution completes successfully
    When a Step Functions state machine is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is created then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given eid in exec_status
    When a running execution completes successfully
    When a Step Functions state machine is created
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted
    Given eid in exec_status
    When a running execution completes successfully
    When a Step Functions state machine is created
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is deleted then a Lambda function is deployed
    Given eid in exec_status
    When a running execution completes successfully
    When a Step Functions state machine is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is deleted then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution completes successfully
    When a Step Functions state machine is deleted
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is deleted then the Lambda function is invoked
    Given eid in exec_status
    When a running execution completes successfully
    When a Step Functions state machine is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given eid in exec_status
    When a running execution completes successfully
    When a Step Functions state machine is deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is deleted then the Lambda function fails to start an execution because the state machine has been deleted
    Given eid in exec_status
    When a running execution completes successfully
    When a Step Functions state machine is deleted
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function is invoked then a Lambda function is deployed
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function is invoked then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function is invoked
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function is invoked then a Step Functions state machine is deleted
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function is invoked
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function is invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function is invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is deleted
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function is invoked
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    When the Lambda function fails to start an execution because the state machine has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function fails to start an execution because the state machine has been deleted
    When a Step Functions state machine is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @exhaustive @sequence
  Scenario: a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given eid in exec_status
    When a running execution completes successfully
    When the Lambda function fails to start an execution because the state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists
