@lambdalambda @generated
Feature: LambdaLambda - Action Sequences

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then a callee Lambda function is deployed
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the callee Lambda function is deleted
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function is invoked
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then a caller Lambda function is deployed
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the callee Lambda function is deleted
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function is invoked
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then a caller Lambda function is deployed
    Given fid in callee_status
    When the callee Lambda function is deleted
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then a callee Lambda function is deployed
    Given fid in callee_status
    When the callee Lambda function is deleted
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function is invoked
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller fails to invoke the callee because the callee has been deleted
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then a caller Lambda function is deployed
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then a callee Lambda function is deployed
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the callee Lambda function is deleted
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the caller fails to invoke the callee because the callee has been deleted
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a caller Lambda function is deployed
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a callee Lambda function is deployed
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the callee Lambda function is deleted
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller Lambda function is invoked
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller fails to invoke the callee because the callee has been deleted
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a caller Lambda function is deployed
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a callee Lambda function is deployed
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the callee Lambda function is deleted
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function is invoked
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then a callee Lambda function is deployed then the callee Lambda function is deleted
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When a callee Lambda function is deployed
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then a callee Lambda function is deployed then the caller Lambda function is invoked
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When a callee Lambda function is deployed
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then a callee Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When a callee Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then a callee Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When a callee Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the callee Lambda function is deleted then a callee Lambda function is deployed
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the callee Lambda function is deleted
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the callee Lambda function is deleted then the caller Lambda function is invoked
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the callee Lambda function is deleted
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the callee Lambda function is deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the callee Lambda function is deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the callee Lambda function is deleted then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the callee Lambda function is deleted
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function is invoked then a callee Lambda function is deployed
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller Lambda function is invoked
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function is invoked then the callee Lambda function is deleted
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller Lambda function is invoked
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function is invoked then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller Lambda function is invoked
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function is invoked then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller Lambda function is invoked
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a callee Lambda function is deployed
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the callee Lambda function is deleted
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller Lambda function is invoked
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted then a callee Lambda function is deployed
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted then the callee Lambda function is deleted
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function is invoked
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a caller Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in caller_status
    When a caller Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then a caller Lambda function is deployed then the callee Lambda function is deleted
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When a caller Lambda function is deployed
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then a caller Lambda function is deployed then the caller Lambda function is invoked
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When a caller Lambda function is deployed
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then a caller Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When a caller Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then a caller Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When a caller Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the callee Lambda function is deleted then a caller Lambda function is deployed
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the callee Lambda function is deleted
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the callee Lambda function is deleted then the caller Lambda function is invoked
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the callee Lambda function is deleted
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the callee Lambda function is deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the callee Lambda function is deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the callee Lambda function is deleted then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the callee Lambda function is deleted
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function is invoked then a caller Lambda function is deployed
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller Lambda function is invoked
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function is invoked then the callee Lambda function is deleted
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller Lambda function is invoked
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function is invoked then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller Lambda function is invoked
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function is invoked then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller Lambda function is invoked
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a caller Lambda function is deployed
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the callee Lambda function is deleted
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller Lambda function is invoked
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted then a caller Lambda function is deployed
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted then the callee Lambda function is deleted
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function is invoked
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: a callee Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in callee_status
    When a callee Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then a caller Lambda function is deployed then a callee Lambda function is deployed
    Given fid in callee_status
    When the callee Lambda function is deleted
    When a caller Lambda function is deployed
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then a caller Lambda function is deployed then the caller Lambda function is invoked
    Given fid in callee_status
    When the callee Lambda function is deleted
    When a caller Lambda function is deployed
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then a caller Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid in callee_status
    When the callee Lambda function is deleted
    When a caller Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then a caller Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given fid in callee_status
    When the callee Lambda function is deleted
    When a caller Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then a callee Lambda function is deployed then a caller Lambda function is deployed
    Given fid in callee_status
    When the callee Lambda function is deleted
    When a callee Lambda function is deployed
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then a callee Lambda function is deployed then the caller Lambda function is invoked
    Given fid in callee_status
    When the callee Lambda function is deleted
    When a callee Lambda function is deployed
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then a callee Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid in callee_status
    When the callee Lambda function is deleted
    When a callee Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then a callee Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given fid in callee_status
    When the callee Lambda function is deleted
    When a callee Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function is invoked then a caller Lambda function is deployed
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller Lambda function is invoked
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function is invoked then a callee Lambda function is deployed
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller Lambda function is invoked
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function is invoked then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller Lambda function is invoked
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function is invoked then the caller fails to invoke the callee because the callee has been deleted
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller Lambda function is invoked
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a caller Lambda function is deployed
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a callee Lambda function is deployed
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller Lambda function is invoked
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller fails to invoke the callee because the callee has been deleted
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller fails to invoke the callee because the callee has been deleted then a caller Lambda function is deployed
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller fails to invoke the callee because the callee has been deleted
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller fails to invoke the callee because the callee has been deleted then a callee Lambda function is deployed
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller fails to invoke the callee because the callee has been deleted
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function is invoked
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the callee Lambda function is deleted then the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid in callee_status
    When the callee Lambda function is deleted
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then a caller Lambda function is deployed then a callee Lambda function is deployed
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When a caller Lambda function is deployed
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then a caller Lambda function is deployed then the callee Lambda function is deleted
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When a caller Lambda function is deployed
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then a caller Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When a caller Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then a caller Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When a caller Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then a callee Lambda function is deployed then a caller Lambda function is deployed
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When a callee Lambda function is deployed
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then a callee Lambda function is deployed then the callee Lambda function is deleted
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When a callee Lambda function is deployed
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then a callee Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When a callee Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then a callee Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When a callee Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the callee Lambda function is deleted then a caller Lambda function is deployed
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the callee Lambda function is deleted
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the callee Lambda function is deleted then a callee Lambda function is deployed
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the callee Lambda function is deleted
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the callee Lambda function is deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the callee Lambda function is deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the callee Lambda function is deleted then the caller fails to invoke the callee because the callee has been deleted
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the callee Lambda function is deleted
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a caller Lambda function is deployed
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a callee Lambda function is deployed
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the callee Lambda function is deleted
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller fails to invoke the callee because the callee has been deleted
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the caller fails to invoke the callee because the callee has been deleted then a caller Lambda function is deployed
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the caller fails to invoke the callee because the callee has been deleted
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the caller fails to invoke the callee because the callee has been deleted then a callee Lambda function is deployed
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the caller fails to invoke the callee because the callee has been deleted
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the caller fails to invoke the callee because the callee has been deleted then the callee Lambda function is deleted
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the caller fails to invoke the callee because the callee has been deleted
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function is invoked then the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given cfid in caller_status
    When the caller Lambda function is invoked
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a caller Lambda function is deployed then a callee Lambda function is deployed
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a caller Lambda function is deployed
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a caller Lambda function is deployed then the callee Lambda function is deleted
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a caller Lambda function is deployed
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a caller Lambda function is deployed then the caller Lambda function is invoked
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a caller Lambda function is deployed
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a caller Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a caller Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a callee Lambda function is deployed then a caller Lambda function is deployed
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a callee Lambda function is deployed
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a callee Lambda function is deployed then the callee Lambda function is deleted
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a callee Lambda function is deployed
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a callee Lambda function is deployed then the caller Lambda function is invoked
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a callee Lambda function is deployed
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a callee Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a callee Lambda function is deployed
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the callee Lambda function is deleted then a caller Lambda function is deployed
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the callee Lambda function is deleted
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the callee Lambda function is deleted then a callee Lambda function is deployed
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the callee Lambda function is deleted
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the callee Lambda function is deleted then the caller Lambda function is invoked
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the callee Lambda function is deleted
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the callee Lambda function is deleted then the caller fails to invoke the callee because the callee has been deleted
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the callee Lambda function is deleted
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller Lambda function is invoked then a caller Lambda function is deployed
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller Lambda function is invoked
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller Lambda function is invoked then a callee Lambda function is deployed
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller Lambda function is invoked
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller Lambda function is invoked then the callee Lambda function is deleted
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller Lambda function is invoked
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller Lambda function is invoked then the caller fails to invoke the callee because the callee has been deleted
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller Lambda function is invoked
    When the caller fails to invoke the callee because the callee has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller fails to invoke the callee because the callee has been deleted then a caller Lambda function is deployed
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller fails to invoke the callee because the callee has been deleted
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller fails to invoke the callee because the callee has been deleted then a callee Lambda function is deployed
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller fails to invoke the callee because the callee has been deleted
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller fails to invoke the callee because the callee has been deleted then the callee Lambda function is deleted
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller fails to invoke the callee because the callee has been deleted
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function is invoked
    Given iid in inv_status
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a caller Lambda function is deployed then a callee Lambda function is deployed
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When a caller Lambda function is deployed
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a caller Lambda function is deployed then the callee Lambda function is deleted
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When a caller Lambda function is deployed
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a caller Lambda function is deployed then the caller Lambda function is invoked
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When a caller Lambda function is deployed
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a caller Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When a caller Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a callee Lambda function is deployed then a caller Lambda function is deployed
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When a callee Lambda function is deployed
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a callee Lambda function is deployed then the callee Lambda function is deleted
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When a callee Lambda function is deployed
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a callee Lambda function is deployed then the caller Lambda function is invoked
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When a callee Lambda function is deployed
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a callee Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When a callee Lambda function is deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the callee Lambda function is deleted then a caller Lambda function is deployed
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the callee Lambda function is deleted
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the callee Lambda function is deleted then a callee Lambda function is deployed
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the callee Lambda function is deleted
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the callee Lambda function is deleted then the caller Lambda function is invoked
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the callee Lambda function is deleted
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the callee Lambda function is deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the callee Lambda function is deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function is invoked then a caller Lambda function is deployed
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function is invoked
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function is invoked then a callee Lambda function is deployed
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function is invoked
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function is invoked then the callee Lambda function is deleted
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function is invoked
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function is invoked then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function is invoked
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a caller Lambda function is deployed
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a caller Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a callee Lambda function is deployed
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When a callee Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the callee Lambda function is deleted
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the callee Lambda function is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @exhaustive @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller Lambda function is invoked
    Given iid in inv_status
    When the caller fails to invoke the callee because the callee has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    When the caller Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked
