@lambdassm @generated
Feature: LambdaSsm - Action Sequences

  # Generated from FizzBee spec: lambda_ssm.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadAParameter

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a "ssm" "parameter" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "ssm" "parameter" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then a "ssm" "parameter" is deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "ssm" "parameter" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" reads an existing parameter and completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" reads an existing parameter and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails because the parameter has been deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails because the parameter has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then a "lambda" "function" is deployed
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then a "ssm" "parameter" is deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When a "ssm" "parameter" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then the "lambda" "function" is invoked
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then the "lambda" "function" reads an existing parameter and completes successfully
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When the "lambda" "function" reads an existing parameter and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then the "lambda" "function" fails because the parameter has been deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When the "lambda" "function" fails because the parameter has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "lambda" "function" is deployed
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "ssm" "parameter" is created
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then the "lambda" "function" is invoked
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then the "lambda" "function" reads an existing parameter and completes successfully
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When the "lambda" "function" reads an existing parameter and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then the "lambda" "function" fails because the parameter has been deleted
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When the "lambda" "function" fails because the parameter has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then a "ssm" "parameter" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "ssm" "parameter" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then a "ssm" "parameter" is deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "ssm" "parameter" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" reads an existing parameter and completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" reads an existing parameter and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails because the parameter has been deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails because the parameter has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" reads an existing parameter and completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" reads an existing parameter and completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" reads an existing parameter and completes successfully then a "ssm" "parameter" is created
    Given iid in inv_status
    When the "lambda" "function" reads an existing parameter and completes successfully
    When a "ssm" "parameter" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" reads an existing parameter and completes successfully then a "ssm" "parameter" is deleted
    Given iid in inv_status
    When the "lambda" "function" reads an existing parameter and completes successfully
    When a "ssm" "parameter" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" reads an existing parameter and completes successfully then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" reads an existing parameter and completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" reads an existing parameter and completes successfully then the "lambda" "function" fails because the parameter has been deleted
    Given iid in inv_status
    When the "lambda" "function" reads an existing parameter and completes successfully
    When the "lambda" "function" fails because the parameter has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" fails because the parameter has been deleted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails because the parameter has been deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" fails because the parameter has been deleted then a "ssm" "parameter" is created
    Given iid in inv_status
    When the "lambda" "function" fails because the parameter has been deleted
    When a "ssm" "parameter" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" fails because the parameter has been deleted then a "ssm" "parameter" is deleted
    Given iid in inv_status
    When the "lambda" "function" fails because the parameter has been deleted
    When a "ssm" "parameter" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" fails because the parameter has been deleted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails because the parameter has been deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" fails because the parameter has been deleted then the "lambda" "function" reads an existing parameter and completes successfully
    Given iid in inv_status
    When the "lambda" "function" fails because the parameter has been deleted
    When the "lambda" "function" reads an existing parameter and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then a "ssm" "parameter" is created then a "ssm" "parameter" is deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "ssm" "parameter" is created
    When a "ssm" "parameter" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then a "ssm" "parameter" is deleted then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "ssm" "parameter" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" reads an existing parameter and completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" reads an existing parameter and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" reads an existing parameter and completes successfully then the "lambda" "function" fails because the parameter has been deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" reads an existing parameter and completes successfully
    When the "lambda" "function" fails because the parameter has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails because the parameter has been deleted then a "ssm" "parameter" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails because the parameter has been deleted
    When a "ssm" "parameter" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then a "ssm" "parameter" is deleted then the "lambda" "function" reads an existing parameter and completes successfully
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When a "ssm" "parameter" is deleted
    When the "lambda" "function" reads an existing parameter and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then the "lambda" "function" is invoked then the "lambda" "function" fails because the parameter has been deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails because the parameter has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then the "lambda" "function" reads an existing parameter and completes successfully then a "lambda" "function" is deployed
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When the "lambda" "function" reads an existing parameter and completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is created then the "lambda" "function" fails because the parameter has been deleted then a "ssm" "parameter" is deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created
    When the "lambda" "function" fails because the parameter has been deleted
    When a "ssm" "parameter" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "lambda" "function" is deployed then the "lambda" "function" reads an existing parameter and completes successfully
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When a "lambda" "function" is deployed
    When the "lambda" "function" reads an existing parameter and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "ssm" "parameter" is created then the "lambda" "function" fails because the parameter has been deleted
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is created
    When the "lambda" "function" fails because the parameter has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then the "lambda" "function" reads an existing parameter and completes successfully then a "ssm" "parameter" is created
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When the "lambda" "function" reads an existing parameter and completes successfully
    When a "ssm" "parameter" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: a "ssm" "parameter" is deleted then the "lambda" "function" fails because the parameter has been deleted then the "lambda" "function" is invoked
    Given pid in param_status
    When a "ssm" "parameter" is deleted
    When the "lambda" "function" fails because the parameter has been deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" fails because the parameter has been deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails because the parameter has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then a "ssm" "parameter" is created then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "ssm" "parameter" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then a "ssm" "parameter" is deleted then a "ssm" "parameter" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" reads an existing parameter and completes successfully then a "ssm" "parameter" is deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" reads an existing parameter and completes successfully
    When a "ssm" "parameter" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails because the parameter has been deleted then the "lambda" "function" reads an existing parameter and completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails because the parameter has been deleted
    When the "lambda" "function" reads an existing parameter and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" reads an existing parameter and completes successfully then a "lambda" "function" is deployed then a "ssm" "parameter" is created
    Given iid in inv_status
    When the "lambda" "function" reads an existing parameter and completes successfully
    When a "lambda" "function" is deployed
    When a "ssm" "parameter" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" reads an existing parameter and completes successfully then a "ssm" "parameter" is created then a "ssm" "parameter" is deleted
    Given iid in inv_status
    When the "lambda" "function" reads an existing parameter and completes successfully
    When a "ssm" "parameter" is created
    When a "ssm" "parameter" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" reads an existing parameter and completes successfully then a "ssm" "parameter" is deleted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" reads an existing parameter and completes successfully
    When a "ssm" "parameter" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" reads an existing parameter and completes successfully then the "lambda" "function" is invoked then the "lambda" "function" fails because the parameter has been deleted
    Given iid in inv_status
    When the "lambda" "function" reads an existing parameter and completes successfully
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails because the parameter has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" reads an existing parameter and completes successfully then the "lambda" "function" fails because the parameter has been deleted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" reads an existing parameter and completes successfully
    When the "lambda" "function" fails because the parameter has been deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" fails because the parameter has been deleted then a "lambda" "function" is deployed then a "ssm" "parameter" is deleted
    Given iid in inv_status
    When the "lambda" "function" fails because the parameter has been deleted
    When a "lambda" "function" is deployed
    When a "ssm" "parameter" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" fails because the parameter has been deleted then a "ssm" "parameter" is created then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails because the parameter has been deleted
    When a "ssm" "parameter" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" fails because the parameter has been deleted then a "ssm" "parameter" is deleted then the "lambda" "function" reads an existing parameter and completes successfully
    Given iid in inv_status
    When the "lambda" "function" fails because the parameter has been deleted
    When a "ssm" "parameter" is deleted
    When the "lambda" "function" reads an existing parameter and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" fails because the parameter has been deleted then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails because the parameter has been deleted
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @sequence
  Scenario: the "lambda" "function" fails because the parameter has been deleted then the "lambda" "function" reads an existing parameter and completes successfully then a "ssm" "parameter" is created
    Given iid in inv_status
    When the "lambda" "function" fails because the parameter has been deleted
    When the "lambda" "function" reads an existing parameter and completes successfully
    When a "ssm" "parameter" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read
