@lambdaneptune @generated
Feature: LambdaNeptune - A Neptune Cluster Is Created

  # Generated from FizzBee spec: lambda_neptune.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a Neptune cluster is created
    Given the cluster does not already exist
    When a Neptune cluster is created
    Then the cluster is "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @guard @negative @create_cluster
  Scenario: a Neptune cluster is created fails when the cluster already exists
    Given the cluster already exists
    When a Neptune cluster is created
    Then the operation is rejected
