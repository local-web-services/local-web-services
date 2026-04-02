@lambdacognito @generated
Feature: LambdaCognito - Action Sequences

  # Generated from FizzBee spec: lambda_cognito.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationCalledAPool

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a "cognito" "user pool" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "lambda" "function" is deployed then a "cognito" "user pool" is deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "cognito" "user pool" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is created then a "lambda" "function" is deployed
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user pool" is deleted
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is created then the "lambda" "function" is invoked
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is created then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is created then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "lambda" "function" is deployed
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then the "lambda" "function" is invoked
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" is invoked then a "cognito" "user pool" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" is invoked then a "cognito" "user pool" is deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "cognito" "user pool" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a "cognito" "user pool" is created
    Given iid in inv_status
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a "cognito" "user pool" is deleted
    Given iid in inv_status
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a "cognito" "user pool" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Given iid in inv_status
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then a "cognito" "user pool" is created
    Given iid in inv_status
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then a "cognito" "user pool" is deleted
    Given iid in inv_status
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When a "cognito" "user pool" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "lambda" "function" is deployed then a "cognito" "user pool" is created then a "cognito" "user pool" is deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "lambda" "function" is deployed then a "cognito" "user pool" is deleted then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "cognito" "user pool" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then a "cognito" "user pool" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is created then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user pool" is deleted then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" is deleted
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is created then the "lambda" "function" is invoked then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is created then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a "lambda" "function" is deployed
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is created then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then a "cognito" "user pool" is deleted
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When a "cognito" "user pool" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "lambda" "function" is deployed then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When a "lambda" "function" is deployed
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user pool" is created then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user pool" is created
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: a "cognito" "user pool" is deleted then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then the "lambda" "function" is invoked
    Given pid in pool_status
    When a "cognito" "user pool" is deleted
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" is invoked then a "cognito" "user pool" is created then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "cognito" "user pool" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" is invoked then a "cognito" "user pool" is deleted then a "cognito" "user pool" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "cognito" "user pool" is deleted
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a "cognito" "user pool" is deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a "cognito" "user pool" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a "lambda" "function" is deployed then a "cognito" "user pool" is created
    Given iid in inv_status
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a "lambda" "function" is deployed
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a "cognito" "user pool" is created then a "cognito" "user pool" is deleted
    Given iid in inv_status
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a "cognito" "user pool" is deleted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a "cognito" "user pool" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the "lambda" "function" is invoked then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Given iid in inv_status
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then a "lambda" "function" is deployed then a "cognito" "user pool" is deleted
    Given iid in inv_status
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When a "lambda" "function" is deployed
    When a "cognito" "user pool" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then a "cognito" "user pool" is created then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When a "cognito" "user pool" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then a "cognito" "user pool" is deleted then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When a "cognito" "user pool" is deleted
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @sequence
  Scenario: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted then the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds then a "cognito" "user pool" is created
    Given iid in inv_status
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called
