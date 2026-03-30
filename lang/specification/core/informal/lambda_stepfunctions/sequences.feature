@lambdastepfunctions @generated
Feature: LambdaStepfunctions - Action Sequences

  # Generated from FizzBee spec: lambda_stepfunctions.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RunningExecutionReferencesExistingStateMachine

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a Step Functions state machine is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a Step Functions state machine is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Lambda function is deployed then a running execution completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a running execution completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is created then a Lambda function is deployed
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is created then a Step Functions state machine is deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a Step Functions state machine is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is created then the Lambda function is invoked
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is created then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is created then a running execution completes successfully
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is deleted then a Lambda function is deployed
    Given smid in sm_status
    Given a Step Functions state machine has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is deleted then a Step Functions state machine is created
    Given smid in sm_status
    Given a Step Functions state machine has been deleted
    When a Step Functions state machine is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function is invoked
    Given smid in sm_status
    Given a Step Functions state machine has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid in sm_status
    Given a Step Functions state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid in sm_status
    Given a Step Functions state machine has been deleted
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is deleted then a running execution completes successfully
    Given smid in sm_status
    Given a Step Functions state machine has been deleted
    When a running execution completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is created
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Step Functions state machine is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Step Functions state machine is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function is invoked then a running execution completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    When a running execution completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created
    Given iid in inv_status
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    When a Step Functions state machine is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is deleted
    Given iid in inv_status
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    When a Step Functions state machine is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted
    Given iid in inv_status
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully
    Given iid in inv_status
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    When a running execution completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created
    Given iid in inv_status
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted
    Given iid in inv_status
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    When a Step Functions state machine is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully
    Given iid in inv_status
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    When a running execution completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running execution completes successfully then a Lambda function is deployed
    Given eid in exec_status
    Given a running execution has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has completed successfully
    When a Step Functions state machine is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is deleted
    Given eid in exec_status
    Given a running execution has completed successfully
    When a Step Functions state machine is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running execution completes successfully then the Lambda function is invoked
    Given eid in exec_status
    Given a running execution has completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given eid in exec_status
    Given a running execution has completed successfully
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted
    Given eid in exec_status
    Given a running execution has completed successfully
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is created then a Step Functions state machine is deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a Step Functions state machine has been created
    When a Step Functions state machine is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is deleted then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a Step Functions state machine has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    When a running execution completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Lambda function is deployed then a running execution completes successfully then a Step Functions state machine is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a running execution has completed successfully
    When a Step Functions state machine is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is created then a Lambda function is deployed then the Lambda function is invoked
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is created then a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a Step Functions state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is created then the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given the Lambda function has been invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is created then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    When a running execution completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is created then a running execution completes successfully then a Step Functions state machine is deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has completed successfully
    When a Step Functions state machine is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is deleted then a Lambda function is deployed then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given smid in sm_status
    Given a Step Functions state machine has been deleted
    Given a Lambda function has been deployed
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is deleted then a Step Functions state machine is created then the Lambda function fails to start an execution because the state machine has been deleted
    Given smid in sm_status
    Given a Step Functions state machine has been deleted
    Given a Step Functions state machine has been created
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function is invoked then a running execution completes successfully
    Given smid in sm_status
    Given a Step Functions state machine has been deleted
    Given the Lambda function has been invoked
    When a running execution completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed
    Given smid in sm_status
    Given a Step Functions state machine has been deleted
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is deleted then the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created
    Given smid in sm_status
    Given a Step Functions state machine has been deleted
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a Step Functions state machine is deleted then a running execution completes successfully then the Lambda function is invoked
    Given smid in sm_status
    Given a Step Functions state machine has been deleted
    Given a running execution has completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to start an execution because the state machine has been deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is created then a running execution completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Step Functions state machine has been created
    When a running execution completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function is invoked then a Step Functions state machine is deleted then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Step Functions state machine has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    When a Step Functions state machine is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    When a Step Functions state machine is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function is invoked then a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a running execution has completed successfully
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed then a running execution completes successfully
    Given iid in inv_status
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    Given a Lambda function has been deployed
    When a running execution completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is created then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    Given a Step Functions state machine has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Step Functions state machine is deleted then a Step Functions state machine is created
    Given iid in inv_status
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    Given a Step Functions state machine has been deleted
    When a Step Functions state machine is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function is invoked then a Step Functions state machine is deleted
    Given iid in inv_status
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    Given the Lambda function has been invoked
    When a Step Functions state machine is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted
    Given iid in inv_status
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    Given a running execution has completed successfully
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Lambda function is deployed then a Step Functions state machine is created
    Given iid in inv_status
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    Given a Lambda function has been deployed
    When a Step Functions state machine is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created then a Step Functions state machine is deleted
    Given iid in inv_status
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    Given a Step Functions state machine has been created
    When a Step Functions state machine is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is deleted then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    Given a Step Functions state machine has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function is invoked then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    Given the Lambda function has been invoked
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a running execution completes successfully
    Given iid in inv_status
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    When a running execution completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: the Lambda function fails to start an execution because the state machine has been deleted then a running execution completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    Given a running execution has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running execution completes successfully then a Lambda function is deployed then a Step Functions state machine is deleted
    Given eid in exec_status
    Given a running execution has completed successfully
    Given a Lambda function has been deployed
    When a Step Functions state machine is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is created then the Lambda function is invoked
    Given eid in exec_status
    Given a running execution has completed successfully
    Given a Step Functions state machine has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is deleted then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Given eid in exec_status
    Given a running execution has completed successfully
    Given a Step Functions state machine has been deleted
    When the Lambda function starts an execution of an "ACTIVE" state machine and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running execution completes successfully then the Lambda function is invoked then the Lambda function fails to start an execution because the state machine has been deleted
    Given eid in exec_status
    Given a running execution has completed successfully
    Given the Lambda function has been invoked
    When the Lambda function fails to start an execution because the state machine has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running execution completes successfully then the Lambda function starts an execution of an "ACTIVE" state machine and succeeds then a Lambda function is deployed
    Given eid in exec_status
    Given a running execution has completed successfully
    Given the Lambda function has started an execution of an "ACTIVE" state machine and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists

  @sequence
  Scenario: a running execution completes successfully then the Lambda function fails to start an execution because the state machine has been deleted then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has completed successfully
    Given the Lambda function has failed to start an execution because the state machine has been deleted
    When a Step Functions state machine is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "RUNNING" execution references a state machine that exists
