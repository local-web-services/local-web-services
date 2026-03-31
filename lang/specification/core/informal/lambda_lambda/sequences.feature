@lambdalambda @generated
Feature: LambdaLambda - Action Sequences

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @sequence
  Scenario: a caller "lambda" "function" is deployed then a callee "lambda" "function" is deployed
    Given fid not in caller_status
    When a caller "lambda" "function" is deployed
    When a callee "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller "lambda" "function" is deployed then the callee "lambda" "function" is deleted
    Given fid not in caller_status
    When a caller "lambda" "function" is deployed
    When the callee "lambda" "function" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller "lambda" "function" is deployed then the caller "lambda" "function" is invoked
    Given fid not in caller_status
    When a caller "lambda" "function" is deployed
    When the caller "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller "lambda" "function" is deployed then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Given fid not in caller_status
    When a caller "lambda" "function" is deployed
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller "lambda" "function" is deployed then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Given fid not in caller_status
    When a caller "lambda" "function" is deployed
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee "lambda" "function" is deployed then a caller "lambda" "function" is deployed
    Given fid not in callee_status
    When a callee "lambda" "function" is deployed
    When a caller "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee "lambda" "function" is deployed then the callee "lambda" "function" is deleted
    Given fid not in callee_status
    When a callee "lambda" "function" is deployed
    When the callee "lambda" "function" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee "lambda" "function" is deployed then the caller "lambda" "function" is invoked
    Given fid not in callee_status
    When a callee "lambda" "function" is deployed
    When the caller "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee "lambda" "function" is deployed then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Given fid not in callee_status
    When a callee "lambda" "function" is deployed
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee "lambda" "function" is deployed then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Given fid not in callee_status
    When a callee "lambda" "function" is deployed
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee "lambda" "function" is deleted then a caller "lambda" "function" is deployed
    Given fid in callee_status
    When the callee "lambda" "function" is deleted
    When a caller "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee "lambda" "function" is deleted then a callee "lambda" "function" is deployed
    Given fid in callee_status
    When the callee "lambda" "function" is deleted
    When a callee "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee "lambda" "function" is deleted then the caller "lambda" "function" is invoked
    Given fid in callee_status
    When the callee "lambda" "function" is deleted
    When the caller "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee "lambda" "function" is deleted then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Given fid in callee_status
    When the callee "lambda" "function" is deleted
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee "lambda" "function" is deleted then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Given fid in callee_status
    When the callee "lambda" "function" is deleted
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" is invoked then a caller "lambda" "function" is deployed
    Given cfid in caller_status
    When the caller "lambda" "function" is invoked
    When a caller "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" is invoked then a callee "lambda" "function" is deployed
    Given cfid in caller_status
    When the caller "lambda" "function" is invoked
    When a callee "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" is invoked then the callee "lambda" "function" is deleted
    Given cfid in caller_status
    When the caller "lambda" "function" is invoked
    When the callee "lambda" "function" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" is invoked then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Given cfid in caller_status
    When the caller "lambda" "function" is invoked
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" is invoked then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Given cfid in caller_status
    When the caller "lambda" "function" is invoked
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then a caller "lambda" "function" is deployed
    Given iid in inv_status
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When a caller "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then a callee "lambda" "function" is deployed
    Given iid in inv_status
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When a callee "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then the callee "lambda" "function" is deleted
    Given iid in inv_status
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When the callee "lambda" "function" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then the caller "lambda" "function" is invoked
    Given iid in inv_status
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When the caller "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Given iid in inv_status
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then a caller "lambda" "function" is deployed
    Given iid in inv_status
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When a caller "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then a callee "lambda" "function" is deployed
    Given iid in inv_status
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When a callee "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then the callee "lambda" "function" is deleted
    Given iid in inv_status
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When the callee "lambda" "function" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then the caller "lambda" "function" is invoked
    Given iid in inv_status
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When the caller "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Given iid in inv_status
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller "lambda" "function" is deployed then a callee "lambda" "function" is deployed then the callee "lambda" "function" is deleted
    Given fid not in caller_status
    When a caller "lambda" "function" is deployed
    When a callee "lambda" "function" is deployed
    When the callee "lambda" "function" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller "lambda" "function" is deployed then the callee "lambda" "function" is deleted then the caller "lambda" "function" is invoked
    Given fid not in caller_status
    When a caller "lambda" "function" is deployed
    When the callee "lambda" "function" is deleted
    When the caller "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller "lambda" "function" is deployed then the caller "lambda" "function" is invoked then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Given fid not in caller_status
    When a caller "lambda" "function" is deployed
    When the caller "lambda" "function" is invoked
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller "lambda" "function" is deployed then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Given fid not in caller_status
    When a caller "lambda" "function" is deployed
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller "lambda" "function" is deployed then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then a callee "lambda" "function" is deployed
    Given fid not in caller_status
    When a caller "lambda" "function" is deployed
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When a callee "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee "lambda" "function" is deployed then a caller "lambda" "function" is deployed then the caller "lambda" "function" is invoked
    Given fid not in callee_status
    When a callee "lambda" "function" is deployed
    When a caller "lambda" "function" is deployed
    When the caller "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee "lambda" "function" is deployed then the callee "lambda" "function" is deleted then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Given fid not in callee_status
    When a callee "lambda" "function" is deployed
    When the callee "lambda" "function" is deleted
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee "lambda" "function" is deployed then the caller "lambda" "function" is invoked then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Given fid not in callee_status
    When a callee "lambda" "function" is deployed
    When the caller "lambda" "function" is invoked
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee "lambda" "function" is deployed then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then a caller "lambda" "function" is deployed
    Given fid not in callee_status
    When a callee "lambda" "function" is deployed
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When a caller "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee "lambda" "function" is deployed then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then the callee "lambda" "function" is deleted
    Given fid not in callee_status
    When a callee "lambda" "function" is deployed
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When the callee "lambda" "function" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee "lambda" "function" is deleted then a caller "lambda" "function" is deployed then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Given fid in callee_status
    When the callee "lambda" "function" is deleted
    When a caller "lambda" "function" is deployed
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee "lambda" "function" is deleted then a callee "lambda" "function" is deployed then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Given fid in callee_status
    When the callee "lambda" "function" is deleted
    When a callee "lambda" "function" is deployed
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee "lambda" "function" is deleted then the caller "lambda" "function" is invoked then a caller "lambda" "function" is deployed
    Given fid in callee_status
    When the callee "lambda" "function" is deleted
    When the caller "lambda" "function" is invoked
    When a caller "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee "lambda" "function" is deleted then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then a callee "lambda" "function" is deployed
    Given fid in callee_status
    When the callee "lambda" "function" is deleted
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When a callee "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee "lambda" "function" is deleted then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then the caller "lambda" "function" is invoked
    Given fid in callee_status
    When the callee "lambda" "function" is deleted
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When the caller "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" is invoked then a caller "lambda" "function" is deployed then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Given cfid in caller_status
    When the caller "lambda" "function" is invoked
    When a caller "lambda" "function" is deployed
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" is invoked then a callee "lambda" "function" is deployed then a caller "lambda" "function" is deployed
    Given cfid in caller_status
    When the caller "lambda" "function" is invoked
    When a callee "lambda" "function" is deployed
    When a caller "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" is invoked then the callee "lambda" "function" is deleted then a callee "lambda" "function" is deployed
    Given cfid in caller_status
    When the caller "lambda" "function" is invoked
    When the callee "lambda" "function" is deleted
    When a callee "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" is invoked then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then the callee "lambda" "function" is deleted
    Given cfid in caller_status
    When the caller "lambda" "function" is invoked
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When the callee "lambda" "function" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" is invoked then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Given cfid in caller_status
    When the caller "lambda" "function" is invoked
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then a caller "lambda" "function" is deployed then a callee "lambda" "function" is deployed
    Given iid in inv_status
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When a caller "lambda" "function" is deployed
    When a callee "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then a callee "lambda" "function" is deployed then the callee "lambda" "function" is deleted
    Given iid in inv_status
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When a callee "lambda" "function" is deployed
    When the callee "lambda" "function" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then the callee "lambda" "function" is deleted then the caller "lambda" "function" is invoked
    Given iid in inv_status
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When the callee "lambda" "function" is deleted
    When the caller "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then the caller "lambda" "function" is invoked then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Given iid in inv_status
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When the caller "lambda" "function" is invoked
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then a caller "lambda" "function" is deployed
    Given iid in inv_status
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When a caller "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then a caller "lambda" "function" is deployed then the callee "lambda" "function" is deleted
    Given iid in inv_status
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When a caller "lambda" "function" is deployed
    When the callee "lambda" "function" is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then a callee "lambda" "function" is deployed then the caller "lambda" "function" is invoked
    Given iid in inv_status
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When a callee "lambda" "function" is deployed
    When the caller "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then the callee "lambda" "function" is deleted then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Given iid in inv_status
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When the callee "lambda" "function" is deleted
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then the caller "lambda" "function" is invoked then a caller "lambda" "function" is deployed
    Given iid in inv_status
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When the caller "lambda" "function" is invoked
    When a caller "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted then the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds then a callee "lambda" "function" is deployed
    Given iid in inv_status
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    When a callee "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked
