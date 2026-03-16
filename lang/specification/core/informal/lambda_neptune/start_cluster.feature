@lambdaneptune @generated
Feature: LambdaNeptune - The Neptune Cluster Is Started

  # Generated from FizzBee spec: lambda_neptune.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @start_cluster
  Scenario: the Neptune cluster is started
    Given the cluster is "STOPPED"
    When the Neptune cluster is started
    Then the cluster is "AVAILABLE" and ready to accept graph queries
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @standard @negative @start_cluster @lifecycle
  Scenario: the Neptune cluster is started fails when the cluster is not "STOPPED"
    Given the cluster is not "STOPPED"
    When the Neptune cluster is started
    Then the operation is rejected
