@lambdacognito @generated
Feature: LambdaCognito - Action Sequences

  # Generated from FizzBee spec: lambda_cognito.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationCalledAPool

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a Cognito user pool is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a Cognito user pool is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function fails to call Cognito because the pool has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is created then a Lambda function is deployed
    Given pid not in pool_status
    Given a Cognito user pool has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is created then a Cognito user pool is deleted
    Given pid not in pool_status
    Given a Cognito user pool has been created
    When a Cognito user pool is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is created then the Lambda function is invoked
    Given pid not in pool_status
    Given a Cognito user pool has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is created then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid not in pool_status
    Given a Cognito user pool has been created
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is created then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid not in pool_status
    Given a Cognito user pool has been created
    When the Lambda function fails to call Cognito because the pool has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is deleted then a Lambda function is deployed
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is deleted then a Cognito user pool is created
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    When a Cognito user pool is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function is invoked
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    When the Lambda function fails to call Cognito because the pool has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is created
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Cognito user pool is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Cognito user pool is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function fails to call Cognito because the pool has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is created
    Given iid in inv_status
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    When a Cognito user pool is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is deleted
    Given iid in inv_status
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    When a Cognito user pool is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function fails to call Cognito because the pool has been deleted
    Given iid in inv_status
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    When the Lambda function fails to call Cognito because the pool has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is created
    Given iid in inv_status
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    When a Cognito user pool is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is deleted
    Given iid in inv_status
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    When a Cognito user pool is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is created then a Cognito user pool is deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a Cognito user pool has been created
    When a Cognito user pool is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is deleted then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a Cognito user pool has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    When the Lambda function fails to call Cognito because the pool has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    When a Cognito user pool is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is created then a Lambda function is deployed then the Lambda function is invoked
    Given pid not in pool_status
    Given a Cognito user pool has been created
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is created then a Cognito user pool is deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid not in pool_status
    Given a Cognito user pool has been created
    Given a Cognito user pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is created then the Lambda function is invoked then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid not in pool_status
    Given a Cognito user pool has been created
    Given the Lambda function has been invoked
    When the Lambda function fails to call Cognito because the pool has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is created then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Lambda function is deployed
    Given pid not in pool_status
    Given a Cognito user pool has been created
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is created then the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is deleted
    Given pid not in pool_status
    Given a Cognito user pool has been created
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    When a Cognito user pool is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is deleted then a Lambda function is deployed then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    Given a Lambda function has been deployed
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is deleted then a Cognito user pool is created then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    Given a Cognito user pool has been created
    When the Lambda function fails to call Cognito because the pool has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function is invoked then a Lambda function is deployed
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is created
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    When a Cognito user pool is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function is invoked
    Given pid in pool_status
    Given a Cognito user pool has been deleted
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda function fails to call Cognito because the pool has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is created then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Cognito user pool has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is deleted then a Cognito user pool is created
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Cognito user pool has been deleted
    When a Cognito user pool is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    When a Cognito user pool is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Lambda function is deployed then a Cognito user pool is created
    Given iid in inv_status
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    Given a Lambda function has been deployed
    When a Cognito user pool is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is created then a Cognito user pool is deleted
    Given iid in inv_status
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    Given a Cognito user pool has been created
    When a Cognito user pool is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is deleted then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    Given a Cognito user pool has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function is invoked then the Lambda function fails to call Cognito because the pool has been deleted
    Given iid in inv_status
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    Given the Lambda function has been invoked
    When the Lambda function fails to call Cognito because the pool has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function fails to call Cognito because the pool has been deleted then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Lambda function is deployed then a Cognito user pool is deleted
    Given iid in inv_status
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    Given a Lambda function has been deployed
    When a Cognito user pool is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is created then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    Given a Cognito user pool has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    Given a Cognito user pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is created
    Given iid in inv_status
    Given the Lambda function has failed to call Cognito because the pool has been deleted
    Given the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded
    When a Cognito user pool is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called
