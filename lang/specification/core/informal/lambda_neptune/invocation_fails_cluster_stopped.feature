@lambdaneptune @generated
Feature: LambdaNeptune - The Lambda Function Fails To Connect Because The Neptune Cluster Is Stopped

  # Generated from FizzBee spec: lambda_neptune.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_cluster_stopped
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped
    Given an invocation is "IN_PROGRESS"
    And the Neptune cluster is "STOPPED"
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then the invocation is "FAILED" with a connection error
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @standard @negative @invocation_fails_cluster_stopped @lifecycle
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then the operation is rejected

  @standard @negative @invocation_fails_cluster_stopped @lifecycle
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped fails when the Neptune cluster is not "STOPPED"
    Given an invocation is "IN_PROGRESS"
    And the Neptune cluster is not "STOPPED"
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then the operation is rejected
