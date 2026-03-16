@lambdacognito @generated
Feature: LambdaCognito - Action Sequences

  # Generated from FizzBee spec: lambda_cognito.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationCalledAPool

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Lambda function is deployed
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Cognito user pool is deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function is invoked
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Lambda function is deployed
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Cognito user pool is created
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function is invoked
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is created
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is deleted
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function fails to call Cognito because the pool has been deleted
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is created
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is deleted
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is created then a Cognito user pool is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a Cognito user pool is created
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is created then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When a Cognito user pool is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is created then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When a Cognito user pool is created
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is created then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a Cognito user pool is created
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is deleted then a Cognito user pool is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a Cognito user pool is deleted
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is deleted then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When a Cognito user pool is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When a Cognito user pool is deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Cognito user pool is deleted then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a Cognito user pool is deleted
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then a Cognito user pool is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then a Cognito user pool is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Lambda function is deployed then a Cognito user pool is deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Lambda function is deployed
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Lambda function is deployed then the Lambda function is invoked
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Lambda function is deployed then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Lambda function is deployed
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Lambda function is deployed then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Lambda function is deployed
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Cognito user pool is deleted then a Lambda function is deployed
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Cognito user pool is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Cognito user pool is deleted then the Lambda function is invoked
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Cognito user pool is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Cognito user pool is deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Cognito user pool is deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a Cognito user pool is deleted then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When a Cognito user pool is deleted
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function is invoked then a Lambda function is deployed
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function is invoked then a Cognito user pool is deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function is invoked
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function is invoked then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function is invoked
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function is invoked then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function is invoked
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Lambda function is deployed
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function is invoked
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function fails to call Cognito because the pool has been deleted then a Lambda function is deployed
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function is invoked
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid not in pool_status
    When a Cognito user pool is created
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Lambda function is deployed then a Cognito user pool is created
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Lambda function is deployed
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Lambda function is deployed then the Lambda function is invoked
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Lambda function is deployed then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Lambda function is deployed
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Lambda function is deployed then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Lambda function is deployed
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Cognito user pool is created then a Lambda function is deployed
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Cognito user pool is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Cognito user pool is created then the Lambda function is invoked
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Cognito user pool is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Cognito user pool is created then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Cognito user pool is created
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then a Cognito user pool is created then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid in pool_status
    When a Cognito user pool is deleted
    When a Cognito user pool is created
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function is invoked then a Lambda function is deployed
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function is invoked then a Cognito user pool is created
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function is invoked
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function is invoked then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function is invoked
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function is invoked then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function is invoked
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Lambda function is deployed
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is created
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function is invoked
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function fails to call Cognito because the pool has been deleted
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function fails to call Cognito because the pool has been deleted then a Lambda function is deployed
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is created
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function is invoked
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: a Cognito user pool is deleted then the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid in pool_status
    When a Cognito user pool is deleted
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then a Cognito user pool is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then a Cognito user pool is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is created then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Cognito user pool is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is created then a Cognito user pool is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Cognito user pool is created
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is created then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When a Cognito user pool is created
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is created then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Cognito user pool is created
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is deleted then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Cognito user pool is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is deleted then a Cognito user pool is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Cognito user pool is deleted
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When a Cognito user pool is deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Cognito user pool is deleted then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Cognito user pool is deleted
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function fails to call Cognito because the pool has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to call Cognito because the pool has been deleted then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Lambda function is deployed then a Cognito user pool is created
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Lambda function is deployed
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Lambda function is deployed then a Cognito user pool is deleted
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Lambda function is deployed
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Lambda function is deployed then the Lambda function fails to call Cognito because the pool has been deleted
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Lambda function is deployed
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is created then a Cognito user pool is deleted
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is created
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is created then the Lambda function fails to call Cognito because the pool has been deleted
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is created
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is deleted then a Cognito user pool is created
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is deleted
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is deleted then the Lambda function fails to call Cognito because the pool has been deleted
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is deleted
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function is invoked then a Cognito user pool is created
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function is invoked
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function is invoked then a Cognito user pool is deleted
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function is invoked
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function is invoked then the Lambda function fails to call Cognito because the pool has been deleted
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function is invoked
    When the Lambda function fails to call Cognito because the pool has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function fails to call Cognito because the pool has been deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is created
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is deleted
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Lambda function is deployed then a Cognito user pool is created
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Lambda function is deployed
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Lambda function is deployed then a Cognito user pool is deleted
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Lambda function is deployed
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Lambda function is deployed then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Lambda function is deployed
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is created then a Cognito user pool is deleted
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is created
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is created then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is created
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is deleted then a Cognito user pool is created
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is deleted
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then a Cognito user pool is deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When a Cognito user pool is deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function is invoked then a Cognito user pool is created
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function is invoked
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function is invoked then a Cognito user pool is deleted
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function is invoked
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function is invoked then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function is invoked
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is created
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a Cognito user pool is deleted
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a Cognito user pool is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @exhaustive @sequence
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted then the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to call Cognito because the pool has been deleted
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called
