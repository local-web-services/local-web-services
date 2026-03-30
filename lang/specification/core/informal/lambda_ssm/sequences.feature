@lambdassm @generated
Feature: LambdaSsm - Action Sequences

  # Generated from FizzBee spec: lambda_ssm.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadAParameter

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Lambda function is deployed then a parameter is created in "SSM" Parameter Store
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a parameter is created in "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a Lambda function is deployed then a parameter is deleted from "SSM" Parameter Store
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a parameter is deleted from "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function reads an existing parameter and completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function reads an existing parameter and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails because the parameter has been deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function fails because the parameter has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a Lambda function is deployed
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then the Lambda function is invoked
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then the Lambda function reads an existing parameter and completes successfully
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    When the Lambda function reads an existing parameter and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then the Lambda function fails because the parameter has been deleted
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    When the Lambda function fails because the parameter has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a Lambda function is deployed
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then the Lambda function is invoked
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then the Lambda function reads an existing parameter and completes successfully
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    When the Lambda function reads an existing parameter and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then the Lambda function fails because the parameter has been deleted
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    When the Lambda function fails because the parameter has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function is invoked then a parameter is created in "SSM" Parameter Store
    Given fid in func_status
    Given the Lambda function has been invoked
    When a parameter is created in "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function is invoked then a parameter is deleted from "SSM" Parameter Store
    Given fid in func_status
    Given the Lambda function has been invoked
    When a parameter is deleted from "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function reads an existing parameter and completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function reads an existing parameter and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails because the parameter has been deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function fails because the parameter has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has read an existing parameter and completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then a parameter is created in "SSM" Parameter Store
    Given iid in inv_status
    Given the Lambda function has read an existing parameter and completed successfully
    When a parameter is created in "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then a parameter is deleted from "SSM" Parameter Store
    Given iid in inv_status
    Given the Lambda function has read an existing parameter and completed successfully
    When a parameter is deleted from "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has read an existing parameter and completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then the Lambda function fails because the parameter has been deleted
    Given iid in inv_status
    Given the Lambda function has read an existing parameter and completed successfully
    When the Lambda function fails because the parameter has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed because the parameter has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then a parameter is created in "SSM" Parameter Store
    Given iid in inv_status
    Given the Lambda function has failed because the parameter has been deleted
    When a parameter is created in "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then a parameter is deleted from "SSM" Parameter Store
    Given iid in inv_status
    Given the Lambda function has failed because the parameter has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed because the parameter has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then the Lambda function reads an existing parameter and completes successfully
    Given iid in inv_status
    Given the Lambda function has failed because the parameter has been deleted
    When the Lambda function reads an existing parameter and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a Lambda function is deployed then a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a parameter has been created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a Lambda function is deployed then a parameter is deleted from "SSM" Parameter Store then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a parameter has been deleted from "SSM" Parameter Store
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function reads an existing parameter and completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function reads an existing parameter and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function reads an existing parameter and completes successfully then the Lambda function fails because the parameter has been deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has read an existing parameter and completed successfully
    When the Lambda function fails because the parameter has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails because the parameter has been deleted then a parameter is created in "SSM" Parameter Store
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has failed because the parameter has been deleted
    When a parameter is created in "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a Lambda function is deployed then the Lambda function is invoked
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store then the Lambda function reads an existing parameter and completes successfully
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    Given a parameter has been deleted from "SSM" Parameter Store
    When the Lambda function reads an existing parameter and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then the Lambda function is invoked then the Lambda function fails because the parameter has been deleted
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    Given the Lambda function has been invoked
    When the Lambda function fails because the parameter has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then the Lambda function reads an existing parameter and completes successfully then a Lambda function is deployed
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    Given the Lambda function has read an existing parameter and completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is created in "SSM" Parameter Store then the Lambda function fails because the parameter has been deleted then a parameter is deleted from "SSM" Parameter Store
    Given pid not in param_status
    Given a parameter has been created in "SSM" Parameter Store
    Given the Lambda function has failed because the parameter has been deleted
    When a parameter is deleted from "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a Lambda function is deployed then the Lambda function reads an existing parameter and completes successfully
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    Given a Lambda function has been deployed
    When the Lambda function reads an existing parameter and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store then the Lambda function fails because the parameter has been deleted
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    Given a parameter has been created in "SSM" Parameter Store
    When the Lambda function fails because the parameter has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then the Lambda function is invoked then a Lambda function is deployed
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then the Lambda function reads an existing parameter and completes successfully then a parameter is created in "SSM" Parameter Store
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    Given the Lambda function has read an existing parameter and completed successfully
    When a parameter is created in "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: a parameter is deleted from "SSM" Parameter Store then the Lambda function fails because the parameter has been deleted then the Lambda function is invoked
    Given pid in param_status
    Given a parameter has been deleted from "SSM" Parameter Store
    Given the Lambda function has failed because the parameter has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails because the parameter has been deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda function fails because the parameter has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function is invoked then a parameter is created in "SSM" Parameter Store then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a parameter has been created in "SSM" Parameter Store
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function is invoked then a parameter is deleted from "SSM" Parameter Store then a parameter is created in "SSM" Parameter Store
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a parameter has been deleted from "SSM" Parameter Store
    When a parameter is created in "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function reads an existing parameter and completes successfully then a parameter is deleted from "SSM" Parameter Store
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has read an existing parameter and completed successfully
    When a parameter is deleted from "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails because the parameter has been deleted then the Lambda function reads an existing parameter and completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has failed because the parameter has been deleted
    When the Lambda function reads an existing parameter and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then a Lambda function is deployed then a parameter is created in "SSM" Parameter Store
    Given iid in inv_status
    Given the Lambda function has read an existing parameter and completed successfully
    Given a Lambda function has been deployed
    When a parameter is created in "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then a parameter is created in "SSM" Parameter Store then a parameter is deleted from "SSM" Parameter Store
    Given iid in inv_status
    Given the Lambda function has read an existing parameter and completed successfully
    Given a parameter has been created in "SSM" Parameter Store
    When a parameter is deleted from "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then a parameter is deleted from "SSM" Parameter Store then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has read an existing parameter and completed successfully
    Given a parameter has been deleted from "SSM" Parameter Store
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then the Lambda function is invoked then the Lambda function fails because the parameter has been deleted
    Given iid in inv_status
    Given the Lambda function has read an existing parameter and completed successfully
    Given the Lambda function has been invoked
    When the Lambda function fails because the parameter has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function reads an existing parameter and completes successfully then the Lambda function fails because the parameter has been deleted then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has read an existing parameter and completed successfully
    Given the Lambda function has failed because the parameter has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then a Lambda function is deployed then a parameter is deleted from "SSM" Parameter Store
    Given iid in inv_status
    Given the Lambda function has failed because the parameter has been deleted
    Given a Lambda function has been deployed
    When a parameter is deleted from "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then a parameter is created in "SSM" Parameter Store then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed because the parameter has been deleted
    Given a parameter has been created in "SSM" Parameter Store
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then a parameter is deleted from "SSM" Parameter Store then the Lambda function reads an existing parameter and completes successfully
    Given iid in inv_status
    Given the Lambda function has failed because the parameter has been deleted
    Given a parameter has been deleted from "SSM" Parameter Store
    When the Lambda function reads an existing parameter and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed because the parameter has been deleted
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @sequence
  Scenario: the Lambda function fails because the parameter has been deleted then the Lambda function reads an existing parameter and completes successfully then a parameter is created in "SSM" Parameter Store
    Given iid in inv_status
    Given the Lambda function has failed because the parameter has been deleted
    Given the Lambda function has read an existing parameter and completed successfully
    When a parameter is created in "SSM" Parameter Store
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read
