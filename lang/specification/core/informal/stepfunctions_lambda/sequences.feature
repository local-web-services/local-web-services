@stepfunctionslambda @generated
Feature: StepfunctionsLambda - Action Sequences

  # Generated from FizzBee spec: stepfunctions_lambda.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, InvocationRequiresActiveFunction, InvocationLinkedToRunningExecution

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Lambda function is deployed
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a Lambda function is deployed
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Lambda task is configured on the state machine
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a Lambda task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reaches the Lambda task state and invokes the function
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution reaches the Lambda task state and invokes the function
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda task completes successfully and the execution succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When the Lambda task completes successfully and the execution succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda task fails and the execution fails
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When the Lambda task fails and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda task is configured on the state machine
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a Lambda task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an execution of the state machine is started
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a running execution reaches the Lambda task state and invokes the function
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a running execution reaches the Lambda task state and invokes the function
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda task completes successfully and the execution succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda task completes successfully and the execution succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda task fails and the execution fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda task fails and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda task is configured on the state machine then a Step Functions state machine is created
    Given smid in sm_status
    Given a Lambda task has been configured on the state machine
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda task is configured on the state machine then a Lambda function is deployed
    Given smid in sm_status
    Given a Lambda task has been configured on the state machine
    When a Lambda function is deployed
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda task is configured on the state machine then an execution of the state machine is started
    Given smid in sm_status
    Given a Lambda task has been configured on the state machine
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda task is configured on the state machine then a running execution reaches the Lambda task state and invokes the function
    Given smid in sm_status
    Given a Lambda task has been configured on the state machine
    When a running execution reaches the Lambda task state and invokes the function
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda task is configured on the state machine then the Lambda task completes successfully and the execution succeeds
    Given smid in sm_status
    Given a Lambda task has been configured on the state machine
    When the Lambda task completes successfully and the execution succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda task is configured on the state machine then the Lambda task fails and the execution fails
    Given smid in sm_status
    Given a Lambda task has been configured on the state machine
    When the Lambda task fails and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Lambda function is deployed
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Lambda function is deployed
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Lambda task is configured on the state machine
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Lambda task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reaches the Lambda task state and invokes the function
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution reaches the Lambda task state and invokes the function
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the Lambda task completes successfully and the execution succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    When the Lambda task completes successfully and the execution succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the Lambda task fails and the execution fails
    Given smid in sm_status
    Given an execution of the state machine has been started
    When the Lambda task fails and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a running execution reaches the Lambda task state and invokes the function then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has reached the Lambda task state and invoked the function
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a running execution reaches the Lambda task state and invokes the function then a Lambda function is deployed
    Given eid in exec_status
    Given a running execution has reached the Lambda task state and invoked the function
    When a Lambda function is deployed
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a running execution reaches the Lambda task state and invokes the function then a Lambda task is configured on the state machine
    Given eid in exec_status
    Given a running execution has reached the Lambda task state and invoked the function
    When a Lambda task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a running execution reaches the Lambda task state and invokes the function then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has reached the Lambda task state and invoked the function
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a running execution reaches the Lambda task state and invokes the function then the Lambda task completes successfully and the execution succeeds
    Given eid in exec_status
    Given a running execution has reached the Lambda task state and invoked the function
    When the Lambda task completes successfully and the execution succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a running execution reaches the Lambda task state and invokes the function then the Lambda task fails and the execution fails
    Given eid in exec_status
    Given a running execution has reached the Lambda task state and invoked the function
    When the Lambda task fails and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a Step Functions state machine is created
    Given iid in inv_status
    Given the Lambda task has completed successfully and the execution has succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda task has completed successfully and the execution has succeeded
    When a Lambda function is deployed
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a Lambda task is configured on the state machine
    Given iid in inv_status
    Given the Lambda task has completed successfully and the execution has succeeded
    When a Lambda task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then an execution of the state machine is started
    Given iid in inv_status
    Given the Lambda task has completed successfully and the execution has succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a running execution reaches the Lambda task state and invokes the function
    Given iid in inv_status
    Given the Lambda task has completed successfully and the execution has succeeded
    When a running execution reaches the Lambda task state and invokes the function
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then the Lambda task fails and the execution fails
    Given iid in inv_status
    Given the Lambda task has completed successfully and the execution has succeeded
    When the Lambda task fails and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task fails and the execution fails then a Step Functions state machine is created
    Given iid in inv_status
    Given the Lambda task has failed and the execution has failed
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task fails and the execution fails then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda task has failed and the execution has failed
    When a Lambda function is deployed
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task fails and the execution fails then a Lambda task is configured on the state machine
    Given iid in inv_status
    Given the Lambda task has failed and the execution has failed
    When a Lambda task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task fails and the execution fails then an execution of the state machine is started
    Given iid in inv_status
    Given the Lambda task has failed and the execution has failed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task fails and the execution fails then a running execution reaches the Lambda task state and invokes the function
    Given iid in inv_status
    Given the Lambda task has failed and the execution has failed
    When a running execution reaches the Lambda task state and invokes the function
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task fails and the execution fails then the Lambda task completes successfully and the execution succeeds
    Given iid in inv_status
    Given the Lambda task has failed and the execution has failed
    When the Lambda task completes successfully and the execution succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Lambda function is deployed then a Lambda task is configured on the state machine
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a Lambda function has been deployed
    When a Lambda task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Lambda task is configured on the state machine then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a Lambda task has been configured on the state machine
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution reaches the Lambda task state and invokes the function
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution reaches the Lambda task state and invokes the function
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reaches the Lambda task state and invokes the function then the Lambda task completes successfully and the execution succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has reached the Lambda task state and invoked the function
    When the Lambda task completes successfully and the execution succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda task completes successfully and the execution succeeds then the Lambda task fails and the execution fails
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given the Lambda task has completed successfully and the execution has succeeded
    When the Lambda task fails and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Lambda task fails and the execution fails then a Lambda function is deployed
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given the Lambda task has failed and the execution has failed
    When a Lambda function is deployed
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Step Functions state machine is created then an execution of the state machine is started
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda task is configured on the state machine then a running execution reaches the Lambda task state and invokes the function
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a Lambda task has been configured on the state machine
    When a running execution reaches the Lambda task state and invokes the function
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an execution of the state machine is started then the Lambda task completes successfully and the execution succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an execution of the state machine has been started
    When the Lambda task completes successfully and the execution succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a running execution reaches the Lambda task state and invokes the function then the Lambda task fails and the execution fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a running execution has reached the Lambda task state and invoked the function
    When the Lambda task fails and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda task completes successfully and the execution succeeds then a Step Functions state machine is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda task has completed successfully and the execution has succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda task fails and the execution fails then a Lambda task is configured on the state machine
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda task has failed and the execution has failed
    When a Lambda task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda task is configured on the state machine then a Step Functions state machine is created then a running execution reaches the Lambda task state and invokes the function
    Given smid in sm_status
    Given a Lambda task has been configured on the state machine
    Given a Step Functions state machine has been created
    When a running execution reaches the Lambda task state and invokes the function
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda task is configured on the state machine then a Lambda function is deployed then the Lambda task completes successfully and the execution succeeds
    Given smid in sm_status
    Given a Lambda task has been configured on the state machine
    Given a Lambda function has been deployed
    When the Lambda task completes successfully and the execution succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda task is configured on the state machine then an execution of the state machine is started then the Lambda task fails and the execution fails
    Given smid in sm_status
    Given a Lambda task has been configured on the state machine
    Given an execution of the state machine has been started
    When the Lambda task fails and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda task is configured on the state machine then a running execution reaches the Lambda task state and invokes the function then a Step Functions state machine is created
    Given smid in sm_status
    Given a Lambda task has been configured on the state machine
    Given a running execution has reached the Lambda task state and invoked the function
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda task is configured on the state machine then the Lambda task completes successfully and the execution succeeds then a Lambda function is deployed
    Given smid in sm_status
    Given a Lambda task has been configured on the state machine
    Given the Lambda task has completed successfully and the execution has succeeded
    When a Lambda function is deployed
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a Lambda task is configured on the state machine then the Lambda task fails and the execution fails then an execution of the state machine is started
    Given smid in sm_status
    Given a Lambda task has been configured on the state machine
    Given the Lambda task has failed and the execution has failed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then the Lambda task completes successfully and the execution succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When the Lambda task completes successfully and the execution succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Lambda function is deployed then the Lambda task fails and the execution fails
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Lambda function has been deployed
    When the Lambda task fails and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Lambda task is configured on the state machine then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Lambda task has been configured on the state machine
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reaches the Lambda task state and invokes the function then a Lambda function is deployed
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has reached the Lambda task state and invoked the function
    When a Lambda function is deployed
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the Lambda task completes successfully and the execution succeeds then a Lambda task is configured on the state machine
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given the Lambda task has completed successfully and the execution has succeeded
    When a Lambda task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the Lambda task fails and the execution fails then a running execution reaches the Lambda task state and invokes the function
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given the Lambda task has failed and the execution has failed
    When a running execution reaches the Lambda task state and invokes the function
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a running execution reaches the Lambda task state and invokes the function then a Step Functions state machine is created then the Lambda task fails and the execution fails
    Given eid in exec_status
    Given a running execution has reached the Lambda task state and invoked the function
    Given a Step Functions state machine has been created
    When the Lambda task fails and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a running execution reaches the Lambda task state and invokes the function then a Lambda function is deployed then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has reached the Lambda task state and invoked the function
    Given a Lambda function has been deployed
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a running execution reaches the Lambda task state and invokes the function then a Lambda task is configured on the state machine then a Lambda function is deployed
    Given eid in exec_status
    Given a running execution has reached the Lambda task state and invoked the function
    Given a Lambda task has been configured on the state machine
    When a Lambda function is deployed
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a running execution reaches the Lambda task state and invokes the function then an execution of the state machine is started then a Lambda task is configured on the state machine
    Given eid in exec_status
    Given a running execution has reached the Lambda task state and invoked the function
    Given an execution of the state machine has been started
    When a Lambda task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a running execution reaches the Lambda task state and invokes the function then the Lambda task completes successfully and the execution succeeds then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has reached the Lambda task state and invoked the function
    Given the Lambda task has completed successfully and the execution has succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: a running execution reaches the Lambda task state and invokes the function then the Lambda task fails and the execution fails then the Lambda task completes successfully and the execution succeeds
    Given eid in exec_status
    Given a running execution has reached the Lambda task state and invoked the function
    Given the Lambda task has failed and the execution has failed
    When the Lambda task completes successfully and the execution succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a Step Functions state machine is created then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda task has completed successfully and the execution has succeeded
    Given a Step Functions state machine has been created
    When a Lambda function is deployed
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a Lambda function is deployed then a Lambda task is configured on the state machine
    Given iid in inv_status
    Given the Lambda task has completed successfully and the execution has succeeded
    Given a Lambda function has been deployed
    When a Lambda task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a Lambda task is configured on the state machine then an execution of the state machine is started
    Given iid in inv_status
    Given the Lambda task has completed successfully and the execution has succeeded
    Given a Lambda task has been configured on the state machine
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then an execution of the state machine is started then a running execution reaches the Lambda task state and invokes the function
    Given iid in inv_status
    Given the Lambda task has completed successfully and the execution has succeeded
    Given an execution of the state machine has been started
    When a running execution reaches the Lambda task state and invokes the function
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then a running execution reaches the Lambda task state and invokes the function then the Lambda task fails and the execution fails
    Given iid in inv_status
    Given the Lambda task has completed successfully and the execution has succeeded
    Given a running execution has reached the Lambda task state and invoked the function
    When the Lambda task fails and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task completes successfully and the execution succeeds then the Lambda task fails and the execution fails then a Step Functions state machine is created
    Given iid in inv_status
    Given the Lambda task has completed successfully and the execution has succeeded
    Given the Lambda task has failed and the execution has failed
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task fails and the execution fails then a Step Functions state machine is created then a Lambda task is configured on the state machine
    Given iid in inv_status
    Given the Lambda task has failed and the execution has failed
    Given a Step Functions state machine has been created
    When a Lambda task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task fails and the execution fails then a Lambda function is deployed then an execution of the state machine is started
    Given iid in inv_status
    Given the Lambda task has failed and the execution has failed
    Given a Lambda function has been deployed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task fails and the execution fails then a Lambda task is configured on the state machine then a running execution reaches the Lambda task state and invokes the function
    Given iid in inv_status
    Given the Lambda task has failed and the execution has failed
    Given a Lambda task has been configured on the state machine
    When a running execution reaches the Lambda task state and invokes the function
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task fails and the execution fails then an execution of the state machine is started then the Lambda task completes successfully and the execution succeeds
    Given iid in inv_status
    Given the Lambda task has failed and the execution has failed
    Given an execution of the state machine has been started
    When the Lambda task completes successfully and the execution succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task fails and the execution fails then a running execution reaches the Lambda task state and invokes the function then a Step Functions state machine is created
    Given iid in inv_status
    Given the Lambda task has failed and the execution has failed
    Given a running execution has reached the Lambda task state and invoked the function
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution

  @exhaustive @sequence
  Scenario: the Lambda task fails and the execution fails then the Lambda task completes successfully and the execution succeeds then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda task has failed and the execution has failed
    Given the Lambda task has completed successfully and the execution has succeeded
    When a Lambda function is deployed
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution
