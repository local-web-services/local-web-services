@lambdassm @generated
Feature: LambdaSsm - Action Sequences

  # Generated from FizzBee spec: lambda_ssm.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadAParameter

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a parameter is created in "SSM" Parameter Store
    Given fid not in func_status
    When a Lambda function is deployed
    When a parameter is created in "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a parameter is deleted from "SSM" Parameter Store
    Given fid not in func_status
    When a Lambda function is deployed
    When a parameter is deleted from "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function reads an existing parameter and completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function reads an existing parameter and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails because the parameter has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails because the parameter has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a Lambda function is deployed
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then the Lambda function is invoked
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then the Lambda function reads an existing parameter and completes successfully
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When the Lambda function reads an existing parameter and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then the Lambda function fails because the parameter has been deleted
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When the Lambda function fails because the parameter has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a Lambda function is deployed
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then the Lambda function is invoked
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then the Lambda function reads an existing parameter and completes successfully
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When the Lambda function reads an existing parameter and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then the Lambda function fails because the parameter has been deleted
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When the Lambda function fails because the parameter has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a parameter is created in "SSM" Parameter Store
    Given fid in func_status
    When the Lambda function is invoked
    When a parameter is created in "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a parameter is deleted from "SSM" Parameter Store
    Given fid in func_status
    When the Lambda function is invoked
    When a parameter is deleted from "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function reads an existing parameter and completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function reads an existing parameter and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails because the parameter has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails because the parameter has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function reads an existing parameter and completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then a parameter is created in "SSM" Parameter Store
    Given iid in inv_status
    When the Lambda function reads an existing parameter and completes successfully
    When a parameter is created in "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then a parameter is deleted from "SSM" Parameter Store
    Given iid in inv_status
    When the Lambda function reads an existing parameter and completes successfully
    When a parameter is deleted from "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function reads an existing parameter and completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then the Lambda function fails because the parameter has been deleted
    Given iid in inv_status
    When the Lambda function reads an existing parameter and completes successfully
    When the Lambda function fails because the parameter has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails because the parameter has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then a parameter is created in "SSM" Parameter Store
    Given iid in inv_status
    When the Lambda function fails because the parameter has been deleted
    When a parameter is created in "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then a parameter is deleted from "SSM" Parameter Store
    Given iid in inv_status
    When the Lambda function fails because the parameter has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails because the parameter has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then the Lambda function reads an existing parameter and completes successfully
    Given iid in inv_status
    When the Lambda function fails because the parameter has been deleted
    When the Lambda function reads an existing parameter and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given fid not in func_status
    When a Lambda function is deployed
    When a parameter is created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a parameter is deleted from "SSM" Parameter Store then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When a parameter is deleted from "SSM" Parameter Store
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function reads an existing parameter and completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function reads an existing parameter and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function reads an existing parameter and completes successfully then the Lambda function fails because the parameter has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function reads an existing parameter and completes successfully
    When the Lambda function fails because the parameter has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails because the parameter has been deleted then a parameter is created in "SSM" Parameter Store
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails because the parameter has been deleted
    When a parameter is created in "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a Lambda function is deployed then the Lambda function is invoked
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store then the Lambda function reads an existing parameter and completes successfully
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    When the Lambda function reads an existing parameter and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then the Lambda function is invoked then the Lambda function fails because the parameter has been deleted
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When the Lambda function is invoked
    When the Lambda function fails because the parameter has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then the Lambda function reads an existing parameter and completes successfully then a Lambda function is deployed
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When the Lambda function reads an existing parameter and completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then the Lambda function fails because the parameter has been deleted then a parameter is deleted from "SSM" Parameter Store
    Given pid not in param_status
    When a parameter is created in "SSM" Parameter Store
    When the Lambda function fails because the parameter has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a Lambda function is deployed then the Lambda function reads an existing parameter and completes successfully
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a Lambda function is deployed
    When the Lambda function reads an existing parameter and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store then the Lambda function fails because the parameter has been deleted
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    When the Lambda function fails because the parameter has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then the Lambda function is invoked then a Lambda function is deployed
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then the Lambda function reads an existing parameter and completes successfully then a parameter is created in "SSM" Parameter Store
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When the Lambda function reads an existing parameter and completes successfully
    When a parameter is created in "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then the Lambda function fails because the parameter has been deleted then the Lambda function is invoked
    Given pid in param_status
    When a parameter is deleted from "SSM" Parameter Store
    When the Lambda function fails because the parameter has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails because the parameter has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function fails because the parameter has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a parameter is created in "SSM" Parameter Store then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a parameter is created in "SSM" Parameter Store
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store
    Given fid in func_status
    When the Lambda function is invoked
    When a parameter is deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function reads an existing parameter and completes successfully then a parameter is deleted from "SSM" Parameter Store
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function reads an existing parameter and completes successfully
    When a parameter is deleted from "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails because the parameter has been deleted then the Lambda function reads an existing parameter and completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails because the parameter has been deleted
    When the Lambda function reads an existing parameter and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then a Lambda function is deployed then a parameter is created in "SSM" Parameter Store
    Given iid in inv_status
    When the Lambda function reads an existing parameter and completes successfully
    When a Lambda function is deployed
    When a parameter is created in "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given iid in inv_status
    When the Lambda function reads an existing parameter and completes successfully
    When a parameter is created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then a parameter is deleted from "SSM" Parameter Store then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function reads an existing parameter and completes successfully
    When a parameter is deleted from "SSM" Parameter Store
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then the Lambda function is invoked then the Lambda function fails because the parameter has been deleted
    Given iid in inv_status
    When the Lambda function reads an existing parameter and completes successfully
    When the Lambda function is invoked
    When the Lambda function fails because the parameter has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then the Lambda function fails because the parameter has been deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function reads an existing parameter and completes successfully
    When the Lambda function fails because the parameter has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then a Lambda function is deployed then a parameter is deleted from "SSM" Parameter Store
    Given iid in inv_status
    When the Lambda function fails because the parameter has been deleted
    When a Lambda function is deployed
    When a parameter is deleted from "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then a parameter is created in "SSM" Parameter Store then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails because the parameter has been deleted
    When a parameter is created in "SSM" Parameter Store
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then a parameter is deleted from "SSM" Parameter Store then the Lambda function reads an existing parameter and completes successfully
    Given iid in inv_status
    When the Lambda function fails because the parameter has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    When the Lambda function reads an existing parameter and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails because the parameter has been deleted
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then the Lambda function reads an existing parameter and completes successfully then a parameter is created in "SSM" Parameter Store
    Given iid in inv_status
    When the Lambda function fails because the parameter has been deleted
    When the Lambda function reads an existing parameter and completes successfully
    When a parameter is created in "SSM" Parameter Store
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read
