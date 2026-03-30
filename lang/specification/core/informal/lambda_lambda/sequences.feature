@lambdalambda @generated
Feature: LambdaLambda - Action Sequences

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @sequence
  Scenario: a caller Lambda function is deployed then a callee Lambda function is deployed
    Given fid not in caller_status
    Given a caller Lambda function has been deployed
    When a callee Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller Lambda function is deployed then the callee Lambda function is deleted
    Given fid not in caller_status
    Given a caller Lambda function has been deployed
    When the callee Lambda function is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function is invoked
    Given fid not in caller_status
    Given a caller Lambda function has been deployed
    When the caller Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in caller_status
    Given a caller Lambda function has been deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in caller_status
    Given a caller Lambda function has been deployed
    When the caller fails to invoke the callee because the callee has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee Lambda function is deployed then a caller Lambda function is deployed
    Given fid not in callee_status
    Given a callee Lambda function has been deployed
    When a caller Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee Lambda function is deployed then the callee Lambda function is deleted
    Given fid not in callee_status
    Given a callee Lambda function has been deployed
    When the callee Lambda function is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function is invoked
    Given fid not in callee_status
    Given a callee Lambda function has been deployed
    When the caller Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in callee_status
    Given a callee Lambda function has been deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in callee_status
    Given a callee Lambda function has been deployed
    When the caller fails to invoke the callee because the callee has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee Lambda function is deleted then a caller Lambda function is deployed
    Given fid in callee_status
    Given the callee Lambda function has been deleted
    When a caller Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee Lambda function is deleted then a callee Lambda function is deployed
    Given fid in callee_status
    Given the callee Lambda function has been deleted
    When a callee Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function is invoked
    Given fid in callee_status
    Given the callee Lambda function has been deleted
    When the caller Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid in callee_status
    Given the callee Lambda function has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee Lambda function is deleted then the caller fails to invoke the callee because the callee has been deleted
    Given fid in callee_status
    Given the callee Lambda function has been deleted
    When the caller fails to invoke the callee because the callee has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function is invoked then a caller Lambda function is deployed
    Given cfid in caller_status
    Given the caller Lambda function has been invoked
    When a caller Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function is invoked then a callee Lambda function is deployed
    Given cfid in caller_status
    Given the caller Lambda function has been invoked
    When a callee Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function is invoked then the callee Lambda function is deleted
    Given cfid in caller_status
    Given the caller Lambda function has been invoked
    When the callee Lambda function is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function is invoked then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given cfid in caller_status
    Given the caller Lambda function has been invoked
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function is invoked then the caller fails to invoke the callee because the callee has been deleted
    Given cfid in caller_status
    Given the caller Lambda function has been invoked
    When the caller fails to invoke the callee because the callee has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a caller Lambda function is deployed
    Given iid in inv_status
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    When a caller Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a callee Lambda function is deployed
    Given iid in inv_status
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    When a callee Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the callee Lambda function is deleted
    Given iid in inv_status
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    When the callee Lambda function is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller Lambda function is invoked
    Given iid in inv_status
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    When the caller Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller fails to invoke the callee because the callee has been deleted
    Given iid in inv_status
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    When the caller fails to invoke the callee because the callee has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a caller Lambda function is deployed
    Given iid in inv_status
    Given the caller has failed to invoke the callee because the callee has been deleted
    When a caller Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a callee Lambda function is deployed
    Given iid in inv_status
    Given the caller has failed to invoke the callee because the callee has been deleted
    When a callee Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the callee Lambda function is deleted
    Given iid in inv_status
    Given the caller has failed to invoke the callee because the callee has been deleted
    When the callee Lambda function is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function is invoked
    Given iid in inv_status
    Given the caller has failed to invoke the callee because the callee has been deleted
    When the caller Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given iid in inv_status
    Given the caller has failed to invoke the callee because the callee has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller Lambda function is deployed then a callee Lambda function is deployed then the callee Lambda function is deleted
    Given fid not in caller_status
    Given a caller Lambda function has been deployed
    Given a callee Lambda function has been deployed
    When the callee Lambda function is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller Lambda function is deployed then the callee Lambda function is deleted then the caller Lambda function is invoked
    Given fid not in caller_status
    Given a caller Lambda function has been deployed
    Given the callee Lambda function has been deleted
    When the caller Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function is invoked then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in caller_status
    Given a caller Lambda function has been deployed
    Given the caller Lambda function has been invoked
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in caller_status
    Given a caller Lambda function has been deployed
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    When the caller fails to invoke the callee because the callee has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a caller Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted then a callee Lambda function is deployed
    Given fid not in caller_status
    Given a caller Lambda function has been deployed
    Given the caller has failed to invoke the callee because the callee has been deleted
    When a callee Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee Lambda function is deployed then a caller Lambda function is deployed then the caller Lambda function is invoked
    Given fid not in callee_status
    Given a callee Lambda function has been deployed
    Given a caller Lambda function has been deployed
    When the caller Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee Lambda function is deployed then the callee Lambda function is deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid not in callee_status
    Given a callee Lambda function has been deployed
    Given the callee Lambda function has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function is invoked then the caller fails to invoke the callee because the callee has been deleted
    Given fid not in callee_status
    Given a callee Lambda function has been deployed
    Given the caller Lambda function has been invoked
    When the caller fails to invoke the callee because the callee has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a caller Lambda function is deployed
    Given fid not in callee_status
    Given a callee Lambda function has been deployed
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    When a caller Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: a callee Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted then the callee Lambda function is deleted
    Given fid not in callee_status
    Given a callee Lambda function has been deployed
    Given the caller has failed to invoke the callee because the callee has been deleted
    When the callee Lambda function is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee Lambda function is deleted then a caller Lambda function is deployed then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given fid in callee_status
    Given the callee Lambda function has been deleted
    Given a caller Lambda function has been deployed
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee Lambda function is deleted then a callee Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given fid in callee_status
    Given the callee Lambda function has been deleted
    Given a callee Lambda function has been deployed
    When the caller fails to invoke the callee because the callee has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function is invoked then a caller Lambda function is deployed
    Given fid in callee_status
    Given the callee Lambda function has been deleted
    Given the caller Lambda function has been invoked
    When a caller Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee Lambda function is deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a callee Lambda function is deployed
    Given fid in callee_status
    Given the callee Lambda function has been deleted
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    When a callee Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the callee Lambda function is deleted then the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function is invoked
    Given fid in callee_status
    Given the callee Lambda function has been deleted
    Given the caller has failed to invoke the callee because the callee has been deleted
    When the caller Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function is invoked then a caller Lambda function is deployed then the caller fails to invoke the callee because the callee has been deleted
    Given cfid in caller_status
    Given the caller Lambda function has been invoked
    Given a caller Lambda function has been deployed
    When the caller fails to invoke the callee because the callee has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function is invoked then a callee Lambda function is deployed then a caller Lambda function is deployed
    Given cfid in caller_status
    Given the caller Lambda function has been invoked
    Given a callee Lambda function has been deployed
    When a caller Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function is invoked then the callee Lambda function is deleted then a callee Lambda function is deployed
    Given cfid in caller_status
    Given the caller Lambda function has been invoked
    Given the callee Lambda function has been deleted
    When a callee Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function is invoked then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the callee Lambda function is deleted
    Given cfid in caller_status
    Given the caller Lambda function has been invoked
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    When the callee Lambda function is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function is invoked then the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given cfid in caller_status
    Given the caller Lambda function has been invoked
    Given the caller has failed to invoke the callee because the callee has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a caller Lambda function is deployed then a callee Lambda function is deployed
    Given iid in inv_status
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    Given a caller Lambda function has been deployed
    When a callee Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a callee Lambda function is deployed then the callee Lambda function is deleted
    Given iid in inv_status
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    Given a callee Lambda function has been deployed
    When the callee Lambda function is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the callee Lambda function is deleted then the caller Lambda function is invoked
    Given iid in inv_status
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    Given the callee Lambda function has been deleted
    When the caller Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller Lambda function is invoked then the caller fails to invoke the callee because the callee has been deleted
    Given iid in inv_status
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    Given the caller Lambda function has been invoked
    When the caller fails to invoke the callee because the callee has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then the caller fails to invoke the callee because the callee has been deleted then a caller Lambda function is deployed
    Given iid in inv_status
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    Given the caller has failed to invoke the callee because the callee has been deleted
    When a caller Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a caller Lambda function is deployed then the callee Lambda function is deleted
    Given iid in inv_status
    Given the caller has failed to invoke the callee because the callee has been deleted
    Given a caller Lambda function has been deployed
    When the callee Lambda function is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then a callee Lambda function is deployed then the caller Lambda function is invoked
    Given iid in inv_status
    Given the caller has failed to invoke the callee because the callee has been deleted
    Given a callee Lambda function has been deployed
    When the caller Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the callee Lambda function is deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given iid in inv_status
    Given the caller has failed to invoke the callee because the callee has been deleted
    Given the callee Lambda function has been deleted
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function is invoked then a caller Lambda function is deployed
    Given iid in inv_status
    Given the caller has failed to invoke the callee because the callee has been deleted
    Given the caller Lambda function has been invoked
    When a caller Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @sequence
  Scenario: the caller fails to invoke the callee because the callee has been deleted then the caller Lambda function invokes the "ACTIVE" callee and the call succeeds then a callee Lambda function is deployed
    Given iid in inv_status
    Given the caller has failed to invoke the callee because the callee has been deleted
    Given the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded
    When a callee Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked
