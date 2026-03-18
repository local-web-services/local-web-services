@lambdaneptune @generated
Feature: LambdaNeptune - The Lambda Function Executes A Graph Query Against The Available Cluster And Succeeds

  # Generated from FizzBee spec: lambda_neptune.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given an invocation is "IN_PROGRESS"
    And the Neptune cluster is "AVAILABLE"
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @standard @negative @invocation_succeeds @internal
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then the operation is rejected

  @standard @negative @invocation_succeeds @internal
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds fails when the Neptune cluster is not "AVAILABLE"
    Given an invocation is "IN_PROGRESS"
    And the Neptune cluster is not "AVAILABLE"
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then the operation is rejected
