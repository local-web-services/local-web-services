@lambdaneptune @generated
Feature: LambdaNeptune - The Neptune Cluster Is Stopped

  # Generated from FizzBee spec: lambda_neptune.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @stop_cluster
  Scenario: the Neptune cluster is stopped
    Given the cluster exists
    And the cluster is "AVAILABLE"
    When the Neptune cluster is stopped
    Then the cluster is "STOPPED" and graph queries will be rejected
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @standard @negative @stop_cluster
  Scenario: the Neptune cluster is stopped fails when the cluster does not exist
    Given the cluster does not exist
    When the Neptune cluster is stopped
    Then the operation is rejected

  @standard @negative @stop_cluster @lifecycle @internal
  Scenario: the Neptune cluster is stopped fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When the Neptune cluster is stopped
    Then the operation is rejected
